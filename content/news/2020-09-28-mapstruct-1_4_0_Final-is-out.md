---
title: "MapStruct 1.4.0.Final is out"
author: Filip Hrisafov, Sjaak Derksen
date: "2020-09-27"
tags: [release, news]
---

Long overdue it is our pleasure to announce the final version MapStruct 1.4. 
This is our 4th release since november 2015.

Besides bug fixes, the 1.4 release brings some new exciting features:

* Making use of constructor arguments when instantiating mapping targets
* Support Gradle incremental annotation processing feature
* Map nested bean properties to current target
* Support value mapping between `String` and `Enum`
* Support `@Mapping` in meta annotations
* User control over mapping features (direct, method, conversion, 2step)
* Support mapping from / to Java 14 records (preview feature)
* New `EnumTransformationStrategy` and `EnumNamingStrategy` SPIs
* Improve performance for 2 step mapping methods

<!--more-->

For more details checkout the individual release announcements for the
[Beta1](/news/2020-06-01-mapstruct-1_4_0_Beta1-is-out-with-constructor-support.md),
[Beta2](/news/2020-06-01-mapstruct-1_4_0_Beta2-is-out.md),
[Beta3](/news/2020-07-19-mapstruct-1_4_0_Beta3-is-out.md) and
[CR1](/news/2020-09-28-mapstruct-1_5_0_Final-is-out.md) releases.

### What's inside

First and foremost as we promised in the 1.3.0.Final release we have delivered the ability to cope with creating beans via constructors.
Here it is included mapping into Kotlin Data Classes and Java 14 records.
Apart from that we also have the following new features / enhancements:

* Support Gradle incremental annotation processing - MapStruct will no longer cause an entire recompilation of your java module
* Map nested beans to current target - i.e. you can use "." in `Mapping#target` to map nested beans to the current target
* Supporting value mapping between `String` and `Enum` - i.e. `@ValueMapping` can be used to map enums into strings and vice versa
* Supping meta annotations wih `@Mapping` - i.e. you can create your own annotation that holds common `@Mapping` definitions
* User control over mapping features - i.e. you can decide which steps MapStruct should execute during the mapping, meaning that you can easily define clone methods without the need to define mappings for your entire object structure
* New SPIs for enum mapping

In total 105 issues have been fixed between the 1.3.0.Final and 1.4.0.Final releases.
It is interesting that the number of fixed issues is the same as between the 1.2.0.Final and 1.3.0.Final release (this is not on purpose :)). 

### What's next

We have said numerous times that we want to do more smaller and more frequent releases.
However, every time we say that something else comes up and we still take our time between releases.
This is mostly because we are doing this in our spare time.

We will try to do the releases more frequently.
There are already some interesting feature requests that we would like to include in some of the future releases.

Most notable requests are:
* Conditional mapping (i.e. use custom methods to check whether a value is present, think whether string is not blank).
  There is already a PR from the community about this issue, so this will most likely be the basis for the 1.5 release
* Mapping into / from Map like structures from / into beans

In case you have some other ideas please feel free to share them with us or vote for issues that you'd like to see implemented in our [issue tracker](https://github.com/mapstruct/mapstruct/issues).
We are also always looking for new contributors, so if you are interested in helping us out please have a look at our issue tracker or contact us.

### Stats

We are very proud and thankful of our growing community. 
It is really satisfying to see how everyone helps each other in our [Gitter Room](https://gitter.im/mapstruct/mapstruct-users), on [StackOverflow](https://stackoverflow.com/questions/tagged/mapstruct) or in our [Google group](https://groups.google.com/forum/#!forum/mapstruct-users).
We currently have 3100+ stars and 70+ contributors on GitHub.
More than 16000 people are using our [IntelliJ](https://plugins.jetbrains.com/plugin/10036-mapstruct-support) plugin, which is already released with support for the new constructor mapping.

Most impressive though are the download numbers we get from the Maven Central repo.
As an example here are the numbers for the _org.mapstruct:mapstruct-processor_ artifact:

<div style="text-align:center">
    <img src="/images/downloads_09-2019_09-2020.png" style="padding-bottom: 3px;"/>
</div>

The number of Downloads compared to the time we released 1.3.0.Final has been quadrupled.

### Thanks

Last but not least we would like to congratulate all the enthusiastic MapStruct contributors making this release possible. 
In alphabetic order this are all the contributors that contributed to the 1.4 release of Mapstruct:

* [@dekelpilli](https://github.com/dekelpilli),
* [@fml2](https://github.com/fml2),
* [@jakraska](https://github.com/jakraska),
* [@juliojgd](https://github.com/juliojgd),
* [@marceloverdijk](https://github.com/marceloverdijk),
* [@mattdrees](https://github.com/mattdrees),
* [@power721](https://github.com/power721),
* [@pradzins](https://github.com/pradzins),
* [@seime](https://github.com/seime)
* [@sullis](https://github.com/sullis),
* [@timjb](https://github.com/timjb),
* [@ttzn](https://github.com/ttzn),
* [@vegemite4me](https://github.com/vegemite4me),
* [@xcorail](https://github.com/xcorail),
* [@Zomzog](https://github.com/Zomzog),
and of course seasoned MapStruct hackers [Sjaak Derksen](https://github.com/sjaakd), [Filip Hrisafov](https://github.com/filiphr), [Christian Bandowski](https://github.com/chris922) and [Andrei Arlou](https://github.com/Captain1653).

Happy coding with MapStruct 1.4!!

### Download

You can fetch the new release from Maven Central using the following GAV coordinates:

* Annotation JAR: [org.mapstruct:mapstruct:1.4.0.Final](http://search.maven.org/#artifactdetails|org.mapstruct|mapstruct|1.4.0.Final|jar)
* Annotation processor JAR: [org.mapstruct:mapstruct-processor:1.4.0.Final](http://search.maven.org/#artifactdetails|org.mapstruct|mapstruct-processor|1.4.0.Final|jar)

Alternatively, you can get ZIP and TAR.GZ distribution bundles - containing all the JARs, documentation etc. - [from GitHub](https://github.com/mapstruct/mapstruct/releases/tag/1.4.0.Final).

If you run into any trouble or would like to report a bug, feature request or similar, use the following channels to get in touch:

* Get help in our [Gitter room](https://gitter.im/mapstruct/mapstruct-users) or at the [mapstruct-users](https://groups.google.com/forum/?fromgroups#!forum/mapstruct-users) group
* Report bugs and feature requests via the [issue tracker](https://github.com/mapstruct/mapstruct/issues)
* Follow [@GetMapStruct](https://twitter.com/GetMapStruct) on Twitter
