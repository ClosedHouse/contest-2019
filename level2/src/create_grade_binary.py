#!/usr/bin/python3

# Quite "creative" solution, credit goes partially to lzachar

import os
import py_compile
import shutil


bash_string = """#!/bin/bash
tail -c +116 $0 > /tmp/grade.tmp
python3 /tmp/grade.tmp
exit_code=$?
rm /tmp/grade.tmp
exit $exit_code\n"""


def main():
    py_compile.compile("grade.py")
    os.chdir("__pycache__")
    with open("grade.cpython-37.pyc", 'rb') as fhbin:
        content = fhbin.read()
        content = bash_string.encode() + content

    os.chdir('..')
    with open("grade.sh", 'wb') as fhsh:
        fhsh.write(content)

    os.chmod("grade.sh", 0o755)
    shutil.rmtree("__pycache__")
    exit(0)


if __name__ == "__main__":
    main()
