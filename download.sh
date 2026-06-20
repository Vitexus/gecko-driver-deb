#!/bin/bash

# Get the latest release version via redirect (avoids GitHub API rate limits)
LATEST_VERSION=$(curl -sI https://github.com/mozilla/geckodriver/releases/latest \
    -H 'User-Agent: gecko-driver-deb-builder' \
    | grep -i '^location:' \
    | sed 's|.*/tag/||' \
    | tr -d '[:space:]\r')

if [ -z "$LATEST_VERSION" ]; then
    echo "ERROR: Failed to detect latest geckodriver version"
    exit 1
fi

# Determine the current architecture
ARCH=$(uname -m)
if [ "$ARCH" = "x86_64" ]; then
    ARCH_SUFFIX="linux64"
elif [ "$ARCH" = "aarch64" ]; then
    ARCH_SUFFIX="linux-aarch64"
else
    echo "ERROR: Unsupported architecture: $ARCH (linux32 builds discontinued since 0.37.0)"
    exit 1
fi

# Construct the download URL
URL="https://github.com/mozilla/geckodriver/releases/download/${LATEST_VERSION}/geckodriver-${LATEST_VERSION}-${ARCH_SUFFIX}.tar.gz"

# Download the package
mkdir -p debian/tmp
rm -f debian/tmp/geckodriver.tar.gz debian/tmp/geckodriver
wget "$URL" -O debian/tmp/geckodriver.tar.gz
# Unpack the downloaded file
tar -xf debian/tmp/geckodriver.tar.gz -C debian/tmp
# Remove the tarball
rm debian/tmp/geckodriver.tar.gz
