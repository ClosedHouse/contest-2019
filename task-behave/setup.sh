#!/bin/bash

TARGETDIR=/home/oh/level3

# install behave
#dnf -y install python3-behave
# compile and install task-behave.py
echo "Compiling task-behave"
[ -f /usr/bin/task-behave ] && rm -f /usr/bin/task-behave
python3 -m compileall task-behave.py
echo "Installing task-behave"
cp __pycache__/task-behave.cpython-*.pyc /usr/libexec/task-behave.pyc
rm -rf __pycache__
cat > /usr/bin/task-behave <<EOF
#!/bin/bash
python3 /usr/libexec/task-behave.pyc \$@
EOF
chmod a+x /usr/bin/task-behave
echo "Initializing db"
[ -f /var/lib/misc/task-behave.db ] && rm -f /var/lib/misc/task-behave.db
task-behave --init-db
echo "Cleaning up target directory"
rm -rf $TARGETDIR/*
echo "Initializing target directory"
task-behave --setup $TARGETDIR
chown -R oh.oh $TARGETDIR
echo "Setup completed!"
