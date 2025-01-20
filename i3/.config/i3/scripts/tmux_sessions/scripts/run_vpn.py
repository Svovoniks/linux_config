import os
import time
import configparser
from os.path import join
import subprocess

VPN_CONFIG_COUNT = 3


def turn_off() -> bool:
    success = False
    for i in range(VPN_CONFIG_COUNT):
        try:
            res = subprocess.run(['sudo', 'wg-quick', 'down', f'wg{i}'], capture_output=True)
            if 'is not' not in str(res.stdout):
                success = True
        except:
            continue

    return success

def turn_on() -> bool:
    for i in range(VPN_CONFIG_COUNT):

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

        print(f'stopped wg{i}')
        subprocess.run(['sudo', 'wg-quick', 'down', f'wg{i}'], capture_output=True)

    return False

def attempt(action) -> bool:
    for _ in range(5):
        if action():
            return True
    return False

if __name__ == '__main__':
    if 'sys' not in os.environ:
        print('no sys in sight')
        exit(1)
    sys_loc = os.environ['sys']

    config_file = join(sys_loc, 'auto', 'sys_state.txt')

    config = configparser.ConfigParser()
    read = config.read(config_file)

    if len(read) == 0 or 'vpn' not in config:
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
            config['vpn']['is_on'] = 'yes'


    with open(config_file, 'w') as file:
        config.write(file)


