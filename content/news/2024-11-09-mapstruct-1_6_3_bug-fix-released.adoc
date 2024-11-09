—
title: "MapStruct 1.6.3 bug fix released"
author: Filip Hrisafov
date: "2024-11-09"

== tags: [release, news]

It is my pleasure to announce the 1.6.3 bug fix release of MapStruct.
This release includes 3 bug fixes.
You may wonder where the Blog Post for 1.6.2 is.
There was no blog post as we released it immediately after 1.6.1 due to a regression in the 1.6.1 release, when using Java records.

With this release we support the use of the Java 19 `LinkedHashSet` and `LinkedHashMap` factory methods.

* Redundant if condition in Java record mapping with `RETURN_DEFAULT` strategy (#3747)
* Stackoverflow with Immutables custom builder (#3370)
* Unused import of `java.time.LocalDate` when mapping source `LocalDateTime` to target `LocalDate` (#3732)
* 

=== Thanks

Thanks to our entire community for reporting these errors. 

In alphabetic order this are all the contributors that contributed to the 1.6.3 release of Mapstruct:

* https://github.com/Srimathi-S[@Srimathi-S]

We are also accepting donations through https://opencollective.com/mapstruct[Open Collective] or https://github.com/sponsors/mapstruct[GitHub].
We'd like to thank all the supporters that supported us with donations in this period:

* https://github.com/adessoSE[adesso SE]
* https://github.com/atilimcetin[Atılım Çetin]
* https://opencollective.com/bileto[Bileto]
* https://github.com/cybozu[Cybozu]
* https://opencollective.com/atomfrede[Frederik Hahne]
* https://github.com/kjuyoung[Juyoung Kim]
* https://opencollective.com/lansana[Lansana]
* https://github.com/AnneMayor[Lee Anne]
* https://github.com/jan-prisma[PRISMA European Capacity Platform GmbH]
* https://opencollective.com/st-galler-kantonalbank-ag[St. Galler Kantonalbank AG]
* https://github.com/foal[Stanislav Spiridonov]

Happy coding with MapStruct 1.6.3!!

=== Download

You can fetch the new release from Maven Central using the following GAV coordinates:

* Annotation JAR: http://search.maven.org/#artifactdetails|org.mapstruct|mapstruct|1.6.3|jar[org.mapstruct:mapstruct:1.6.3]
* Annotation processor JAR: http://search.maven.org/#artifactdetails|org.mapstruct|mapstruct-processor|1.6.3|jar[org.mapstruct:mapstruct-processor:1.6.3]

Alternatively, you can get ZIP and TAR.GZ distribution bundles - containing all the JARs, documentation etc. - https://github.com/mapstruct/mapstruct/releases/tag/1.6.3[from GitHub].

If you run into any trouble or would like to report a bug, feature request or similar, use the following channels to get in touch:

* Get help in our https://github.com/mapstruct/mapstruct/discussions[GitHub Discussions] or https://stackoverflow.com/questions/tagged/mapstruct[StackOverflow]
* Report bugs and feature requests via the https://github.com/mapstruct/mapstruct/issues[issue tracker]
* Follow https://twitter.com/GetMapStruct[@GetMapStruct] on Twitter