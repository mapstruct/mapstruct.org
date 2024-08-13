---
title: "MapStruct 1.6.0 is out"
author: Filip Hrisafov
date: "2024-08-12"
tags: [release, news]
---

I am very happy to announce the final release of MapStruct 1.6!
This is our 6th major release since November 2015.

As you can see with this release we decided to remove the `.Final` and only use the version (1.6.0).
We'll keep doing this for final releases.

Besides bug fixes, the 1.6 release brings some new exciting features:

* Access to target / source property names in conditional and mapping methods
* Conditional mapping for source parameters
* Passing annotations to generated code
* Add javadoc to generated code
* New built-in conversions

<!--more-->

For more details checkout the individual release announcements for the 
[Beta1](/news/2023-11-04-mapstruct-1_6_0_Beta1-is-out),
[Beta2](/news/2024-05-11-mapstruct-1_6_0_Beta2-is-out),
[RC1](/news/2024-07-20-mapstruct-1_6_0_RC1-is-out)

### What's inside

This major release brings few big new features for MapStruct:
* [Access to target / source property names in conditional and mapping methods](/news/2023-11-04-mapstruct-1_6_0_Beta1-is-out/#access-to-target--source-property-names-in-conditional-and-mapping-methods)
* [Conditional mapping for source parameters](/news/2024-05-11-mapstruct-1_6_0_Beta2-is-out/#conditional-mapping-for-source-parameters) 
* [Passing annotations to generated code](/documentation/stable/reference/html/#adding-annotations)
* [Add javadoc to generated code](/documentation/stable/reference/html/#javadoc)

In total 90 issues have been fixed between the 1.5.0.Final and 1.6.0 release.

### What's next

We currently have few issues that have been requested a lot:
* [Support Java 8 Optional](https://github.com/mapstruct/mapstruct/issues/674)
* [Support or NonNull / Nullable annotations](https://github.com/mapstruct/mapstruct/issues/1243)

and we have some issues with requesting support for Kotlin.
The most requested here are:

* [Support KSP](https://github.com/mapstruct/mapstruct/issues/2522)
* [Support for Kotlin data classes](https://github.com/mapstruct/mapstruct/issues/2281)

We would like to see if we can tackle some of these issues in the next release.
The KSP support is something that might require a lot of work and refactoring in the internals of MapStruct, but we will see.

### Stats

Like every final release, we like to release some statistics about the project.
We are very proud and thankful to our growing community.
It is really satisfying to see how everyone helps each other in our on [StackOverflow](https://stackoverflow.com/questions/tagged/mapstruct) or in our [GitHub Discussions](https://github.com/mapstruct/mapstruct/discussions).
We currently have 7000+ stars and 133 contributors on GitHub.
More than 100 000 people are using our [IntelliJ](https://plugins.jetbrains.com/plugin/10036-mapstruct-support) plugin.

Most impressive though are the download numbers we get from the Maven Central repo.
As an example here are the numbers for the _org.mapstruct:mapstruct-processor_ artifact:

<div style="text-align:center">
    <img src="/images/downloads_08-2023_08-2024.png" style="padding-bottom: 3px;"/>
</div>

The number of Downloads compared to the time we released 1.5.0.Final has more than doubled (increased by 2.3 times).

### Thanks

In this release we also started accepting donations through [Open Collective](https://opencollective.com/mapstruct) or [GitHub](https://github.com/sponsors/mapstruct).

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


Last but not least we would like to congratulate all the enthusiastic MapStruct contributors making this release possible.
In alphabetic order this are all the contributors that contributed to the 1.6 release of Mapstruct:

* [@anton-erofeev](https://github.com/anton-erofeev)
* [@Blackbaud-JasonBodnar](https://github.com/Blackbaud-JasonBodnar)
* [@Bragolgirith](https://github.com/Bragolgirith)
* [@chenzijia12300](https://github.com/chenzijia12300)
* [@cmcgowanprovidertrust](https://github.com/cmcgowanprovidertrust)
* [@dehasi](https://github.com/dehasi)
* [@eroznik](https://github.com/eroznik)
* [@EvaristeGalois11](https://github.com/EvaristeGalois11)
* [@hduelme](https://github.com/hduelme)
* [@Hypnagokali](https://github.com/Hypnagokali)
* [@ivlcic](https://github.com/ivlcic)
* [@jccampanero](https://github.com/jccampanero)
* [@kooixh](https://github.com/kooixh)
* [@MengxingYuan](https://github.com/MengxingYuan)
* [@MLNW](https://github.com/MLNW)
* [@mosesonline](https://github.com/mosesonline)
* [@Nikolas-Charalambidis](https://github.com/Nikolas-Charalambidis)
* [@Obolrom](https://github.com/Obolrom)
* [@paparadva](https://github.com/paparadva)
* [@prasanth08](https://github.com/prasanth08)
* [@ro0sterjam](https://github.com/ro0sterjam)
* [@rgdoliveira](https://github.com/rgdoliveira)
* [@the-mgi](https://github.com/the-mgi)
* [@venkatesh2090](https://github.com/venkatesh2090)
* [@wandi34](https://github.com/wandi34)
  and of course seasoned MapStruct hackers [Oliver Erhart](https://github.com/thunderhook) (who is a new member of the team), [Ben Zegveld](https://github.com/Zegveld), [Sjaak Derksen](https://github.com/sjaakd) and [Filip Hrisafov](https://github.com/filiphr).

Happy coding with MapStruct 1.6!!

### Download

You can fetch the new release from Maven Central using the following GAV coordinates:

* Annotation JAR: [org.mapstruct:mapstruct:1.6.0](http://search.maven.org/#artifactdetails|org.mapstruct|mapstruct|1.6.0|jar)
* Annotation processor JAR: [org.mapstruct:mapstruct-processor:1.6.0](http://search.maven.org/#artifactdetails|org.mapstruct|mapstruct-processor|1.6.0|jar)

Alternatively, you can get ZIP and TAR.GZ distribution bundles - containing all the JARs, documentation etc. - [from GitHub](https://github.com/mapstruct/mapstruct/releases/tag/1.6.0).

If you run into any trouble or would like to report a bug, feature request or similar, use the following channels to get in touch:

* Get help in our [GitHub Discussions](https://github.com/mapstruct/mapstruct/discussions) or [StackOverflow](https://stackoverflow.com/questions/tagged/mapstruct)
* Report bugs and feature requests via the [issue tracker](https://github.com/mapstruct/mapstruct/issues)
* Follow [@GetMapStruct](https://twitter.com/GetMapStruct) on Twitter
