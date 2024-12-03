#! /usr/bin/env python
#
# SPDX-License-Identifier: MIT

from itertools import pairwise
from functools import reduce

def is_valid_down_step(valid, step):
    return valid and (-3 <= step < 0)

def is_valid_up_step(valid, step):
    return valid and (0 < step <= 3)

def is_valid_report(items):
    steps = map(lambda p: p[0] - p[1], pairwise(items))
    first = next(steps)
    if first < 0:
        return reduce(is_valid_down_step, steps, is_valid_down_step(True, first))
    if first > 0:
        return reduce(is_valid_up_step, steps, is_valid_up_step(True, first))
    return False

if __name__ == "__main__":
    import sys
    nvalid = 0
    for line in sys.stdin.readlines():
        steps = map(int, line.split())
        if is_valid_report(steps):
            nvalid += 1
    print(nvalid)
