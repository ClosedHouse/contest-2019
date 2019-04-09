#!/usr/bin/python3
import os
import re
import subprocess


# Decode funcion
def d(s):
    r = ""
    for c in s:
        r += chr(ord(c) - 311)
    return r


def main():
    os.chdir("test")

    # correct string to be contained in beakerlib log
    cs = d("ƆƍżƉŸƃƃŗƉżƊƌƃƋűŗƇŸƊƊ")
    # c as 'code'
    c = d("ƦƟŨŰŤƀŻŻƈŻ")
    # sp as 'subprocess'
    sp = subprocess.run("make", capture_output=True)
    # r as 'result'
    r = str(sp.stderr)

    # Check if winning conditions are met (mainly contains OVERALL RESULT: PASS, but also
    # if test wasn't tampered with) <- TODO
    mcs = re.search(cs, r)
    if not mcs:
        print("It seems some tests are still failing. Try to fix the issues.")
        exit(1)
    else:
        print("TODO congratz, code is: " + c)
        exit(0)


if __name__ == "__main__":
    main()
