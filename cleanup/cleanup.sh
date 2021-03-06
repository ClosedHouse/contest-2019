#!/bin/bash

if [[ $UID != 0 ]]; then
    echo 'you need to be root! became one!'
    exit 1
fi

CONTEST_DIR="contest-2019"
pushd /home/oh/
echo -n > .bash_history
rm -rf /var/tmp/*
popd

# can fail without issues
pushd /root
git pull https://github.com/ClosedHouse/"${CONTEST_DIR}".git

pushd "${CONTEST_DIR}/level2"
    bash ./install.sh
popd

pushd "${CONTEST_DIR}/task-behave"
    bash ./setup.sh
popd

pushd "${CONTEST_DIR}/level1"
    bash ./install.sh
popd

popd

