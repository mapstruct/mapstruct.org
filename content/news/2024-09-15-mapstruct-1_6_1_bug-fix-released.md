---
title: "MapStruct 1.6.1 bug fix released"
author: Filip Hrisafov
date: "2024-09-15"
tags: [release, news]
---

It is my pleasure to announce the 1.6.1 bug fix release of MapStruct.
This release includes 1 enhancement and 8 bug fixes, including some regressions introduced in 1.6.0.

With this release we support the use of the Java 19 `LinkedHashSet` and `LinkedHashMap` factory methods.

<!--more-->

### LinkedHashSet and LinkedHashMap factory method

With this release if your source code is Java 19 or later MapStruct is going to use the new factory methods when creating a `Set` or `Map`

On Java 18 or earlier it looks like

{{< prettify java >}}
Map<AuctionDto, AuctionDto> map = new LinkedHashMap<AuctionDto, AuctionDto>( Math.max( (int) ( auctions.size() / .75f ) + 1, 16 ) );
Set<TargetFoo> set = new LinkedHashSet<TargetFoo>( Math.max( (int) ( foos.size() / .75f ) + 1, 16 ) );
{{< /prettify >}}

Whereas on Java 19 or later it looks like
{{< prettify java >}}
Map<AuctionDto, AuctionDto> map = LinkedHashMap.newLinkedHashMap( auctions.size() );
Set<TargetFoo> set = LinkedHashSet.newLinkedHashSet( foos.size() );
{{< /prettify >}}

### Thanks

Thanks to our entire community for reporting these errors. 

In alphabetic order this are all the contributors that contributed to the 1.6.1 release of Mapstruct:

* [@hduelme](https://github.com/hduelme)
* [@Hypnagokali](https://github.com/Hypnagokali)
* [@Obolrom](https://github.com/Obolrom)

We are also accepting donations through [Open Collective](https://opencollective.com/mapstruct) or [GitHub](https://github.com/sponsors/mapstruct).
We'd like to thank all the supporters that supported us with donations in this period:

* [adesso SE](https://github.com/adessoSE)
* [Bileto](https://opencollective.com/bileto)
* [Cybozu](https://github.com/cybozu)
* [Frederik Hahne](https://opencollective.com/atomfrede)
* [Juyoung Kim](https://github.com/kjuyoung)
* [Lansana](https://opencollective.com/lansana)
* [Lee Anne](https://github.com/AnneMayor)
* [Mariselvam](https://github.com/marisnb)
* [PRISMA European Capacity Platform GmbH](https://github.com/jan-prisma)
* [St. Galler Kantonalbank AG](https://opencollective.com/st-galler-kantonalbank-ag)

Happy coding with MapStruct 1.6.1!!

### Download

You can fetch the new release from Maven Central using the following GAV coordinates:

* Annotation JAR: [org.mapstruct:mapstruct:1.6.1](http://search.maven.org/#artifactdetails|org.mapstruct|mapstruct|1.6.1|jar)
* Annotation processor JAR: [org.mapstruct:mapstruct-processor:1.6.1](http://search.maven.org/#artifactdetails|org.mapstruct|mapstruct-processor|1.6.1|jar)

Alternatively, you can get ZIP and TAR.GZ distribution bundles - containing all the JARs, documentation etc. - [from GitHub](https://github.com/mapstruct/mapstruct/releases/tag/1.6.1).

If you run into any trouble or would like to report a bug, feature request or similar, use the following channels to get in touch:

* Get help in our [GitHub Discussions](https://github.com/mapstruct/mapstruct/discussions) or [StackOverflow](https://stackoverflow.com/questions/tagged/mapstruct)
* Report bugs and feature requests via the [issue tracker](https://github.com/mapstruct/mapstruct/issues)
* Follow [@GetMapStruct](https://twitter.com/GetMapStruct) on Twitter

