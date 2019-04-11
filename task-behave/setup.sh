#!/bin/bash

TARGETDIR=/home/oh/level3

# install behave
#dnf -y install python3-behave
# compile and install task-behave.py
if ! test -f /usr/bin/task-behave; then
    echo "Compiling task-behave"
    python3 -m compileall task-behave.py
    echo "Installing task-behave"
    cp __pycache__/task-behave.cpython-*.pyc /usr/libexec/task-behave.pyc
    rm -rf __pycache__
    cat > /usr/bin/task-behave <<EOF
#!/bin/bash
python3 /usr/libexec/task-behave.pyc \$@
EOF
    chmod a+x /usr/bin/task-behave
fi
if ! test -f /var/lib/misc/task-behave.db; then
    echo "Initializing db"
    task-behave --init-db
fi
echo "Cleaning up target directory"
rm -rf $TARGETDIR/*
echo "Initializing target directory"
task-behave --setup $TARGETDIR
chown -R oh.oh $TARGETDIR
echo "Setup completed!"
