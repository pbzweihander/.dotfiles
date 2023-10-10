#!/usr/bin/python
import re
import sys


BUS_RE = re.compile(r"^/:\s+Bus (\d+?)\.")
PORT_RE = re.compile(r"^\s+\|__ Port (\d+?): Dev \d+, If \d+, Class=(.+?), Driver=(.+?),")

bus = None

for line in sys.stdin.readlines():
    match = BUS_RE.match(line)
    if match:
        bus = int(match.group(1))

    match = PORT_RE.match(line)
    if match:
        port = int(match.group(1))
        c = match.group(2)
        driver = match.group(3)

        print(f"{bus}-{port}", c, driver)
