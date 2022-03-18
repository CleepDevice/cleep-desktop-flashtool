#!/bin/bash

rm -rf dist
mkdir dist

ARCHIVE_WIN=`ls -1 *.zip | grep windows`
echo "Processing $ARCHIVE_WIN..."
unzip -q $ARCHIVE_WIN
cp flash.windows.bat balena-cli/flash.bat
cd balena-cli
zip -q -8 -r ../dist/$ARCHIVE_WIN .
cd ..
rm -rf balena-cli

ARCHIVE_LINUX=`ls -1 *.zip | grep linux`
echo "Processing $ARCHIVE_LINUX..."
unzip -q $ARCHIVE_LINUX
cp flash.linux.sh balena-cli/flash.sh
cd balena-cli
zip -q -8 -r ../dist/$ARCHIVE_LINUX .
cd ..
rm -rf balena-cli


ARCHIVE_MACOS=`ls -1 *.zip | grep mac`
echo "Processing $ARCHIVE_MACOS..."
unzip -q $ARCHIVE_MACOS
ARCHIVE_DARWIN=`echo "${ARCHIVE_MACOS/macOS/darwin}"`
cp flash.darwin.sh balena-cli/flash.sh
cd balena-cli
zip -q -8 -r ../dist/$ARCHIVE_DARWIN .
cd ..
rm -rf balena-cli

