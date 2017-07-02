3rd party libraries (IntelliJ)
==============================
This is where we put IDE managed library jars. 

## Using Maven bnd repo instead?

If you use Maven bnd repo to manage the libraries, see `../ext/deps.maven` for Maven coordinates. After updating the index with all the dependency artifacts **and their transitive dependencies**. Type the following command to refresh the jars.
```
./bnd.sh repo list
```

Use *either* the IDE *or* bnd repo to pull and manage your 3rd party jars.