#!/bin/bash
# 
# Run bnd cli to compile project classes
# 
# @author Tim Lauv

java -jar ../tools/bnd/dist/bnd.jar compile -p "$@"