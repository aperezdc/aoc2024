#! /usr/bin/env python
# SPDX-License-Identifier: MIT

from sys import stdin

def solve1(val, eqn):
    if len(eqn) == 1:
        return eqn[0] == val

    return solve1(val / eqn[-1], eqn[:-1]) or solve1(val - eqn[-1], eqn[:-1])

from operator import add, mul

def cat(a: int, b: int) -> int:
    return int(f"{a:d}{b:d}")

def solve2(val, eqn):
    if len(eqn) == 1:
        return eqn[0] == val

    for op in (add, mul, cat):
        t = op(eqn[0], eqn[1])
        if solve2(val, (t,) + eqn[2:]):
            return True

    return False

result1 = 0
result2 = 0
for line in stdin.readlines():
    testval, eqn = line.split(":", maxsplit=1) 
    testval = int(testval)
    eqn = tuple(map(int, eqn.split()))
    if solve1(testval, eqn):
        result1 += testval
    if solve2(testval, eqn):
        result2 += testval

print("Part 1:", result1)
print("Part 2:", result2)
