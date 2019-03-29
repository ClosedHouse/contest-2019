#!/bin/bash

set -o pipefail

# Setup
cd ./rpmbuild
package=$(grep "Name:" SPECS/math_functions.spec  | awk -F ' ' '{ print  $2 }')
version=$(grep "Version:" SPECS/math_functions.spec  | awk -F ' ' '{ print  $2 }')
dir_name="$package-$version"
tar_name="$package-$version.tar.gz"

# Prepare Sources
cd ./SOURCES
rm -rf ./*
mkdir "$dir_name"
cp ../../factorial ../../fibonacci "./$dir_name"
tar cvzf "$tar_name" "$dir_name"
cd ..

# Build
rpmbuild -ba SPECS/math_functions.spec --define "_topdir $PWD"
cp RPMS/noarch/* ../

# Clean up
rm -rf ./BUILD ./BUILDROOT ./RPMS ./SRPMS
