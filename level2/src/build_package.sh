#!/bin/bash

set -o pipefail

spec_file="SPECS/factorial.spec"

# Setup
cd ./rpmbuild
package=$(grep "Name:" $spec_file  | awk -F ' ' '{ print  $2 }')
current_version=$(grep "Version:" $spec_file | awk -F ' ' '{ print  $2 }')
# increment version and edit spec file
x=${current_version%.*}
y=${current_version#*.}
y=$((y+1))
next_version="$x.$y"
sed -i -e "s/Version:    $current_version/Version:    $next_version/g" "$spec_file"

dir_name="$package-$next_version"
tar_name="$package-$next_version.tar.gz"

# Prepare Sources
rm -rf ./SOURCES
mkdir ./SOURCES
cd ./SOURCES
mkdir "$dir_name"
cp ../../factorial "./$dir_name"
tar cvzf "$tar_name" "$dir_name"
cd ..

# Build
rpmbuild -ba $spec_file --define "_topdir $PWD"
exit_code=$?
if [[ "$exit_code" -eq 0 ]]; then
    cp RPMS/noarch/* ../
    echo -e "\nSuccessfuly created new package. Don't forget to install it before running the test!"
else
    echo "Something went wrong"
fi

# Clean up
rm -rf ./BUILD ./BUILDROOT ./RPMS ./SRPMS ./SOURCES
exit "$exit_code"
