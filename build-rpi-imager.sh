#!/bin/bash

rm -rf dist
rm -rf flashtool
mkdir dist

# imager-1.9.0.exe
ARCHIVE_WIN=`ls -1 *.exe | grep imager`
echo "Processing $ARCHIVE_WIN..."
7z x -oflashtool $ARCHIVE_WIN > /dev/null
cp flash.windows.bat flashtool/flash.bat
cd flashtool
touch .rpi-imager
zip -q -8 -Zb -r ../dist/flashtool-windows-x64.zip .
cd ..
rm -rf flashtool

# Raspberry_Pi_Imager-1.9.0-x86_64.AppImage
ARCHIVE_LINUX=`ls -1 *.AppImage | grep Imager`
echo "Processing $ARCHIVE_LINUX..."
7z x -oflashtool $ARCHIVE_LINUX > /dev/null
cp flash.linux.sh flashtool/flash.sh
cd flashtool
touch .rpi-imager
ln -s usr/bin/rpi-imager
zip -q -8 -Zb -r ../dist/flashtool-linux-x64.zip .
cd ..
rm -rf flashtool

# Raspberry.Pi.Imager-1.9.0.dmg.zip
ARCHIVE_MACOS=`ls -1 *.dmg.zip | grep Imager`
echo "Processing $ARCHIVE_MACOS..."
7z x -oflashtool -snld $ARCHIVE_MACOS > /dev/null
cp flash.macos.sh flashtool/Contents/flash.sh
cd flashtool/Contents
touch .rpi-imager
ln -s MacOS/rpi-imager
zip -q -8 -Zb -r ../../dist/flashtool-macos-arm64.zip .
cd ../..
rm -rf flashtool

