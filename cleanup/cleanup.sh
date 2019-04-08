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
git pull https://github.com/ClosedHouse/"${CONTEST_DIR}".git
chmod -R o-rwx "./${CONTEST_DIR}/.git"
chmod o+rx "./${CONTEST_DIR}"
chmod -R o-w "./${CONTEST_DIR}"
popd

