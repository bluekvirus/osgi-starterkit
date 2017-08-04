#!/bin/bash
# 
# Run bnd cli to add new project
# 
# @author Tim Lauv
# @created 2017.08.01

# Create a default bnd sub project in the bnd workspace
java -jar ./tools/bnd/dist/bnd.jar -b ./subprojects add project "$1"

# Create gradle sub project layout (customized in root build.gradle)
touch ./subprojects/"$1"/build.gradle
mkdir ./subprojects/"$1"/src/java
mkdir ./subprojects/"$1"/src/scala
mkdir ./subprojects/"$1"/src/resources
mkdir ./subprojects/"$1"/test/java
mkdir ./subprojects/"$1"/test/scala
mkdir ./subprojects/"$1"/test/resources

# Add the gradle sub project to root build
echo -e "\ninclude \"$1\"" >> ./settings.gradle
echo -e "project(\":$1\").projectDir = file(\"subprojects/$1\")" >> ./settings.gradle
gradle :$1:idea

echo ""
echo "============="
echo "Do NOT forget to include $@ in /settings.gradle"
echo "============="
echo ""