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
dnf remove -y factorial

# Install
# adding testuser to sudoers
echo "$TESTUSER ALL= NOPASSWD: /usr/bin/dnf" >> /etc/sudoers
# installing "broken" version of factorial package
dnf install -y "$LEVELNAME/src/factorial-1.0-1.fc29.noarch.rpm"

# creating testdir and copying test files
mkdir -p "$TESTDIR"
cd "$LEVELNAME/src"
cp -r factorial* build_package.sh rpmbuild/ grade "$TESTDIR"
cp -r tests/factorial "$TESTDIR/test"
cd ../doc
# TODO docs
cd ..

echo "$LEVELNAME install finished"
