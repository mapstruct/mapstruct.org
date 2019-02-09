---
title: "MapStruct 1.3.0.Final is out in the wild"
author: Filip Hrisafov, Sjaak Derksen
date: "2019-02-10"
tags: [release, news]
---

Long overdue it is our pleasure to announce the final version MapStruct 1.3. 
This is our 3rd release since november 2015.

Besides bug fixes, the 1.3 release brings some new exciting features:

* Mapping (immutable) objects using builders
* Enhanced and more flexible update method (`@MappingTarget`) handling
* Constructor injection for Annotation Based component models
* Source policy for unmapped source properties (`unmappedSourcePolicy`)
* Support for `defaultExpression`
* Limit mapping only to explicitly defined mappings
* Performance improvement of `constant` / `defaultValue` primitive to `String` mappings
* Warnings for precision loss

<!--more-->

For more details checkout the individual release announcements for the
[Beta1](/news/2018-07-15-mapstruct-1_3_0_Beta1-is-out-with-builder-support.md) and
[Beta2](/news/2018-11-12-mapstruct-1_3_0_Beta2-is-out-with-java8-as-baseline.md) releases.

### What's inside

First and foremost we have delivered the ability to cope with immutable beans via the builder pattern. 
There are many frameworks out there for which we added (experimental) support, 
most notably [Immutables](https://immutables.github.io), [Lombok](https://projectlombok.org) and 
[Protobuf](https://developers.google.com/protocol-buffers/). 

We haven't forgotten the initialization via a constructor, it is high on our list to support it within the next release.

Next we realised that the way we handle update / merge methods (`@MappingTarget`) deserved more attention. 
Initially this functionality was modelled after the non update methods (regular mappings), but the use case for these types is different. 
The API behaved inconsistent and left the user unable to choose what to do in case of `null` or not present source objects: 

* Set `null` 
* Set default 
* Ignore and leave the target as is

This can now be controlled via `NullValuePropertyMappingStrategy`.

We also dropped support for Java 6 an 7 in 1.3 and are using Java 8 as a baseline across the MapStruct codebase.
This has been long overdue and would enable us to simplify our codebase.
It would also allow us to spent our effort on newer features rather than backwards compatible support for Java 6 and 7. 

In total 105 have been fixed between the 1.2.0.Final and 1.3.0.Final releases.

### What's next
 
Functionality wise many features have been added since the 1.0.0.Final release. 
Some of these features would have justified major releases, but we chose to be very careful. 
Bringing out a number of beta releases and release candidates we tried to mitigate risks. 
Perhaps we are too careful, looking at the issues that are found on the new features and we should be more daring in bringing out minor releases faster. 

Development wise, in many ways, we are standing on a crossroad. 
Our code base has grown and the handling of beans / property mapping has grown complex. 
It is time to look at restructuring the code in a major fashion if we want to grow in features.
Don't let this scare you, the public API exposed by MapStruct will not change. 
We are only talking about the internal API of the processor.
All of our tests are done in such way that they are only using the MapStruct public API.
Each test has a mapper for which the compiler is invoked to generate the implementation and we test against that.
This tests give us confidence that we can restructure the code and keep everything working as is now. 
During this refactoring we want to drop some of our deprecated features. 
The refactored code will most likely lead to a 2.0 version and will be done transparently with the community. 
In between 1.3 and 2.0 we plan smaller and faster feature / bug fix releases. 

We are also going to scrutinise our open issues and close the ones which will not make it into MapStruct.
In case we close your issue and you think that it should be a feature or enhancement from MapStruct, then please say so in the issue and we can reconsider.

One other big feature that we would like to see as soon as possible is the possibility to map via constructors.
This has been one of the most requested features and we would like to tackle it.

If you have any ideas or are willing to help out with any features feel free to reach to us, we are always looking for new fresh ideas and support from the community.


### Stats

We are very proud and thankful of our of our growing community. 
It is really satisfying to see how everyone helps each other in our [Gitter Room](https://gitter.im/mapstruct/mapstruct-users), on [StackOverflow](https://stackoverflow.com/questions/tagged/mapstruct) or in our [Google group](https://groups.google.com/forum/#!forum/mapstruct-users).
We currently have 1500+ stars and 50+ contributors on GitHub.
More than 16000 people are using our [IntelliJ](https://plugins.jetbrains.com/plugin/10036-mapstruct-support) plugin. 
And don't worry we haven't forgotten about it, a new fresh version with builder and fluent setter support will be released shortly.

Most impressive though are the download numbers we get from the Maven Central repo.
As an example here are the numbers for the _org.mapstruct:mapstruct-processor_ artifact:

<div style="text-align:center">
    <img src="/images/downloads_02-2018_01-2019.png" style="padding-bottom: 3px;"/>
</div>


### Thanks

Last but not least we would like to congratulate all the enthusiastic MapStruct contributors making this release possible. 
In alphabetic order this are all the contributors that contributed to the 1.3 release of Mapstruct:

* [Arne Seime](https://github.com/seime)
* [Andres Jose Sebastian Rincon Gonzalez](https://github.com/stianrincon)
* [Christian Bandowski](https://github.com/chris922) 
* [David Feinblum](https://github.com/dvfeinblum) 
* [Darren Rambaud](https://github.com/xyzst) 
* [Daniel Strobusch](https://github.com/dastrobu) 
* [Eric Martineau](https://github.com/ericmartineau) 
* [Florian Tavares](https://github.com/neoXfire)
* [Gervais Blaise](https://github.com/gervaisb) 
* [Jeff Smyth](https://github.com/smythie86) 
* [Joshua Spoerri](https://github.com/spoerri)
* [Kevin Grüneberg](https://github.com/kevcodez)
* [Lauri Apple](https://github.com/lappleapple)
* [Richard Lea](https://github.com/chigix)
* [Saheb Preet Singh](https://github.com/sahebpreet)
* [Sebastian Haberey](https://github.com/sebastianhaberey)
* [Sergey Grekov](https://github.com/sgrekov)
* [Sivaraman Viswanathan](https://github.com/sivviswa22)
* [Taras Mychaskiw](https://github.com/twentylemon)
* [Tomoya Yokota](https://github.com/yokotaso)

and of course seasoned MapStruct hackers hackers [Sjaak Derksen](https://github.com/sjaakd), [Filip Hrisafov](https://github.com/filiphr), [Christian Bandowski](https://github.com/chris922), [Gunnar Morling](https://github.com/gunnarmorling) and [Andreas Gudian](https://github.com/agudian).

Happy coding with MapStruct 1.3!!

### Download

You can fetch the new release from Maven Central using the following GAV coordinates:

* Annotation JAR: [org.mapstruct:mapstruct:1.3.0.Final](http://search.maven.org/#artifactdetails|org.mapstruct|mapstruct|1.3.0.Final|jar)
* Annotation processor JAR: [org.mapstruct:mapstruct-processor:1.3.0.Final](http://search.maven.org/#artifactdetails|org.mapstruct|mapstruct-processor|1.3.0.Final|jar)

Alternatively, you can get ZIP and TAR.GZ distribution bundles - containing all the JARs, documentation etc. - [from GitHub](https://github.com/mapstruct/mapstruct/releases/tag/1.3.0.Final).

If you run into any trouble or would like to report a bug, feature request or similar, use the following channels to get in touch:

* Get help at the [mapstruct-users](https://groups.google.com/forum/?fromgroups#!forum/mapstruct-users) group or in our [Gitter room](https://gitter.im/mapstruct/mapstruct-users)
* Report bugs and feature requests via the [issue tracker](https://github.com/mapstruct/mapstruct/issues)
* Follow [@GetMapStruct](https://twitter.com/GetMapStruct) on Twitter
