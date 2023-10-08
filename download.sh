#!/bin/bash
LATEST_URL=$(wget -qO- https://api.github.com/repos/mozilla/geckodriver/releases/latest | grep -oP '"browser_download_url": "\K\(.*?linux64\.tar\.gz\)' | head -1)

echo $LATEST_URL

wget "${LATEST_URL}" -O geckodriver.tar.gz
tar -xvzf geckodriver.tar.gz 
mkdir debian/tmp
mv geckodriver debian/tmp
rm geckodriver.tar.gz


