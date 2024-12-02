#! /usr/bin/env python
#
# SPDX-License-Identifier: MIT

def parse(fd):
    a = []
    b = []
    for line in fd.readlines():
        na, nb = map(int, line.split())
        a.append(na)
        b.append(nb)
    return a, b

def calc(a, b):
    d = 0
    a.sort()
    b.sort()
    for na, nb in zip(a, b):
        d += abs(na - nb)
    return d

if __name__ == "__main__":
    import sys
    print(calc(*parse(sys.stdin)))
