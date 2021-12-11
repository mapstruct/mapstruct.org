---
title: "Support for subclass mapping, various enhancements and much more: MapStruct 1.5.0.Beta2 is out"
author: Filip Hrisafov
date: "2021-12-12"
tags: [release, news]
---

It's my pleasure to announce the second Beta release of MapStruct 1.5.

The new release comes with new functionality and some bug fixes, e.g.:

* Support for subclass mapping
* `NullValueMappingStrategy` for maps / collections
* New built-in conversions
* Generate imports only for Top level types

<!--more-->

Altogether, not less than [32 issues](https://github.com/mapstruct/mapstruct/issues?q=milestone%3A1.5.0.Beta2) were fixed for this release.

This would not have been possible without our fantastic community of contributors:
* [@amogh94](https://github.com/amogh94)
* [@basclaessen](https://github.com/basclaessen)
* [@DanielFran](https://github.com/DanielFran)
* [@dersvenhesse](https://github.com/dersvenhesse)
* [@hpoettker](https://github.com/hpoettker)
* [@incaseoftrouble](https://github.com/incaseoftrouble)
* [@szatyinadam](https://github.com/szatyinadam)
* [@valery1707](https://github.com/valery1707)
* [@yekeoe](https://github.com/yekeoe)

* our latest MapStruct contributor [Ben Zegveld](https://github.com/Zegveld) 
* and of course seasoned MapStruct hackers [Sjaak Derksen](https://github.com/sjaakd) and [Filip Hrisafov](https://github.com/filiphr).

Thank you everyone for all your hard work!

After our first Beta release of 1.5 in the summer, we are proud to present you with the second Beta of the 1.5 release.

We'd like to thank our community for the feedback on our first Beta release and for their contributions.
With this release we are happy to announce that our small team of contributors now includes [Ben Zegveld](https://github.com/Zegveld).

Enough of the pep talk, let's take a closer look at some of the new features and enhancement!

### NullValueMappingStrategy for maps / collections

MapStruct has had the `NullValueMappingStrategy` to control what to do when the source argument of the mapping method equals `null`.
This strategy has controlled the mapping for beans, collections and maps. 
Starting from this release there is an option to define different strategy for collections and maps separately through:

* `IterableMapping#nullValueMappingStrategy`, `Mapper#nullValueIterableMappingStrategy`, `MapperConfig#nullValueIterableMappingStrategy` - for collections / iterables
* `MapMapping#nullValueMappingStrategy`, `Mapper#nullValueMapMappingStrategy`, `MapperConfig#nullValueMapMappingStrategy` - for maps

### New Built-In conversions

We have extensive number of built-in conversions between different types.
As of this release we have 1 more:

* Between `String` and `URL`

### Enhancements

* Diagnostics now show up on the Mapper type - All errors are now shown on the mapper type itself. This helps locate problems when extending from base mappers 
* Generate imports only for top level classes
* Iterable type to non-iterable type error no longer reported when using multi source mapping
* `suppressTimestampInGenerated` in has been exposed in the `@Mapper` annotation
* Provide all available case transformations when an unknown is used in `CaseEnumTransformationStrategy`
* Add `unmappedSourcePolicy` as an annotation processor argument

### Breaking Changes

* Update methods with a return type always return the target object (annotated with `@MappingTarget`). 
  Prior to this release update mappings with a return type returned `null` when the source parameter was `null`.

### Download

This concludes our tour through MapStruct 1.5 Beta2.
If you'd like to try out the features described above, you can fetch the new release from Maven Central using the following GAV coordinates:

* Annotation JAR: [org.mapstruct:mapstruct:1.5.0.Beta2](http://search.maven.org/#artifactdetails|org.mapstruct|mapstruct|1.5.0.Beta2|jar) 
* Annotation processor JAR: [org.mapstruct:mapstruct-processor:1.5.0.Beta2](http://search.maven.org/#artifactdetails|org.mapstruct|mapstruct-processor|1.5.0.Beta2|jar)

Alternatively, you can get ZIP and TAR.GZ distribution bundles - containing all the JARs, documentation etc. - [from GitHub](https://github.com/mapstruct/mapstruct/releases/tag/1.5.0.Beta2).

If you run into any trouble or would like to report a bug, feature request or similar, use the following channels to get in touch:

* Get help in our [Gitter room](https://gitter.im/mapstruct/mapstruct-users), the [GitHub Discussion](https://github.com/mapstruct/mapstruct/discussions) or [StackOverflow](https://stackoverflow.com/questions/tagged/mapstruct)
* Report bugs and feature requests via the [issue tracker](https://github.com/mapstruct/mapstruct/issues)
* Follow [@GetMapStruct](https://twitter.com/GetMapStruct) on Twitter
