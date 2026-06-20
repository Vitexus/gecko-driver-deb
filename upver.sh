#!/bin/bash

rm -f debian/changelog.dch

# Get the latest release version via redirect (avoids GitHub API rate limits)
LATEST_VERSION=$(curl -sI https://github.com/mozilla/geckodriver/releases/latest \
    -H 'User-Agent: gecko-driver-deb-builder' \
    | grep -i '^location:' \
    | sed 's|.*/tag/v||' \
    | tr -d '[:space:]\r')

if [ -z "$LATEST_VERSION" ] || [ "$LATEST_VERSION" = "null" ]; then
    echo "ERROR: Failed to detect latest geckodriver version"
    exit 1
fi

echo Fixing package version to $LATEST_VERSION

dch -r "$LATEST_VERSION"
dch -v "$LATEST_VERSION" "New upstream release $LATEST_VERSION"
