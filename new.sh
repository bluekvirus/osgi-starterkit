#!/bin/bash
# 
# Run bnd cli to add new project
# 
# @author Tim Lauv

java -jar ./tools/bnd/dist/bnd.jar -b ./subprojects add project "$1"
touch ./subprojects/"$1"/build.gradle
echo -e "\ninclude \"$1\"" >> ./subprojects/settings.gradle

echo ""
echo "============="
echo "Do NOT forget to include $@ in /subprojects/settings.gradle"
echo "============="
echo ""