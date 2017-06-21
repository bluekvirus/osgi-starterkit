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
- Bnd bndlib (deps: slf4j-api, slf4j-simple)
- ... (sub project bundles under `/runtime/bundle/`)

### Config
See `/runtime/conf/config.properties` for comments. It configs both Framework and the other bundles loaded in the OSGI runtime.


## Custom bundles
Create sub projects under `/projects` and build your custom bundles within them. Deploy into `/runtime/bundle/` to activate them.


### Scaffolding
...

### Build
...


## Run
Call `./start.sh` to run the entire OSGI stack, note that if you include the Gogo jars (3 of them), you will be prompt with `g!` and entering the Gogo command shell. Also, if you include the Web Console jar, there will be a web console deployed for you to inspect the OSGI runtime bundles, status and logs.

Check within `./start.sh` to see how you can load a different set of bundles to begin with and use a different configure file.


## Test project bundle
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
