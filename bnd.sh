#!/bin/bash
# 
# Run bnd cli with arguments (if not using per project *.sh in /projects)
# 
# @author Tim Lauv

java -jar ./tools/bnd/dist/bnd.jar "$@"