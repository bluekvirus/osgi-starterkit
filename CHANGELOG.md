Change Log
==========

0.6.0+ (2017-08*)
-----------------
1. OSGi runtime and deps bundle sorted; (felix 5)
2. Added `start.sh` script;
3. Added example sub project;
4. Added README.md as doc;
5. Added bnd build tool and `new.sh` (sub project) script;
6. Added IntelliJ IDEA project support;
7. Added Maven bnd repo support;
8. Added Maven/JCenter deps support; (Gradle)
9. Added hot deploy setup;
10. Added `bundle.sh` script; (Bnd)
11. Added IntelliJ official .gitignore piece;
12. Added headless sub project build; (Gradle)
13. Added headless sub project lib sync; (Gradle)
14. Added Scala support to sub project; (Gradle)
15. Added Kotlin support to sub project; (Gradle)
16. Added gradle task to call bundle.sh; (override default jar task)
17. Added homeForIDE task to help link to IntelliJ IDEA as Gradle project;

working on ...

* docs folder with lektor; (OSGi premier, Jersey, Libs and base projects)
* docker containers; (phase 1: api-gateway, jre, db, cache/cfg, rsa)
* session sub project; (account/user, role/permission ==> jwttoken, session)
* stream/task sub project; (Logstash, Kafka)
* search sub project; (ElasticSearch)
* controller sub project; (Akka)
* auto runtime bundles prep script;
