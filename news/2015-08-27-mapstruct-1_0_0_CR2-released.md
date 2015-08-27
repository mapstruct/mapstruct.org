---
title: "MapStruct 1.0.0.CR2 released"
author: Andreas Gudian
layout: news
tags: [release, news]
---

It is my pleasure to announce the second candidate release of MapStruct 1.0!

With this release, we're fixing several bugs that showed up after our first candidate release. But we also received some great new feature contributions from the community that we want to include in our 1.0 release, so we decided to build this second candidate release before calling it a _final_. Highlights of this release are:

* Configure package and class name for the generated mapper implementations.
* Define default values for target properties in case the source property is `null`.
* The decorator feature now fully works with Spring and JSR 330 and the documentation has been clarified on how to use decorators with all our supported component models (CDI, Spring, JSR 330, default).

The complete list of 19 closed issues can be found in the [change log](https://github.com/mapstruct/mapstruct/issues?q=milestone%3A1.0.0.CR2).

The MapStruct team calls out a big _Thank you!_ to everyone contributing to this release: [Tomek Gubala](https://github.com/vgt-tomek), [Ivo Smid](https://github.com/bedla), [Mustafa Caylak] (https://github.com/luxmeter), and [Christophe Labouisse](https://github.com/ggtools)! 

### Download

To fetch MapStruct 1.0.0.CR2 via Maven, Gradle or similar dependency management tools, use the following GAV coordinates:

* [org.mapstruct:mapstruct:1.0.0.CR2](http://search.maven.org/#artifactdetails|org.mapstruct|mapstruct|1.0.0.CR2|jar) for the annotation JAR (to be used with Java <= 7) or [org.mapstruct:mapstruct-jdk8:1.0.0.CR2](http://search.maven.org/#artifactdetails|org.mapstruct|mapstruct-jdk8|1.0.0.CR2|jar) (for usage with Java >= 8)
* [org.mapstruct:mapstruct-processor:1.0.0.CR2](http://search.maven.org/#artifactdetails|org.mapstruct|mapstruct-processor|1.0.0.CR2|jar) for the annotation processor.

Alternatively, you can download distribution bundles (ZIP, TAR.GZ) from [SourceForge](http://sourceforge.net/projects/mapstruct/files/1.0.0.CR2/) or from [BinTray](https://bintray.com/artifact/download/mapstruct/bundles/).

### Configure package and class name for the generated mapper implementations

By default, MapStruct generates the mapper implementation with the class name suffix "Impl" in the same package as the declared mapper interface or abstract class.

If a project follows different naming conventions, package-dependency rules or simply a ambiguity needs to be resolved, the package name and the class name of the generated implementation can be configured:

<pre class="prettyprint linenums">
package org.mapstruct.examples.mappers;

...

@Mapper(implementationPackage = "&lt;PACKAGE_NAME&gt;.generated", implementationClass = "MapStruct&lt;CLASS_NAME&gt;Impl")
public interface PersonMapper {
    PersonMapper INSTANCE = Mappers.getMapper( PersonMapper.class );

    PersonDto toPersonDto(Person person);
}
</pre>

In the example above, the mapper implementation would be generated to the package `org.mapstruct.examples.mappers.generated` with the class name `MapStructPersonMapperImpl`. As you might have already guessed, the strings `<PACKAGE_NAME>` and `<CLASS_NAME>` are replaced with the package name and the class name of the mapper interface or abstract class for which the implementation is generated.

These options are also available in the annotation `@MapperConfig`, so you can configure this once for all mappers that use the same [`@Mapper#config`](http://mapstruct.org/documentation/#section-shared-config) type.

If you are using the component model `default` (i.e. `Mappers.get(..)`) to obtain your mapper instances, the generator will create an SPI file in _META-INF/services/_ for each mapper with a customized naming pattern. The implementation of `Mappers` finds those implementation classes using the `ServiceLoader` API.

### Default values for target properties in case the source property is null

Default values can be specified to set a predefined value to a target property if the corresponding source property is `null`.

<pre class="prettyprint linenums">
@Mapper
public interface PersonMapper {
   @Mapping(target = "middleName", defaultValue = ""),
   PersonDto toPersonDto(Person person);
}
</pre>

The implementation that is generated for the example above would set the property `middleName` in the result object to the empty String `""` in case `person.getMiddleName() == null`. If the target property for which the default assignment shall be done is not of type `String`, the usual type conversion / type mapping mechanism is applied.

### What's next?

With CR2 out, we want to release MapStruct 1.0 Final as soon as possible. We won't add any new features or large refactorings for 1.0 and will allow only bugfixes. Based on the number of bugs reported against CR2, we should be ready to build the Final within the next couple of weeks.

In the mean time, you're invited to try out the MapStruct [Eclipse plug-in](https://github.com/mapstruct/mapstruct-eclipse). Altough it's in an early stage, it already contains some handy content-assists (e.g. for `source` and `target` property names in the `@Mapping` annotation) and quick-fixes for some common errors and warnings created by MapStruct.

Finally, some useful links:

* Get help at the [mapstruct-users](https://groups.google.com/forum/?fromgroups#!forum/mapstruct-users) group
* Report bugs and feature requests via the [issue tracker](https://github.com/mapstruct/mapstruct/issues)
* Follow [@GetMapStruct](https://twitter.com/GetMapStruct) on Twitter
* Follow MapStruct on [Google+](https://plus.google.com/u/0/118070742567787866481/posts)
