---
title: "Support for Java 8, JodaTime and more: MapStruct 1.0.0.Beta2 released"
author: Gunnar Morling
layout: news
tags: [release, news]
---

It's my great pleasure to announce the release of MapStruct 1.0.0.Beta2.

Amongst the new features is initial support for Java 8, built-in mappings for the types of the [Joda-Time](http://www.joda.org/joda-time/) date and time API, flexible mapping customization via inline Java expressions and much more.

Distribution bundles (ZIP, TAR.GZ) are available on [SourceForge](http://sourceforge.net/projects/mapstruct/files/1.0.0.Beta2/). Alternatively, you can obtain the dependencies from Maven Central. The GAV coordinates are:

* [org.mapstruct:mapstruct:1.0.0.Beta2](http://search.maven.org/#artifactdetails&#124;org.mapstruct&#124;mapstruct&#124;1.0.0.Beta2&#124;jar) for the annotation JAR, to be used with Java <= 7
* [org.mapstruct:mapstruct-jdk8:1.0.0.Beta2](http://search.maven.org/#artifactdetails&#124;org.mapstruct&#124;mapstruct-jdk8&#124;1.0.0.Beta2&#124;jar) for the annotation JAR, to be used with Java >= 8
* [org.mapstruct:mapstruct-processor:1.0.0.Beta2](http://search.maven.org/#artifactdetails&#124;org.mapstruct&#124;mapstruct-processor&#124;1.0.0.Beta2&#124;jar) for the annotation processor.

### Java 8

MapStruct now leverages the [repeating annotation](http://docs.oracle.com/javase/tutorial/java/annotations/repeating.html) feature introduced with Java 8. This allows to specify several `@Mapping` annotations on one and the same method in a very concise way:

<pre class="prettyprint linenums">
@Mapper
public interface AnimalMapper {
    
    @Mapping(source = "weightInPounds", target = "weight")
    @Mapping(source = "heightInCentimetres", target = "height")
    AnimalDto animalToAnimalDto(Animal animal);
}
</pre>

To make use of this feature be sure to include the right version of the annotation JAR (_org.mapstruct:mapstruct-jdk8:1.0.0.Beta2_), as only this version allows to specify several `@Mapping` annotations without wrapping them in `@Mappings` (apart from this, both versions of the annotation JAR are exactly the same).

### Joda-Time support

When using the Joda-Time API in your project you'll be glad to hear that MapStruct supports mappings of the Joda types now. More specifically, mappings between the following types are provided out-of-the-box:

* `org.joda.time.DateTime`, `org.joda.time.LocalDateTime` and `org.joda.time.LocalDate` <> `java.util.Date`
* `org.joda.time.DateTime` <> `java.util.Calendar`
* `org.joda.time.DateTime`, `org.joda.time.LocalDateTime`, `org.joda.time.LocalDate` and `org.joda.time.LocalTime` <> `String`

If you use these types in your mapped models, MapStruct will automatically generated the required mapping routines without any further configuration. `@Mapping#dateFormat()` can be used when converting from or to `String to specify the expected date format.

Note that for the following release [we plan](https://github.com/mapstruct/mapstruct/issues/121) to also cover the new Java 8 time and date types which will be useful when mapping between models using the old types such as `java.util.Date` and the new ones.

### Constants and inline Java expressions

The `@Mapping` annotation has been enriched with several new useful attributes. Via `constant()` you can set an attribute in the target object of a mapping to a fixed value:

<pre class="prettyprint linenums">
@Mapping(target = "weightUnit", constant="cm")
AnimalDto animalToAnimalDto(Animal animal);
</pre>

If the specified target property is not a String, the given value will be converted by applying one of the available conversions described in the [reference documentation](http://mapstruct.org/documentation/#section-05). That way you can e.g. specify constants for numeric or date attributes (optionally applying a given date format).

Sometimes it is not sufficient to map a single source property to a corresponding target property, but more flexible mappings are required. For such cases it is now possible to specify custom mapping expressions via the `expression()` attribute. The following shows an example:

<pre class="prettyprint linenums">
@Mapping(target = "fullName", expression = "java(visitor.getFirstName() + \" \" + visitor.getLastName())")
VisitorDto visitorToVisitorDto(Visitor visitor);
</pre>

Here a Java expression in the form `java(<EXPRESSION>)`is used to set an attribute in the target object based on the value of two properties from the source object. The given expression is transferred as is into the generated mapping method, so you'll get feedback about the correctness of the expression during compilation.

While [custom mappers](http://mapstruct.org/documentation/#section-05-03) and [decorators](http://mapstruct.org/documentation/#section-09) should still be the preferred way for implementing more complex custom mappings, such inline expressions are a very useful utility in many cases. E.g. you also could invoke a constructor to instantiate a specific property type.

Besides Java-based expressions [we plan]((https://github.com/mapstruct/mapstruct/issues/244)) to support a more concise expression language in a future release. E.g. the mapping from the previous example could be declared as follows using the [Unified Expression Language](https://jcp.org/en/jsr/detail?id=341):

<pre class="prettyprint linenums">
@Mapping(target = "fullName", expression = "uel(visitor.firstName + ' ' + visitor.lastName)")
VisitorDto visitorToVisitorDto(Visitor visitor);
</pre>

The idea here is to translate the given EL expression at generation time into a corresponding Java fragment. This would allow to leverage the expressive power of expression languages without adding any runtime dependencies to the generated code. At this point, this is just a vague idea, so any input or help with such feature is highly welcome.

### Sharing mapper configurations

In larger projects it can be useful to share the same configuration between several mapper classes, e.g. for the component model to be used (CDI, Spring, etc.). That's now possible via the `@MapperConfig` annotation. This annotation can be given on a central configuration class and defines a template for the different mapping settings:

<pre class="prettyprint linenums">
@MapperConfig(
    uses = { DateMapper.class, UnitsOfMeasurementMapper.class },
    unmappedTargetPolicy = ReportingPolicy.ERROR,
    componentModel = "cdi"
)
public class MapperConfiguration {}
</pre>
    
Specific mappers can then refer to this configuration source, thus inheriting its settings while allowing to override single settings if required:

<pre class="prettyprint linenums">
@Mapper()
    config = MapperConfiguration.class,
    unmappedTargetPolicy = ReportingPolicy.IGNORE
)
public class AnimalMapper {}
</pre>

### What else is in it?

Other useful features in the Beta2 release include support for "adder methods" (see [issues #207](https://github.com/mapstruct/mapstruct/issues/207)) and the possibility to ignore specific properties during the mapping (see [issue #72](https://github.com/mapstruct/mapstruct/issues/72)). In addition quite a few bugs have been fixed; Check out the [change log](https://github.com/mapstruct/mapstruct/issues?milestone=4&state=closed) for a complete list of all issues.

Your feedback is more than welcome, just add a comment below or join the [mapstruct-users](https://groups.google.com/forum/?fromgroups#!forum/mapstruct-users) group. Bugs and feature requests can be reported in the [issue tracker](https://github.com/mapstruct/mapstruct/issues). If you'd like to hack on MapStruct yourself, check out the [development guide](/contributing).

Finally, I'd like to say a massive thank you to [Sjaak Derksen](https://github.com/sjaakd/), [Andreas Gudian](https://github.com/agudian), [Timo Eckhardt](https://github.com/timoe) and [Christian Schuster](https://github.com/chschu) who all put huge efforts into this release. You guys rock!
