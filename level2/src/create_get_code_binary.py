#!/usr/bin/python3

# Quite "creative" solution, credit goes partially to lzachar

import os
import py_compile
import shutil


bash_string = """#!/bin/bash
tail -c +125 $0 > /tmp/get_code.tmp
python3 /tmp/get_code.tmp
exit_code=$?
rm /tmp/get_code.tmp
exit $exit_code\n"""


def main():
    py_compile.compile("get_code.py")
    os.chdir("__pycache__")
    with open("get_code.cpython-37.pyc", 'rb') as fhbin:
        content = fhbin.read()
        content = bash_string.encode() + content

    os.chdir('..')
    with open("get_code.sh", 'wb') as fhsh:
        fhsh.write(content)

    os.chmod("get_code.sh", 0o755)
    shutil.rmtree("__pycache__")
    exit(0)


if __name__ == "__main__":
    main()
