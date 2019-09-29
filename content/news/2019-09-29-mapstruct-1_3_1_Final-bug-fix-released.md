---
title: "MapStruct 1.3.1.Final bug fix released"
author: Filip Hrisafov
date: "2019-09-29"
tags: [release, news]
---

It is my pleasure to announce the 1.3.1.Final bug fix release of MapStruct.
Since the Final release of MapStruct 1.3.0.Final we have received amazing feedback from the community.

This release includes 3 enhancements, 12 bug fixes and 7 documentation improvements.

The enhancements include:

* Ability to disable builders on method level via `Builder#disableBuilder`
* Stricter matching for lifecycle methods / non-unique parameters

<!--more-->

Altogether, not less than [21 issues](https://github.com/mapstruct/mapstruct/milestone/29?closed=1) were fixed for this release.

### What's inside

First and foremost we fixed almost all the bugs reported by the community for the 1.3.0.Final release.
Apart from bug fixes we added some small enhancements.

### Ability to disable builder on method level

It is now possible to disable the usage of Builders via the `Builder#disableBuilder` option.
This is useful if you want to tell MapStruct no to use builders when mapping your beans.

### Stricter matching for lifecycle methods / non-unique parameters

In case a lifecycle method has multiple matching parameters (e. g. same type)
all parameter names must match exactly with the ones from the mapping method,
otherwise the lifecycle method will not be used and a warning will be shown.

### Welcome Andrei to the MapStruct team

Since our last release we also have a new member join our small MapStruct team.
We are happy to say welcome to [Andrei Arlou](https://github.com/Captain1653).
He has been busy answering questions, improving our codebase, fixing bugs and working on different enhancements for our next release. 

### Thanks

We are very proud and thankful of our of our growing community.
Recently we passed the 2000 stargazers milestone on GitHub.

Most impressive though are the download numbers we get from the Maven Central repo.
They have doubled since our last release and we have seen an amazing rate of our users upgrading to the latest release.
As an example here are the numbers for the _org.mapstruct:mapstruct-processor_ artifact:

<div style="text-align:center">
    <img src="/images/downloads_09-2018_09-2019.png" style="padding-bottom: 3px;"/>
</div>

Happy coding with MapStruct 1.3!!

### Download

You can fetch the new release from Maven Central using the following GAV coordinates:

* Annotation JAR: [org.mapstruct:mapstruct:1.3.1.Final](http://search.maven.org/#artifactdetails|org.mapstruct|mapstruct|1.3.1.Final|jar)
* Annotation processor JAR: [org.mapstruct:mapstruct-processor:1.3.1.Final](http://search.maven.org/#artifactdetails|org.mapstruct|mapstruct-processor|1.3.1.Final|jar)

Alternatively, you can get ZIP and TAR.GZ distribution bundles - containing all the JARs, documentation etc. - [from GitHub](https://github.com/mapstruct/mapstruct/releases/tag/1.3.1.Final).

If you run into any trouble or would like to report a bug, feature request or similar, use the following channels to get in touch:

* Get help at the [mapstruct-users](https://groups.google.com/forum/?fromgroups#!forum/mapstruct-users) group or in our [Gitter room](https://gitter.im/mapstruct/mapstruct-users)
* Report bugs and feature requests via the [issue tracker](https://github.com/mapstruct/mapstruct/issues)
* Follow [@GetMapStruct](https://twitter.com/GetMapStruct) on Twitter
