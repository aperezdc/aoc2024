#! /usr/bin/env python
# SPDX-License-Identifier: MIT

from sys import stdin

def solve(val, eqn):
    if len(eqn) == 1:
        return eqn[0] == val
    else:
        return solve(val / eqn[-1], eqn[:-1]) or solve(val - eqn[-1], eqn[:-1])


result = 0
for line in stdin.readlines():
    testval, eqn = line.split(":", maxsplit=1) 
    testval = int(testval)
    eqn = tuple(map(int, eqn.split()))
    if solve(testval, eqn):
        result += testval

print(result)
