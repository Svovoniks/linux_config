import re
import subprocess

map = {
    "a":1,
    "s":2,
    "d":3,
    "f":4,
    "g":5,
    "h":6,
    "j":7,
    "k":8,
    "k":9,
    "q":10,
    "w":20,
    "e":30,
    "r":40,
    "t":50,
    "y":60,
    "u":70,
    "i":80,
    "o":90,
    "p":100,
}

while True:
    ln = str(input("Enter brightness > "))

    if ln in map:
        subprocess.run(f"sudo brightnessctl set {map[ln]}%".split())
        continue

    if re.fullmatch(r"set \d+", ln):
        subprocess.run(f"sudo brightnessctl {ln}".split())
        continue

    print("WTF?")


