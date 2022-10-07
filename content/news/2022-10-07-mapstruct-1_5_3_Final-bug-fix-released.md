---
title: "MapStruct 1.5.3.Final bug fix released"
author: Filip Hrisafov
date: "2022-10-07"
tags: [release, news]
---

It is my pleasure to announce the 1.5.3.Final bug fix release of MapStruct.
This release includes 18 bug fixes and 7 documentation improvements.

The most notable fixes are around the handling of nested imports and generics handling

<!--more-->

### Nested imports

In the 1.5 releases we wanted to change the way we generate imports for nested classes.
We started generating imports only for top level classes.
However, as always in software there can be bugs and there were some here as well.
With this release we believe that we have covered most of the problems in this area.

### Generics handling

In the 1.5 release we did some improvements and strengthened our generics handling.
This improvement led to some subtle regressions that used to work by accident before.
With this release we believe that we have fixed those regressions.

### Thanks

Thanks to our entire community for reporting these errors and for helping use improve our documentation.

In alphabetic order this are all the contributors that contributed to the 1.5.3 release of Mapstruct:

* [@bogdanchikov](https://github.com/bogdanchikov),
* [@cassiusvm](https://github.com/cassiusvm),
* [@chenzijia12300](https://github.com/chenzijia12300),
* [@fml2](https://github.com/fml2),
* [@hakan0xFF](https://github.com/hakan0xFF),
* [@izeye](https://github.com/izeye),
* [@prasanth08](https://github.com/prasanth08),
  and of course seasoned MapStruct hackers [Ben Zegveld](https://github.com/Zegveld), [Sjaak Derksen](https://github.com/sjaakd) and [Filip Hrisafov](https://github.com/filiphr).


Happy coding with MapStruct 1.5.3!!

### Download

You can fetch the new release from Maven Central using the following GAV coordinates:

* Annotation JAR: [org.mapstruct:mapstruct:1.5.3.Final](http://search.maven.org/#artifactdetails|org.mapstruct|mapstruct|1.5.3.Final|jar)
* Annotation processor JAR: [org.mapstruct:mapstruct-processor:1.5.3.Final](http://search.maven.org/#artifactdetails|org.mapstruct|mapstruct-processor|1.5.3.Final|jar)

Alternatively, you can get ZIP and TAR.GZ distribution bundles - containing all the JARs, documentation etc. - [from GitHub](https://github.com/mapstruct/mapstruct/releases/tag/1.5.3.Final).

If you run into any trouble or would like to report a bug, feature request or similar, use the following channels to get in touch:

* Get help in our [Gitter room](https://gitter.im/mapstruct/mapstruct-users), the [GitHub Discussion](https://github.com/mapstruct/mapstruct/discussions) or [StackOverflow](https://stackoverflow.com/questions/tagged/mapstruct)
* Report bugs and feature requests via the [issue tracker](https://github.com/mapstruct/mapstruct/issues)
* Follow [@GetMapStruct](https://twitter.com/GetMapStruct) on Twitter

