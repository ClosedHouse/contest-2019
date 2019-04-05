#!/usr/bin/bash

# Hide that file somewhere on the system and create an alias to run it
python3 -m unittest test_math.py && echo "Parada! Heslo je $HESLO"
