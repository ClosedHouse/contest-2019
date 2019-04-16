#!/bin/bash

LEVEL_DIR="/home/oh/level1/"

rm -rf "${LEVEL_DIR}"
mkdir -p "${LEVEL_DIR}"

for f in bruteforce.sh cve cve.c exploit.c exploit README; do
    cp ./$f "${LEVEL_DIR}"
done

chown -R oh:oh "${LEVEL_DIR}"
