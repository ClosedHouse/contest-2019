#!/bin/bash

if [[ $UID != 0 ]]; then
    echo 'you need to be root! became one!'
    exit 1
fi

CONTEST_DIR="contest-2019"
pushd /home/oh/
echo -n > .bash_history
rm -rf /var/tmp/*

# can fail without issues
pushd /root
git pull https://github.com/ClosedHouse/"${CONTEST_DIR}".git

pushd "${CONTEST_DIR}"
    bash ./install_level2.sh
popd

pushd "${CONTEST_DIR}/task-behave"
    bash ./setup.sh
popd

popd

popd

