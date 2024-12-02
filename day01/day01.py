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

def calc1(a, b):
    d = 0
    for na, nb in zip(a, b):
        d += abs(na - nb)
    return d

def calc2(a, b):
    blen = len(b)
    alen = len(a)
    d = i = j = 0
    while i < alen:
        # Current element from the left column
        cur = a[i]

        # How many of current elements?
        ncur = 0
        while i < alen and cur == a[i]:
            ncur += 1
            i += 1

        # Current element cannot be found, go to the next.
        if j >= blen or cur < b[j]:
            continue

        # Skip ahead while we don't find the element on the right column.
        while j < blen and cur > b[j]:
            j += 1

        # Find how many times it's repeated in the right column.
        nreps = 0
        while j < blen and cur == b[j]:
            nreps += 1
            j += 1

        d += cur * ncur * nreps

    return d

if __name__ == "__main__":
    import sys
    a, b = parse(sys.stdin)
    a.sort()
    b.sort()
    print("Part 1:", calc1(a, b))
    print("Part 2:", calc2(a, b))
