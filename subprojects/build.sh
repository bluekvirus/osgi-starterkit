#!/bin/bash
# 
# Run bnd cli to build project into bundle
# 
# @author Tim Lauv

java -jar ../tools/bnd/dist/bnd.jar build -p "$@"