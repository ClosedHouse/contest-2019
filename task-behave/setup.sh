#!/bin/bash

# compile task-behave.py
python -m compileall task-behave.py
cp __pycache__/task-behave.cpython-*.pyc /usr/libexec/task-behave.pyc
rm -rf __pycache__
cat > /usr/bin/task-behave <<EOF
#!/bin/bash
python3 /usr/libexec/task-behave.pyc \$@
EOF
chmod a+x /usr/bin/task-behave
task-behave --init-db
echo Setup completed! To remove installed files run:
echo   \# ./cleanup.sh
echo 
echo To initialize files for the behave exercise in directory DIR run: 
echo   \# task-behave --setup DIR

