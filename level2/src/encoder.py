#!/usr/bin/python3

import sys


def encode(s):
    r = ""
    for c in s:
        r += chr(ord(c) + 311)
    return r


def d(s):
    r = ""
    for c in s:
        r += chr(ord(c) - 311)
    return r

def main():
    res = ""
    to_encode = sys.argv[1]
    print(encode(to_encode))


    #to_decode = "ƦƟŨŰŤƀŻŻƈŻ"
    #print(d(to_decode))

if __name__ == "__main__":
    main()
