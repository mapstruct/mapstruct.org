---
title: "MapStruct 1.5.0.Final is out"
author: Filip Hrisafov
date: "2022-06-03"
tags: [release, news]
---

I am very happy to announce the final release of MapStruct 1.5!
This is our 5th major release since November 2015.

Besides bug fixes, the 1.5 release brings some new exicting features:

* Support for mapping from `Map<String, ???>` to a bean
* Conditional mapping
* Support for subclass mapping
* Support for Jakarta dependency injection

<!--more-->

For more details checkout the individual release announcements for the 
[Beta1](/news/2021-07-18-mapstruct-1_5_0_Beta1-is-out.md),
[Beta2](/news/2021-12-12-mapstruct-1_5_0_Beta2-is-out.md),
[RC1](2022-03-20-mapstruct-1_5_0_RC1-is-out.md)


### What's inside

This major release brings few big new features for MapStruct:
* [Support for mapping from Map to bean](/news/2021-07-18-mapstruct-1_5_0_Beta1-is-out/#mapping-from-map-to-bean)
* [Conditional mapping](/news/2021-07-18-mapstruct-1_5_0_Beta1-is-out/#conditional-mapping)
* [Subclass Mapping](/documentation/dev/reference/html/#sub-class-mappings)
* [Support for Jakarta dependency injection](/news/2022-03-20-mapstruct-1_5_0_RC1-is-out/#support-for-jakarta-dependency-injection)

In total 110 issues have been fixed between the 1.4.0.Final and 1.5.0.Final release.
It is again interesting to see that the number of fixed issues between the previous 1.3.0.Final and 1.4.0.Final release is similar.

### What's next

We currently have 2 larger PRs open with new features:
* [Support for passing annotations to generated code](https://github.com/mapstruct/mapstruct/pull/2792)
* [Access to target property name](https://github.com/mapstruct/mapstruct/pull/2834)

We would like this 2 issues to be the baseline of the next 1.6.0 Release and hopefully do the next release faster than the current one.

### Stats

Like every final release, we like to release some statistics about the project.
We are very proud and thankful to our growing community.
It is really satisfying to see how everyone helps each other in our [Gitter Room](https://gitter.im/mapstruct/mapstruct-users), on [StackOverflow](https://stackoverflow.com/questions/tagged/mapstruct) or in our [GitHub Discussions](https://github.com/mapstruct/mapstruct/discussions).
We currently have 5300+ stars and 100 contributors on GitHub.
More than 30000 people are using our [IntelliJ](https://plugins.jetbrains.com/plugin/10036-mapstruct-support) plugin.

Most impressive though are the download numbers we get from the Maven Central repo.
As an example here are the numbers for the _org.mapstruct:mapstruct-processor_ artifact:

<div style="text-align:center">
    <img src="/images/downloads_06-2021_06-2022.png" style="padding-bottom: 3px;"/>
</div>

The number of Downloads compared to the time we released 1.4.0.Final has been doubled.

### Thanks

Last but not least we would like to congratulate all the enthusiastic MapStruct contributors making this release possible.
In alphabetic order this are all the contributors that contributed to the 1.5 release of Mapstruct:

* [@amogh94](https://github.com/amogh94)
* [@anovitskyi](https://github.com/anovitskyi)
* [@basclaessen](https://github.com/basclaessen)
* [@Blackbaud-JasonBodnar](https://github.com/Blackbaud-JasonBodnar)
* [@cdelashmutt-pivotal](https://github.com/cdelashmutt-pivotal)
* [@ckosmowski](https://github.com/ckosmowski)
* [@coolZhangSir](https://github.com/coolZhangSir)
* [@DanielFran](https://github.com/DanielFran)
* [@dersvenhesse](https://github.com/dersvenhesse)
* [@dmngb](https://github.com/dmngb)
* [@eforest](https://github.com/eforest)
* [@Goni-Dev](https://github.com/Goni-Dev)
* [@hpoettker](https://github.com/hpoettker)
* [@incaseoftrouble](https://github.com/incaseoftrouble)
* [@JKLedzion](https://github.com/JKLedzion)
* [@jpbassinello](https://github.com/jpbassinello)
* [@JudeNiroshan](https://github.com/JudeNiroshan)
* [@jvwilge](https://github.com/jvwilge)
* [@LukeLaz](https://github.com/LukeLaz)
* [@Nikolas-Charalambidis](https://github.com/Nikolas-Charalambidis)
* [@qingmo](https://github.com/qingmo)
* [@reitzmichnicht](https://github.com/reitzmichnicht)
* [@Saljack](https://github.com/Saljack)
* [@sahebpreet](https://github.com/sahebpreet)
* [@szatyinadam](https://github.com/szatyinadam)
* [@unshare](https://github.com/unshare)
* [@valery1707](https://github.com/valery1707)
* [@ykozcan](https://github.com/ykozcan)
  and of course seasoned MapStruct hackers [Ben Zegveld](https://github.com/Zegveld) (who is also our new member of the team), [Sjaak Derksen](https://github.com/sjaakd) and [Filip Hrisafov](https://github.com/filiphr).

Happy coding with MapStruct 1.5!!

### Download

You can fetch the new release from Maven Central using the following GAV coordinates:

* Annotation JAR: [org.mapstruct:mapstruct:1.5.0.Final](http://search.maven.org/#artifactdetails|org.mapstruct|mapstruct|1.5.0.Final|jar)
* Annotation processor JAR: [org.mapstruct:mapstruct-processor:1.5.0.Final](http://search.maven.org/#artifactdetails|org.mapstruct|mapstruct-processor|1.5.0.Final|jar)

Alternatively, you can get ZIP and TAR.GZ distribution bundles - containing all the JARs, documentation etc. - [from GitHub](https://github.com/mapstruct/mapstruct/releases/tag/1.5.0.Final).

If you run into any trouble or would like to report a bug, feature request or similar, use the following channels to get in touch:

* Get help in our [Gitter room](https://gitter.im/mapstruct/mapstruct-users), the [GitHub Discussion](https://github.com/mapstruct/mapstruct/discussions) or [StackOverflow](https://stackoverflow.com/questions/tagged/mapstruct)
* Report bugs and feature requests via the [issue tracker](https://github.com/mapstruct/mapstruct/issues)
* Follow [@GetMapStruct](https://twitter.com/GetMapStruct) on Twitter
