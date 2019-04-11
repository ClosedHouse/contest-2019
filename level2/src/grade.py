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

    # string indicating tests successful run of the tests -> OVERALL RESULT: PASS
    cs = d("ƆƍżƉŸƃƃŗƉżƊƌƃƋűŗƇŸƊƊ")
    # c as 'code' -> oh19-IDDQD
    c = d("ƦƟŨŰƖƀŻŻƈŻ")
    # chl as in check list, strings with asserts that must be present in the test:
    # rlAssertEquals "Calculate 0!" $(factorial 0) 1
    # rlRun "factorial -1" 1-255 "Factorial is not defined for negative integers"
    # rlRun "factorial foo 2>&1 | grep \"Argument does not seem to be an integer.\"" 10
    chl = [d("ƩƣŸƪƪƜƩƫżƨƬƘƣƪŗřźƘƣƚƬƣƘƫƜŗŧŘřŗśşƝƘƚƫƦƩƠƘƣŗŧŠŗŨ"), d("ƩƣƉƬƥŗřƝƘƚƫƦƩƠƘƣŗŤŨřŗŨŤũŬŬŗřŽƘƚƫƦƩƠƘƣŗƠƪŗƥƦƫŗƛƜƝƠƥƜƛŗƝƦƩŗƥƜƞƘƫƠƭƜŗƠƥƫƜƞƜƩƪř"), d("ƩƣƉƬƥŗřƝƘƚƫƦƩƠƘƣŗƝƦƦŗũŵŝŨŗƳŗƞƩƜƧŗƓřŸƩƞƬƤƜƥƫŗƛƦƜƪŗƥƦƫŗƪƜƜƤŗƫƦŗƙƜŗƘƥŗƠƥƫƜƞƜƩťƓřřŗŨ")]
    # f as 'fail' -> ::   RESULT: FAIL
    f = d("űűŗŗŗƉżƊƌƃƋűŗŽŸƀƃ")
    # sp as 'subprocess'
    sp = subprocess.run("make", capture_output=True)
    # r as 'result'
    r = str(sp.stderr)

    with open('runtest.sh', 'r') as fh:
        cont = fh.read()

    # Check if test contains necessary asserts (protections against just
    # deleting/commenting out failing asserts)
    for ch in chl:
        reg = "^\s*" + re.escape(ch)
        if re.search(reg, cont, re.MULTILINE) is None:
            print ("Line:\n" + ch + "\nis missing from test, put it back.")
            exit(255)

    fc = len(re.findall(f, r))
    if fc == 1:
        print("1 test phase is failing. Fix it to recieve the level code.")
        exit(1)
    elif fc > 1:
        print(str(fc) + " test phases are failing. Fix them to recieve the level code." )
        exit(fc)

    # Final check if everything passes
    mcs = re.search(cs, r)
    if not mcs:
        print("It seems some tests are still failing. Try to fix the issues.")
        exit(127)
    else:
        print("Congratulation! You managed to fix the test and the package.\nLevel code is: " + c)
        exit(0)


if __name__ == "__main__":
    main()
