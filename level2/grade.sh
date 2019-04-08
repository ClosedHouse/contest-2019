#!/usr/bin/bash

# Hide that file somewhere on the system and create an alias to run it
#TODO: nefunguje
cd tests/factorial && RPM_PATH=../../src/math-functions-1.1-0.fc29.noarch.rpm make run && echo "Parada! Heslo je $HESLO" && cd -
