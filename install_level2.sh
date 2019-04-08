# This script will prepare level for next user
# Must be run with root priveleges
# Change variables bellow to correct values
TESTUSER="testuser"
LEVELNAME="level2"

REQFILE="$LEVELNAME/src/requirements.txt"
HOMEDIR="/home/$TESTUSER"
TESTDIR="$HOMEDIR/$LEVELNAME"

# Cleanup before fresh install
rm -rf "$TESTDIR"
sed -i "\%$TESTUSER ALL= NOPASSWD: /usr/bin/dnf%d" /etc/sudoers

# Install
# adding testuser to sudoers
echo "$TESTUSER ALL= NOPASSWD: /usr/bin/dnf" >> /etc/sudoers

# creating testdir and copying test files
mkdir -p "$TESTDIR"
cd "$LEVELNAME/src"
cp -r factorial* build_package.sh rpmbuild/ "$TESTDIR"
cp -r tests/factorial "$TESTDIR/test"
cd ../doc
# TODO docs
cd ..

echo "Done"
