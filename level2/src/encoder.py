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
    encoded = encode(to_encode)
    print(encoded)

    decoded = d(encoded)
    print(decoded)


if __name__ == "__main__":
    main()
