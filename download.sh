#!/bin/bash

LATEST_URL=$(wget -qO- https://api.github.com/repos/mozilla/geckodriver/releases/latest | jq -r '.assets[0].browser_download_url')

wget ${LATEST_URL} -O geckodriver.tar.gz
tar -xvzf geckodriver.tar.gz
mkdir debian/tmp
mv geckodriver debian/tmp
rm geckodriver.tar.gz


