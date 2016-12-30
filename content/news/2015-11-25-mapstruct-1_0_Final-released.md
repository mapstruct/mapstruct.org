---
title: "MapStruct 1.0 Final released"
author: Gunnar Morling
date: "2015-11-25"
tags: [release, news]
---

It's with great pleasure and excitement that I announce the final release of MapStruct 1.0!

MapStruct is a source code generator for efficient, type-safe mappings between Java bean types, based on [annotated interface definitions](/documentation/#section-def-mapper). It works in your command line builds (e.g. via Maven or Gradle) as well as your favourite IDE. The advantages of this approach are manifold:

* **Great performance:** Plain method invocations only, no use of reflection
* **Compile-time type safety:** Only objects and attributes actually mapping to each other can be mapped, no accidental mapping of an order entity into a customer DTO etc.
* **Self-contained code:** no runtime dependencies
* **Early validation and fast feedback:** Clear error-reports right at build time if mappings are not complete or incorrect
* **Easy to debug:** You can inspect the generated mapping in your IDE

If you are new to MapStruct, I recommend you check out the "MapStruct in 2 minutes" section on the [homepage](/) to see what MapStruct can do for you and how it works.

### Looking back...

When I started the project over three years ago, I was quite fond of the idea of addressing the mapping issue with code generation, but I didn't really expect much interest by others. But, the wonders of open source happened and people started to ask questions about the project on the mailing list, filed feature and pull requests, [presented](http://tux2323.blogspot.de/2014/03/mapstruct-java-bean-mappings.html) [MapStruct](http://blog.goyello.com/2015/08/11/take-the-map-dto-survival-code/) [in](http://www.frank-rahn.de/java-bean-mapper/) [blog](http://javabarista.blogspot.de/2015/04/bean-mapping-mit-mapstruct.html) [posts](https://samerabdelkafi.wordpress.com/2015/10/18/mapstruct/) and [conference](http://www.muchsoft.com/presentations/MATHEMA-Campus-2015-MapStruct.pdf) [talks](http://de.slideshare.net/inovex/mapstruct-der-neue-stern-am-beanmapping-himmel), etc. Apparently, the project scratched an itch for many.

A small - yet very active - community grew.

Despite it's pre-final status until today, MapStruct is very solid and stable and has been used successfully by lots of projects in a wide range of industries. The [recent integration](http://jhipster.github.io/using_dtos.html) into the JHipster stack greatly increased the project's exposure and is a strong catalyst for further rising adoption. I can't give you a list of Fortune 500 companies using it, but I bet some are :)

It's a whole bunch of awesome people who have made this a reality. The project wouldn't be near where it is today without their great ideas and hard work. It was [Andreas Gudian](https://twitter.com/AndreasGudian) who confirmed me in the usefulness of the project, so we picked it up again together after my initial enthusiam had shortly been fading a bit. Not much later [Sjaak Derksen](https://twitter.com/sjaakderksen) arrived to the scene and right from the spot he helped with hacking on the toughest issues which Andreas and I had not felt like attacking.

In addition to these two fine guys many more have been contributing to the MapStruct code base over time in one way or the other: Christian Schuster, Christophe Labouisse, Dilip Krishnan, Ewald Volkert, Ivo Smid, Lars Wetzer, Lukasz Kryger, Michael Pardo, Mustafa Caylak, Paul Strugnell, Remko Plantenga, Sebastian Hasait, Stefan Rademacher, Timo Eckhardt, Tomek Gubala and anyone I may have forgotten.

A huge thank you to all of you! Special kudos go to Gerd Wütherich who designed the logo for project, which had been a missing piece for the final release for quite some time :)

### ...and forward

With MapStruct 1.0 through the door, it's time to think about what's coming next.

Based on user feedback, we've collected quite some ideas for a 1.1 release, be it support for custom bean constructors, direct field access or a small expression language for more concise and powerful inline mapping expressions. You input matters, so please raise your voice if you think something useful is missing from MapStruct.

Another focus of attention will be on the MapStruct [Eclipse plug-in](https://github.com/mapstruct/mapstruct-eclipse) which already is quite capable but should be even more so with the planned refactoring support, more quick fixes etc. Also we've planned to make it available through the Eclipse market place. Last but not least, we'll spend some time on improving the project website - especially the [documentation page](/documentation) - in order to make all the contents added over time accessible in a better way.

But in the meantime, enjoy the MapStruct 1.0.0.Final release!

It's already on [Maven Central](http://search.maven.org/#search|ga|1|g%3A%22org.mapstruct%22) and [SourceForge](http://sourceforge.net/projects/mapstruct/files/1.0.0.Final/). Functionally, the Final is the same as CR2, just [some remaining bugs](https://github.com/mapstruct/mapstruct/issues?q=milestone%3A1.0.0.Final+is%3Aclosed) have been fixed. We'd love to be hearing from you, so if you have any ideas, questions or other feedback on MapStruct, please get in touch through the following channels and we'll be glad to help:

* Get help at the [mapstruct-users](https://groups.google.com/forum/?fromgroups#!forum/mapstruct-users) group
* Report bugs and feature requests via the [issue tracker](https://github.com/mapstruct/mapstruct/issues)
* Follow [@GetMapStruct](https://twitter.com/GetMapStruct) on Twitter
* Follow MapStruct on [Google+](https://plus.google.com/u/0/118070742567787866481/posts)

Happy Mapping!
