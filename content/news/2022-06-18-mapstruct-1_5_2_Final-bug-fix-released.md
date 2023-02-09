---
title: "MapStruct 1.5.2.Final bug fix released"
author: Filip Hrisafov
date: "2022-06-18"
tags: [release, news]
---

It is my pleasure to announce the 1.5.2.Final bug fix release of MapStruct.
You might ask yourself, where is 1.5.1.
We released that version on 5th of June 2022, 3 days after the 1.5.0.Final release.
It had a fix for a bug that was reported by our good friends from JHipster.

This release includes 1 enhancements and 2 bug fixes.

With this release we started supporting Text blocks for all the expressions.

<!--more-->

### Text block support

In this release we relaxed the rules for the expressions and we now also support text blocks.

{{< prettify java >}}
@Mapping(target = "fieldName", expression =
        """
            java(
                EnumType1.ENUM_VALUE_1 == dto.getValueOfEnum1()
                    ? EnumType2.ENUM_VALUE_2
                    : dto.getValueOfEnum2()
            )    
        """)
{{< /prettify >}}

### Thanks

Thanks to our entire community for reporting these errors. 

Happy coding with MapStruct 1.5.2!!

### Download

You can fetch the new release from Maven Central using the following GAV coordinates:

* Annotation JAR: [org.mapstruct:mapstruct:1.5.2.Final](http://search.maven.org/#artifactdetails|org.mapstruct|mapstruct|1.5.2.Final|jar)
* Annotation processor JAR: [org.mapstruct:mapstruct-processor:1.5.2.Final](http://search.maven.org/#artifactdetails|org.mapstruct|mapstruct-processor|1.5.2.Final|jar)

Alternatively, you can get ZIP and TAR.GZ distribution bundles - containing all the JARs, documentation etc. - [from GitHub](https://github.com/mapstruct/mapstruct/releases/tag/1.5.2.Final).

If you run into any trouble or would like to report a bug, feature request or similar, use the following channels to get in touch:

* Get help in our [Gitter room](https://gitter.im/mapstruct/mapstruct-users), the [GitHub Discussion](https://github.com/mapstruct/mapstruct/discussions) or [StackOverflow](https://stackoverflow.com/questions/tagged/mapstruct)
* Report bugs and feature requests via the [issue tracker](https://github.com/mapstruct/mapstruct/issues)
* Follow [@GetMapStruct](https://twitter.com/GetMapStruct) on Twitter

