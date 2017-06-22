#!/bin/bash
# 
# Run bnd cli to add new project
# 
# @author Tim Lauv

cd ./subprojects
java -jar ../tools/bnd/dist/bnd.jar add project "$@"