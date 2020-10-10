---
title: "MapStruct 1.4.1.Final bug fix released"
author: Filip Hrisafov, Sjaak Derksen
date: "2020-10-11"
tags: [release, news]
---

It is my pleasure to announce the 1.4.1.Final bug fix release of MapStruct.
Even though we did 3 Beta and 1 CR release we still managed to introduce some regressions.

This release includes 6 bug fixes.

The most notable fix is the support for the IntelliJ incremental annotation processing.


<!--more-->

### IntelliJ 2020.3 support

In 2020.3 the IntelliJ team will improve the detection of generated sources and will trigger a recompilation of the mappers. 
This is not MapStruct specific, but rather an improvement across the board for Annotation processors.
This is already available in the EAP and I have already tried it.
I have to give huge thanks on the IntelliJ team for this, the integration is seamless and there is no more need to run your build tool to regenerate your mappers, or recompile your mappers explicitly.

### Thanks

Thanks to our entire community for being patient with us. 

Happy coding with MapStruct 1.4.1!!

### Download

You can fetch the new release from Maven Central using the following GAV coordinates:

* Annotation JAR: [org.mapstruct:mapstruct:1.4.1.Final](http://search.maven.org/#artifactdetails|org.mapstruct|mapstruct|1.4.1.Final|jar)
* Annotation processor JAR: [org.mapstruct:mapstruct-processor:1.4.1.Final](http://search.maven.org/#artifactdetails|org.mapstruct|mapstruct-processor|1.4.1.Final|jar)

Alternatively, you can get ZIP and TAR.GZ distribution bundles - containing all the JARs, documentation etc. - [from GitHub](https://github.com/mapstruct/mapstruct/releases/tag/1.4.1.Final).

If you run into any trouble or would like to report a bug, feature request or similar, use the following channels to get in touch:

* Get help in our [Gitter room](https://gitter.im/mapstruct/mapstruct-users) or at the [mapstruct-users](https://groups.google.com/forum/?fromgroups#!forum/mapstruct-users) group
* Report bugs and feature requests via the [issue tracker](https://github.com/mapstruct/mapstruct/issues)
* Follow [@GetMapStruct](https://twitter.com/GetMapStruct) on Twitter
