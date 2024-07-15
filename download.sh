#!/bin/bash

# Get the latest release version
LATEST_VERSION=$(curl -s https://api.github.com/repos/mozilla/geckodriver/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")')

# Determine the current architecture
ARCH=$(uname -m)
if [ "$ARCH" == "x86_64" ]; then
    ARCH="linux64"
elif [ "$ARCH" == "aarch64" ]; then
    ARCH="arm64"
else
    ARCH="linux32"
fi


# Construct the download URL
URL="https://github.com/mozilla/geckodriver/releases/download/$LATEST_VERSION/geckodriver-$LATEST_VERSION-$ARCH.tar.gz"

# Download the package
mkdir  -p debian/tmp
rm -rf debian/tmp/*
wget "$URL" -O debian/tmp/geckodriver.tar.gz
# Unpack the downloaded file
tar -xf debian/tmp/geckodriver.tar.gz -C debian/tmp
# Remove the tarball
rm debian/tmp/geckodriver.tar.gz
