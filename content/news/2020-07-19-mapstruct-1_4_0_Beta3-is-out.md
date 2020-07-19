---
title: "MapStruct 1.4.0.Beta3 is out"
author: Filip Hrisafov, Sjaak Derksen
date: "2020-07-19"
tags: [release, news]
---

Today we release a new beta version of MapStruct 1.4.0. We are very happy to have received good feedback from our users. However, it is like always when writing software bugs are made and are there to be solved. So what did we tackle in 1.4.0.Beta3

* Improve selection of mapping constructor
* Improve error messages for 2 step mapping methods
* Fix various bugs and regressions in relation to 2 step mappings
    

<!--more-->

[7 issues](https://github.com/mapstruct/mapstruct/issues?q=milestone%3A1.4.0.Beta3) were fixed for this release.


Thanks to our MapStruct community for being vigilant. The MapStruct authors: [Filip Hrisafov](https://github.com/filiphr), [Christian Bandowski](https://github.com/chris922), [Andrei Arlou](https://github.com/Captain1653) and [Sjaak Derksen](https://github.com/sjaakd). 

Thank you everyone for all your hard work!

### Improve selection of mapping constructor

In this release we improved the selection of a mapping constructor. 
Now the following rules apply:

* If a constructor is annotated with an annotation named `@Default` (from any package) it will be used.
* If a single public constructor exists then it will be used to construct the object, and the other non public constructors will be ignored.
* If a parameterless constructor exists then it will be used to construct the object, and the other constructors will be ignored.
* If there are multiple eligible constructors then there will be a compilation error due to ambigious constructors. In order to break the ambiquity an annotation named `@Default` (from any package) can used.

### Download

This concludes our tour through MapStruct 1.4 Beta3.
If you'd like to try out the features described above, you can fetch the new release from Maven Central using the following GAV coordinates:

* Annotation JAR: [org.mapstruct:mapstruct:1.4.0.Beta3](http://search.maven.org/#artifactdetails|org.mapstruct|mapstruct|1.4.0.Beta3|jar) 
* Annotation processor JAR: [org.mapstruct:mapstruct-processor:1.4.0.Beta3](http://search.maven.org/#artifactdetails|org.mapstruct|mapstruct-processor|1.4.0.Beta3|jar)

Alternatively, you can get ZIP and TAR.GZ distribution bundles - containing all the JARs, documentation etc. - [from GitHub](https://github.com/mapstruct/mapstruct/releases/tag/1.4.0.Beta3).

If you run into any trouble or would like to report a bug, feature request or similar, use the following channels to get in touch:

* Get help in our [Gitter room](https://gitter.im/mapstruct/mapstruct-users) or at the [mapstruct-users](https://groups.google.com/forum/?fromgroups#!forum/mapstruct-users) group
* Report bugs and feature requests via the [issue tracker](https://github.com/mapstruct/mapstruct/issues)
* Follow [@GetMapStruct](https://twitter.com/GetMapStruct) on Twitter
