#!/bin/bash

rm -f debian/changelog.dch

# Get the latest release version
LATEST_VERSION=$(curl -s https://api.github.com/repos/mozilla/geckodriver/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")' | sed 's/^v//')

echo Fixing package version to  $LATEST_VERSION

dch -r $LATEST_VERSION
dch -v $LATEST_VERSION "New upstream release $LATEST_VERSION"
