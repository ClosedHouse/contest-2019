#!/bin/bash

# This script runs exploit with different number as a argument.
Example:
./exploit 12

# Tento skript spousti stale dokola exploit s rozdilnym cislem jako jeho argument.
Priklad:
./exploit 12

# Maybe we need more tryies to achieve our goal. You should try seq command in terminal.
# Mozna potrebujeme vice pokusu na nalezeni magickeho cisla. Muzete vyzkouset, co dela prikaz seq v terminalu

magic_bytes=$(seq 1 63)

# run program magic_bytes times
# spusti program tolikrat, kolik je cisel v magic_bytes
for magic_number in $magic_bytes; do
    echo "Trying magic number: $magic_number"
    echo "Zkousim magicke cislo: $magic_number"
    ./exploit $magic_byte
done
