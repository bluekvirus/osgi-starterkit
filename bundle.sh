#!/bin/bash
# 
# Run bnd cli to build single project and deploy the bundles.
# 
# @author Tim Lauv

DEPLOY_DIR=./runtime/bundle/hot-deploy/apps/
PROJ="$1"

java -jar ./tools/bnd/dist/bnd.jar -b ./subprojects/ build -p $PROJ
mv ./subprojects/$PROJ/generated/*.jar $DEPLOY_DIR