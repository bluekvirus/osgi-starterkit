#!/bin/bash
#
# Fetch a bnd release and build it.
# (see https://github.com/bndtools/bnd)
# 
# @author Tim Lauv

VERSION=3.4.0.RC1
REPO=https://github.com/bndtools/bnd

# fetch
rm -rf ./*$VERSION
curl -O -L $REPO/archive/$VERSION.zip # follow the redirect
unzip -o ./$VERSION.zip
rm -f ./$VERSION.zip

# build
cd ./bnd-$VERSION
./gradlew

# see dist/bundles/biz/aQute/bnd after build done. (manually copy them)
# biz.aQute.bnd (cli) --> ./dist/bnd.jar
# biz.aQute.bndlib (lib) --> ./dist/biz.aQute.bndlib-<version>.jar