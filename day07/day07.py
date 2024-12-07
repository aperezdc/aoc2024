#! /usr/bin/env python
# SPDX-License-Identifier: MIT

from sys import stdin
from operator import add, mul

def cat(a: int, b: int) -> int:
    return int(f"{a:d}{b:d}")

def solve(operators, val, eqn):
    if len(eqn) == 1:
        return eqn[0] == val

    for op in operators:
        t = op(eqn[0], eqn[1])
        if solve(operators, val, (t,) + eqn[2:]):
            return True

    return False

OPERATORS_PART1 = (add, mul)
OPERATORS_PART2 = (add, mul, cat)

result1 = 0
result2 = 0
for line in stdin.readlines():
    testval, eqn = line.split(":", maxsplit=1) 
    testval = int(testval)
    eqn = tuple(map(int, eqn.split()))
    if solve(OPERATORS_PART1, testval, eqn):
        result1 += testval
    if solve(OPERATORS_PART2, testval, eqn):
        result2 += testval

print("Part 1:", result1)
print("Part 2:", result2)
