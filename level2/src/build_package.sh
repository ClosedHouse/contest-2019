#!/bin/bash

set -o pipefail

spec_file="SPECS/factorial.spec"

# Setup
cd ./rpmbuild
package=$(grep "Name:" $spec_file  | awk -F ' ' '{ print  $2 }')
version=$(grep "Version:" $spec_file | awk -F ' ' '{ print  $2 }')
dir_name="$package-$version"
tar_name="$package-$version.tar.gz"

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
cp RPMS/noarch/* ../

# Clean up
rm -rf ./BUILD ./BUILDROOT ./RPMS ./SRPMS ./SOURCES
