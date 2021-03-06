# This script will prepare level for next user
# Must be run with root priveleges
# Change variables bellow to correct values
TESTUSER="oh"
LEVELNAME="level2"

REQFILE="$LEVELNAME/src/requirements.txt"
HOMEDIR="/home/$TESTUSER"
TESTDIR="$HOMEDIR/$LEVELNAME"

# Cleanup before fresh install
rm -rf "$TESTDIR" && echo "Removing $TESTDIR"
sed -i "\%$TESTUSER ALL= NOPASSWD: /usr/bin/dnf%d" /etc/sudoers && echo "Removing $TESTUSER from sudoers"

# Install
# adding testuser to sudoers
echo "$TESTUSER ALL= NOPASSWD: /usr/bin/dnf" >> /etc/sudoers && echo "Adding $TESTUSER to sudoers"
# installing "broken" version of factorial package
rpm -U --oldpackage "src/factorial-1.0-1.fc29.noarch.rpm" > /dev/null && echo "Installing \"broken\" factorial"

# creating testdir and copying test files
mkdir -p "$TESTDIR"
cd "src"
cp -r factorial factorial-1.1-1.fc29.noarch.rpm build_package.sh rpmbuild/ get_code.sh "$TESTDIR" && echo "Copying factorial related files"
cp -r test/ "$TESTDIR/" && echo "Copying test related files"
cd ../doc
cp -r hints/ README assignment.txt "$TESTDIR" && echo "Copying docs"
cd ..
chown -R "$TESTUSER:" $TESTDIR && echo "Changing level files owner to $TESTUSER"
chown root: "$TESTDIR/get_code.sh" && echo "Changing get_code.sh owner to root"

echo "$LEVELNAME install finished"
