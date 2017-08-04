Change Log
==========

0.5.0+ (2017-08*)
-----------------
1. OSGI runtime and deps bundle sorted; (felix 5)
2. Added `start.sh` script;
3. Added example sub project;
4. Added README.md as doc;
5. Added bnd build tool and `new.sh` script;
6. Added IntelliJ IDEA support;
7. Added Maven bnd repo support;
8. Added Maven library support; (Gradle)
9. Added hot deploy setup;
10. Added `bundle.sh` script;
11. Added IntelliJ official .gitignore piece;
12. Added headless sub project compile; (Gradle)
13. Added headless sub project lib sync; (Gradle)
14. Added Scala support to sub project; (Gradle)

working on ...

* gradle task to call bundle.sh; (override jar task)
* docker containers;
* session sub project; (account/user, role/permission ==> jwttoken, session)
* db sub project; (K-V, JSON/Doc, SQL, BigTable, Graph)
* task/controller sub project; (Akka)
* stream sub project; (Logstash, Kafka)
* search sub project; (ElasticSearch)
* local deploy bnd repo instead of `mv *.jar` script;
* auto runtime bundles prep script;
