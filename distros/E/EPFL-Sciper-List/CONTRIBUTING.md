Contributing
============

Welcome, so you are thinking about contributing ?
Awesome, this a great place to start.

Setup
-----

```bash
git clone git@github.com:innovativeinnovation/epfl-sciper-list.git
cd epfl-sciper-list
perl Build.PL
perl Build installdeps
```

Test
----

Unit and integration tests:

```bash
perl Build test
```

Code coverage:

```bash
perl Build testcover
```

To enable Author tests:

```bash
export RELEASE_TESTING=1
```

Run
---

```bash
perl -Ilib bin/epfl-sciper-list
```

Package
-------

```bash
perl Build dist
```

Release
-------

  1. Bump the correct version.
  2. Update the file [Changes](Changes)
  3. Package the module.
  4. Upload the package to https://pause.perl.org/
  5. Create the tag (`git tag -a v<version> -m "Tagging the v<version> release"`) 

License
-------

Apache License 2.0

Original work (c) ECOLE POLYTECHNIQUE FEDERALE DE LAUSANNE, Switzerland, VPSI, 2017-2018.  
Modified work (c) William Belle, 2018.

See the [LICENSE](LICENSE) file for more details.
