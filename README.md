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


## Workspace (Custom bundles)
Create sub projects under `/subprojects` (a **bnd workspace**) and build your custom bundles (**bnd projects**) within them. Other than the `/subprojects/cnf` folder there any other folder should be considered bnd project as well as a **Module** in the **IntelliJ IDEA** IDE project. See below for how to scaffold a new bnd project as IntelliJ IDEA Module. 

Deploy the built bundles into `/runtime/bundle/` to activate them.

### IDE support
We recommend using the [**IntelliJ IDEA CE**](https://www.jetbrains.com/idea/download/) and treat bnd projects as **Modules**. To avoid confusing developers with IDE build process and the bnd one. The IDE is treated as an enhanced text editor with advanced Java coding supports only, without the build tooling.

### Dependencies (3rd party jar)
The involvement of the **IntelliJ IDEA** IDE is to use its awesome auto-import and code-completion support during code development phase. We also use it to pull the dependencies (including transitive ones) for sub projects from Maven Central.

We use the normal Maven **Libraries** in **Project Structure** in the IDE without ever concerning the `deps.maven` index file and bnd. However, this way you can only inspect the dependencies listing when you open the **IntelliJ IDEA** IDE. We put libraries from Maven Central into `/subprojects/cnf/libs`.

All dependency jars are shared among the sub projects, though, you can still use different versions of the same artifact (a jar in Maven terms) in these projects. This is supported by OSGI runtime and honored by the bnd build tool.

#### Alternative deps management
The bnd build tool supports pulling dependency jars from Maven Central through its [**Maven Bnd Repository Plugin**](http://bnd.bndtools.org/plugins/maven.html) into our pre-configured bnd repo `/subprojects/cnf/libs` (a normal folder with pulled `*.jar` files) using Maven coordinates set in the `/subprojects/cnf/ext/deps.maven` index file. However this does *NOT* support pulling transitive dependency jars in addition to those specified in the index file. 

**Note:** Other than the built-in ones, bnd plugins are not enabled by default, we used the following cmd to explicitly enabled the **Maven Bnd Repository Plugin**
```
./bnd.sh add plugin MavenBndRepository
```
After this, `/subprojects/cnf` will have a `MavenBndRepository.bnd` configure file for the enabled plugin. You can verify the bnd repos by using 
```
./bnd.sh repo list
```

**Note:** Add transitive dependencies (in coordinate format) into the `deps.maven` file as well if you want bnd to pull all dependency jars for building the bundle from Maven Central.

Even though we can pull dependencies through bnd, we will need to add the `~/.m2/repository/` folder as a *Library* to the **IntelliJ IDEA** IDE project through **Project Structure** --> **Libraries** --> **+** --> **Java** --> select folder `/subprojects/cnf/libs` with type **Jar Directory**. This is to support the auto-import and code-completion in the IDE while writing Java code.

### Scaffolding a new bundle project
run `./+new.sh <name>` to create a new bnd project to produce OSGI bundles (e.g Contract APIs jar and an implementation Provider jar). After getting the project folder (should contain 1 `/src` folder), under IntelliJ IDEA go to **Project Structure** --> **Modules** --> **+** --> **Import Module** --> select the folder under `/subprojects/<name>` --> **Create module from existing source**. The sub project should appear in your **1:Project** tab in the IDE.

You can change the compile output path of the newly added Module to point to its own `/bin` and `/bin_test` folder which were already created by bnd. This is optional though, as we will not use the IDE to build sub project OSGI bundles. 

### Build
Notice that we didn't use any IDE feature to build the sub project bundles. Instead, we will use bnd in command line. The **IntelliJ IDEA** IDE offers a nice **Terminal** tab for you to keep focusing within the workspace. 

You will find that developing your bundle sub project is relatively straightforward with dependency jars pulled directly as libraries from Maven Central, however, when it comes to actually building the bundle (basically a normal jar with `MANIFEST.MF` file specifying package visibilites and versioning) we will need bnd to help generate the `MANIFEST.MF` and pack it with the bundle jar.

The bnd build tool doesn't know which dependency jars to include in the build path automatically. To let bnd work properly, in each of the sub project we have a `bnd.bnd` file to specify `-buildpath`/`-classpath`, `-includeresource` bnd instructions and `Export-Package`/`Private-Package`, `Bundle-Version` bnd headers. 

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
