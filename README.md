# OSGI Starter-Kit
Bare minimum starting point for OSGI based web apps.


## Runtime
Apache Felix Framework [5.6.4](http://felix.apache.org/downloads.cgi)

### Bundles
All of the OSGI bundles are put under `/runtime/bundle/`, the ones under `felix` are base runtime bundles loaded according to the `felix.auto.deploy.*` configure upon calling `./start.sh`. Others are loaded by **File Install** felix sub bundle for runtime hot deployment.

#### Default Felix bundles
`/runtime/bundle/felix`

- Main + Resolver + Framework (`/bin/felix.jar` itself)
- Bundle Repository
- Gogo Runtime
- Gogo Command
- Gogo JLine (replaces Gogo Shell, deps: jline, jansi)

#### Extra Felix bundles
`/runtime/bundle/felix`

- File Install
- Configuration Admin
- Event Admin
- HTTP Servlet 3.0 API
- HTTP Service Jetty (:8000/)
- SCR (Declarative Services)
- Log
- [Web Console](http://felix.apache.org/documentation/subprojects/apache-felix-web-console.html#configuration) (:8000/console/, deps: commons-io, commons-fileupload)

**Note**: The *Web Console* bundles are optional in production environment, it helps debug through logging during development.

#### Library bundles
`/runtime/bundle/hot-deploy/libs`

- BND bndlib (deps: slf4j-api, slf4j-simple)
- Jersey Container servlet (deps: ..17.. jars)

Put extra dependency jars into the libs folder if your app bundle complains **Unresolved requirements**. Re-build/deploy your app bundle after adding dependency jars.

#### Application bundles
`/runtime/bundle/hot-deploy/apps`

- `<project>`.jar

Use `./build.sh <project>` to have your sub project bundle built and deployed into the apps folder.


### Config
See `/runtime/conf/config.properties` for comments. It configs both Framework and the other bundles loaded in the OSGI runtime.


## Workspace (Custom bundles)
Create sub projects under `/subprojects` (a **bnd workspace**) and build your custom bundles (**bnd projects**) within them. Other than the `/subprojects/cnf` folder any other folder should be considered bnd project as well as a **Module** in the **IntelliJ IDEA** IDE project.

**Tip**: A bnd workspace is just a normal folder with an empty `cnf/build.bnd` meta file and an also empty `cnf/ext` folder. You can use `./bnd.sh add workspace <workspace>` to create them but we already created one named `subprojects` for you and pre-configured with a Maven bnd repo. 


### IDE support
We recommend using the [**IntelliJ IDEA CE**](https://www.jetbrains.com/idea/download/) and treat bnd projects as **Modules**. To avoid confusing developers with IDE build process and the bnd one. The IDE is treated as an enhanced text editor with advanced Java coding supports only, without the bundle (jar) packing tooling.

### Dependencies (3rd party jar)
The involvement of the **IntelliJ IDEA** IDE is to use its awesome auto-import and code-completion support during code development phase. We also use it to pull the dependencies (including transitive ones) from Maven Central for compiling sub project bytecode. (Read on if you wonder why we can't use bnd for that...)

We use the normal Maven **Libraries** in **Project Structure** in the IDE without ever concerning the `deps.maven` index file and bnd. However, this way you can only inspect the dependencies listing when you open the **IntelliJ IDEA** IDE. We put libraries from Maven Central into `/subprojects/cnf/libs`. Note that this is different than the `/runtime/bundle/hot-deploy/libs` folder which is for OSGI runtime. `/subprojects/cnf/libs` is for compiling our Java code.

All dependency jars are shared among the sub projects, you can use different versions of the same artifact (a jar in Maven terms) in these projects for both compile and OSGI runtime. This is honored by the bnd build tool. Use `Import-Package` header in your `bnd.bnd` project bundle meta file to control versioning of the depended packages at runtime.

### Alternative deps management
The bnd build tool supports pulling dependency jars from Maven Central through its [**Maven Bnd Repository Plugin**](http://bnd.bndtools.org/plugins/maven.html) into our pre-configured bnd repo `~/.m2/repository/` (the default Maven repo on your system) using Maven coordinates set in the `/subprojects/cnf/ext/deps.maven` index file. However this does *NOT* support pulling transitive dependency jars in addition to those specified in the index file. This is by design. Since the bnd build process is not there to help compile the Java code. It only concerns pulling packages from bytecode and pack with generated `MANIFEST.MF` OSGI metadata into jars. So, be ready to add all the transitive Maven coordinates for your library manually into `deps.maven` if you want to controll your compiling time dependencies (a.k.a libraries) this way.

**Note:** Unlike the built-in bnd plugins, the **Maven Bnd Repository Plugin** is not enabled by default, we used the following cmd to explicitly enable it
```
./bnd.sh add plugin MavenBndRepository
```
After this, `/subprojects/cnf` will have a `MavenBndRepository.bnd` configure file for the enabled plugin. We have pre-configured it to pull everying specified in `deps.maven` into `~/.m2/repository/`. You can verify pulled Maven bundles by using
```
./bnd.sh repo list
```
Note that, although this repo path seems to overlap with your system's default Maven repo. Only jars listed by `deps.maven` is made available in this bnd workspace.

**Tip**: Add transitive dependencies (in coordinate format) into the `deps.maven` file as well if you want bnd to pull all dependency jars from Maven Central instead of using **Libraries** in the **IntelliJ IDEA** IDE.

Even though we can pull dependencies through bnd, we will need to add the `~/.m2/repository/` folder as a *Library* to the **IntelliJ IDEA** IDE project through **Project Structure** --> **Libraries** --> **+** --> **Java** --> select folder `~/.m2/repository/` with type **Jar Directory**. This is to support the auto-import and code-completion in the IDE when writing Java code, also for compiling the Java code.

The only perk of using bnd to pull dependency jars from Maven is for convenient bundle packing through `-buildpath` instruction in your `bnd.bnd` project bundle meta file. It offers the fastest way of bundling 3rd party packages (from these jars) into your own bundle. This perk is quickly outweighted by the fact that these dependency jars (Maven coordinates) have to be explicitly added into `deps.maven` index and even without this Maven bnd repo we can still use the `-classpath` instruction in `bnd.bnd` to achieve the same result with the help of a bnd macro `${lsr;${workspace}/cnf/libs;*.jar}`. Also most of us get confused by the fact that these jars are not there for compiling our Java code, instead, they are for packing the final bundle jar. This is why bnd don't pull transitive jars for you. The bnd project doesn't concern compiling the Java code, only bundling jars and it doens't want you to pull every compiling dependency packages into your final bundle (as a repeatitive ball of mud they say...), those packages should live within their own bundle and shared within the OSGI runtime.

**Tip**: By our default workspace setup, you don't need to worry about using bnd to pull project dependencies. It is there, but only worth using if the whole purpose of your workspace is to combine bundles in sub projects.

### Scaffolding a new bundle project
run `./+new.sh <name>` to create a new bnd project to produce OSGI bundles (e.g Contract APIs jar and an implementation Provider jar). After getting the project folder (should contain 1 `/src` folder), under IntelliJ IDEA go to **Project Structure** --> **Modules** --> **+** --> **Import Module** --> select the folder under `/subprojects/<name>` --> **Create module from existing source**. The sub project should appear in your **1:Project** tab in the IDE.

You need to change the compile output path of the newly added Module project to point to its own `/bin` and `/bin_test` folder which were already created by bnd. This is optional though, it lets the IDE to compile sub project Java code and put bytecode into `/bin` folder for bnd to pack into bundles according to `*.bnd` files later. By default, the bnd build tool doesn't concern compiling Java code, it only pulls compiled packages out of bnd project `/bin`, 3rd party jars (`-classpath:`) and bnd repos (`-buildpath:`) and put them into the final bundle jar.

### Build
Notice that we didn't use any IDE feature to pack the sub project jars (a.k.a bundles). Instead, we will use bnd in command line. The **IntelliJ IDEA** IDE offers a nice **Terminal** tab for you to keep focusing within the workspace and use the system command line for bnd jar packing. 

You will find that developing your bundle sub project is relatively straightforward with dependency jars pulled directly as libraries from Maven Central up until code compilation, afterwards, when it comes to actually building the bundle (basically a normal jar with `MANIFEST.MF` file specifying package visibilites and versioning) we will need bnd to help generate the `MANIFEST.MF` and pack it with compiled Java bytecode into a jar. You can think of *build* in bnd as OSGI metadata gen (the label) plus bytecode Java package (the goods) *bundling*. 

The bnd build tool doesn't know which packages (again, the whole OSGI and bnd tooling thing is about Java packages) to include in the built jar automatically. To let bnd work properly, in each of the sub project we have a `bnd.bnd` file to specify `-buildpath`/`-classpath`, `-includeresource` bnd instructions and `Export-Package`/`Private-Package`, `Bundle-Version` bnd headers. These are for collecting packages from various targets (project `/bin`, *.jar or bnd repos) and expose selected packages in the final OSGI bundle. You will most likely use `Export-Package` in your `bnd.bnd` project bundle meta file.

In short, here is the sub `<proj>` build and deploy process:

1. Right-click your sub project (Module) in IDE, run **Build Module `<proj>`**;
2. Go to **Terminal** tab, type `./build.sh <proj>`;

That's it! The built bundle (bundles, if you have more than 1 .bnd file) will be put into `/runtime/bundle/hot-deploy/apps` folder and be picked up by the *File Install* felix bundle for auto install and start.

Now, if your OSGI runtime complains, you might need to move some of the jars from `/subprojects/cnf/libs` into `/runtime/bundle/hot-deploy/libs` so the required extra packages (Class or Interface bytecode) are made available in the runtime. This might looks strange if you wonder why we need two separate libs folder to compile and run the sub project bundle jar. This is by design. Short answer is you often need less jars in runtime than in compile when using OSGI. The OSGI runtime is there to share packages (Class and Interface) and service components (Instances).

**Tip**: Repeat the build and deploy steps when your code changes. This will automatically update the old deployment of the bundle jar in the runtime. You can remove the deployed bundle/dep jars from `/runtime/bundle/hot-deploy` to undeploy them.

## Run
Call `./start.sh` to run the entire OSGI stack, note that if you include the Gogo jars (3 of them), you will be prompt with `g!` and entering the Gogo command shell after the stack is started. Also, if you include the Web Console jar, there will be a web console deployed for you to inspect the OSGI runtime bundles, status and logs. The logs are pretty useful for debugging your bundle exceptions.

Check within `./start.sh` to see how you can load a different set of bundles to begin with and use a different configure file.


## Test bundle
`:8000/example/status` (example.jar) using Jersey 2.25+.


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
