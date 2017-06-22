# OSGI Starter-Kit
Bare minimum starting point for OSGI based web apps.


## Runtime
Apache Felix Framework [5.6.4](http://felix.apache.org/downloads.cgi)


### Default bundles
- Main + Resolver + Framework (`/bin/felix.jar` itself)
- Bundle Repository
- Gogo Runtime
- Gogo Command
- Gogo JLine (replaces Gogo Shell, deps: jline, jansi)

### Extra (required) bundles
- Configuration Admin
- Event Admin
- HTTP Servlet 3.0 API
- HTTP Service Jetty (:8000/)
- SCR (Declarative Services)
- Log

### Extra (optional) bundles
- [Web Console](http://felix.apache.org/documentation/subprojects/apache-felix-web-console.html#configuration) (:8000/console/, deps: commons-io, commons-fileupload)
- BND bndlib (deps: slf4j-api, slf4j-simple)
- ... (sub project bundles under `/runtime/bundle/`)

### Config
See `/runtime/conf/config.properties` for comments. It configs both Framework and the other bundles loaded in the OSGI runtime.


## Custom bundles
Create sub projects under `/subprojects` (a **bnd workspace**) and build your custom bundles (**bnd projects**) within them. Deploy into `/runtime/bundle/` to activate them. Other than the `subprojects/cnf` folder there any other folder should be considered bnd project as well as a **Module** in the **IntelliJ IDEA** IDE project. See below for how to add a new bnd project as IntelliJ IDEA Module. 

This is to use its awesome auto code-completion/import support with easy `*.jar` dependencies management (e.g search and download from Maven Central) during code development phase. Note that the bnd build tool supports pulling jars from Maven (through bnd repos and Maven coordinates set under `/cnf/ext`), however, it doesn't know which one to include in the build path automatically in the `bnd.bnd` file for each of the project. We will have to be suggested by the IDE first.

### IDE support
We recommend using the [**IntelliJ IDEA CE**](https://www.jetbrains.com/idea/download/) and treat bnd projects as **Modules**.

### Scaffolding
run `./+new.sh <name>` to create a new bnd project to produce OSGI bundles (both contract API and Provider). After getting the project folder (should contain 1 `/src` folder), under IntelliJ IDEA go to **Project Structure**--> **Modules** --> **+** --> **Import Module** --> select the folder under `/subprojects/<name>` --> **Create module from existing source**. The sub project should appear in your **1:Project** tab in the IDE.

You can change the compile output path of the newly added Module to point to its own `/bin` and `/bin_test` folder. This is optional, as we will not use the IDE to build sub project OSGI bundles. 

### Build
...


## Run
Call `./start.sh` to run the entire OSGI stack, note that if you include the Gogo jars (3 of them), you will be prompt with `g!` and entering the Gogo command shell. Also, if you include the Web Console jar, there will be a web console deployed for you to inspect the OSGI runtime bundles, status and logs.

Check within `./start.sh` to see how you can load a different set of bundles to begin with and use a different configure file.


## Test bundle
`:8000/example/status` (com.demo.app.restapi) using Jersey 2.25+.


## Useful links
- [OSGI Specs v6](https://www.osgi.org/developer/specifications/)
- [Apache Felix v5](http://felix.apache.org/documentation.html)
- [Apache Felix v5 sub projects](http://felix.apache.org/documentation/subprojects.html)
- [OSGI enRoute](http://enroute.osgi.org/)
- [Bndtools bnd](http://bnd.bndtools.org/chapters/150-build.html)
- [Bazel build](https://bazel.build/versions/master/docs/external.html)
- [Maven Repository](https://mvnrepository.com/)


## License
Copyright 2017 Tim Lauv. 
Under the [MIT](http://opensource.org/licenses/MIT) License.
