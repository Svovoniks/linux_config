import os
import time
import configparser
from os.path import join
import subprocess
import signal

VPN_CONFIG_COUNT = 3
STOP = False


def turn_off() -> bool:
    for i in range(VPN_CONFIG_COUNT):
        try:
            subprocess.run(['sudo', 'wg-quick', 'down', f'wg{i}'], capture_output=True)
        except:
            continue

    return True

def turn_on() -> bool:
    for i in range(VPN_CONFIG_COUNT):
        if STOP:
            return False

        try: subprocess.run(['sudo', 'wg-quick', 'down', f'wg{i}'], capture_output=True)
        except: pass

        try:
            subprocess.run(['sudo', 'wg-quick', 'up', f'wg{i}'], capture_output=True, timeout=0.2)
        except:
            try: subprocess.run(['sudo', 'wg-quick', 'down', f'wg{i}'], capture_output=True)
            except: pass
            print(f'fail wg{i}')

            continue

        print(f'started wg{i}')
        for _ in range(5):
            if STOP:
                break
            show_res = None
            try:
                show_res = subprocess.run(['sudo', 'wg', 'show', f'wg{i}'], capture_output=True)
            except:
                continue

            if 'KiB received' in str(show_res.stdout) or 'MiB received' in str(show_res.stdout) or 'GiB received' in str(show_res.stdout):
                print(f'check successful')
                return True

            print(f'check failed')
            time.sleep(1)

        try:
            subprocess.run(['sudo', 'wg-quick', 'down', f'wg{i}'], capture_output=True)
            print(f'stopped wg{i}')
        except:
            print(f'failed to stop wg{i}')

    return False

def attempt(action) -> bool:
    for _ in range(5):
        if STOP:
            return False

        if action():
            return True
    return False


def stop():
    global STOP
    STOP = True

if __name__ == '__main__':
    signal.signal(signal.SIGINT, lambda _, __: stop())

    if 'sys' not in os.environ:
        print('no sys in sight')
        exit(1)
    sys_loc = os.environ['sys']

    config_file = join(sys_loc, 'auto', 'sys_state.txt')

    config = configparser.ConfigParser()
    read = config.read(config_file)

    if len(read) == 0:
        config = configparser.ConfigParser()
        config['vpn'] = {'is_on': 'no'}

    if config['vpn']['is_on'] == 'no':
        if attempt(turn_on):
            print('Vpn is ON')
            config['vpn']['is_on'] = 'yes'
        else:
            print("Couldn't turn on")
            config['vpn']['is_on'] = 'no'
    else:
        if attempt(turn_off):
            print('Vpn is OFF')
            config['vpn']['is_on'] = 'no'
        else:
            print("Couldn't turn off")
            config['vpn']['is_on'] = 'no'


    with open(config_file, 'w') as file:
        config.write(file)


