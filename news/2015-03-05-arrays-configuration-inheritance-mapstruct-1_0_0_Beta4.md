---
title: "Array mappings, configuration inheritance: MapStruct 1.0.0.Beta4 released"
author: Gunnar Morling
layout: news
tags: [release, news]
---

The MapStruct community proudly announces the release of MapStruct 1.0.0.Beta4!

The new release provides support for mapping arrays of Java beans, re-use of mapping configurations via a brand-new inheritance mechanism and ordered setter invocations on the target side. We also fixed quite a few bugs. You can find the complete list of 48 issues in the [change log](https://github.com/mapstruct/mapstruct/issues?q=milestone%3A1.0.0.Beta4). When upgrading from a previous Beta release, please check out the [migration notes](https://github.com/mapstruct/mapstruct/wiki/Migration-notes) for changes which may affect existing applications.

One thing I'm especially excited about is the new MapStruct Eclipse plug-in which will give you an even better experience when using MapStruct within the Eclipse IDE. You'll find out more below.

This release has been a true team effort; Many, many thanks to [Sjaak Derksen](https://github.com/sjaakd/), [Andreas Gudian](https://github.com/agudian), [Timo Eckhardt](https://github.com/timoe), [Ewald Volkert](https://github.com/eforest), [Christian Schuster](https://github.com/chschu), [Sebastian Hasait](https://github.com/shasait) and [Dilip Krishnan](https://github.com/dilipkrish) who all worked on the Beta4 release.

### Array mappings

While MapStruct has had support for mapping collections (`List`, `Set` etc.) of primitive and Java bean types for a long time, this was not the case for arrays. This is finally possible, so you can now declare mapping methods such as the following:

<pre class="prettyprint linenums">
@Mapper
public interface CustomerMapper {

    CustomerDto[] customersToDtos(Customer[] customers);

    CustomerDto customerToDto(Customer customer);
}
</pre>

As known from collection mapping methods, the generated `customersToDtos()` implementation will invoke the `customerToDto()` method for mapping the individual array elements. Similar to collection mapping methods, you can use the `@IterableMapping` annotation for applying specific configuration options:

<pre class="prettyprint linenums">
@IterableMapping(dateFormat = "dd.MM.yyyy")
String[] dateArrayToStringArray(Date[] dates);
</pre>

If needed, you also can map between collections and arrays:

<pre class="prettyprint linenums">
CustomerDto[] customersToDtos(List&lt;Customer&gt; customers);
</pre>

### Configuration inheritance

With help of the new `@InheritConfiguration` annotation you can advice MapStruct to apply the configuration from one mapping method to another.

This comes in handy for instance when having a "normal" mapping method and an update method for the same types. Instead of configuring both methods individually, you can let one method inherit the configuration from the other:

<pre class="prettyprint linenums">
@Mapping(target="lastName", source="surName")
@Mapping(target="accountNumber", source="customerNumber")
Customer customerDtoToCustomer(CustomerDto customerDto);

@InheritConfiguration
void updateCustomerFromDto(CustomerDto dto, @MappingTarget customer);
</pre>

The `@InheritConfiguration` annotation will let the `updateCustomerFromDto()` inherit all the mappings from `customerDtoToCustomer()`. The selection of the template method is done by matching source and target types, but you could explicitly specify a method as configuration source if needed.

Configuration inheritance is particularly useful when working with complex type hierarchies. You can define a configuration for the base types of the source and target models and let specific mapping methods inherit this configuration. But what if a base type is abstract? Naturally, MapStruct cannot generate an implementation of a method whose return type is an abstract one.

This can be resolved by declaring a "prototype method" within a [configuration class](/documentation/#section-shared-config) referenced by the mapper:

<pre class="prettyprint linenums">
@Mapper(config=BaseMappings.class)
public interface CustomerMapper {

    @InheritConfiguration(name="anyDtoToEntity")
    CustomerDto customerToDto(Customer customer);
}
</pre>

<pre class="prettyprint linenums">
@MapperConfig
public interface BaseMappings {

    // no implementation will be generated, it only serves as configuration source
    @Mapping(target = "primaryKey", source = "id")
    BaseDto anyEntityToDto(BaseEntity entity);
}
</pre>

Methods declared within configuration classes such as `BaseMappings` are not usable as mapping methods themselves (no implementation will be generated for them). They solely serve as configuration source. In the example the `customerToDto()` method would inherit the configuration given at `anyEntityToDto()`.

Note that you optionally can have prototype configurations automatically be applied to methods with compatbile source and target types. You can find the details in the [reference documentation](/documentation/#section-inherit-config).

### Ordered setter invocations

Sometimes it is required to invoke the setters of the target bean in a specific order, e.g. if one setter depends on the value of other properties of the same bean. For that purpose there is a new attribute on the `@Mapping` annotation, `dependsOn()`. The following shows an example:

<pre class="prettyprint linenums">
@Mapping(target = "givenName", source = "firstName")
@Mapping(target = "middleName", dependsOn = "givenName")
@Mapping(target = "lastName", dependsOn = "middleName")
AddressDto addressToDto(Address address);
</pre>

This configuration makes sure that the generated implementation of `addressToDto()` first calls `setGivenName()`, then `setMiddleName()` and finally `setLastName()`. A single property can also depend on several other ones:

<pre class="prettyprint linenums">
@Mapping(target = "lastName", dependsOn = { "firstName", "middleName"})
AddressDto addressToDto(Address address);
</pre>

This would ensure that `setLastName()` is invoked after `setGivenName()` and `setMiddleName()`, but no guarantee is given for the order of these two.

### MapStruct Eclipse plug-in

Being a JSR 269 annotation processor, MapStruct is meant to run equally well within command line builds (plain javac, Mavent etc.) as well as IDEs. Indeed the annotation processor works nicely for instance in Eclipse, generating mappers upon save, showing error markers next to the affected elements etc.

Still there are some advanced features which cannot be provided by an annotation processor, e.g. auto-completion for annotation attributes, refactoring support, navigation to referenced elements and more. This is where the [MapStruct Eclipse plug-in](https://github.com/mapstruct/mapstruct-eclipse/) comes in.

Developed by my good friend [Lars Wetzer](https://github.com/larswetzer), it aims at providing an even better experience when using MapStruct within Eclipse. The plug-in is still at a very early stage, currently it provides auto-completion for `@Mapping#source()` and `target()`. The following shows a screenshot:

<div style="text-align:center">
    <img src="/images/mapstruct-eclipse-plugin.png" style="padding-bottom: 3px;"/>
</div>

More functionality will be coming soon. You can find the list of features planned for the plug-in [here](https://github.com/mapstruct/mapstruct-eclipse/issues). There is no official release of the plug-in yet. But if you feel adventurous, you can install the latest nightly build from the [update site](https://mapstruct.ci.cloudbees.com/job/mapstruct-eclipse/lastSuccessfulBuild/artifact/org.mapstruct.eclipse.repository/target/repository/) at our CI server.

### Download

If you work with Maven, Gradle or another dependency management tool, use the following GAV coordinates to obtain the MapStruct artifacts from Maven Central:

* [org.mapstruct:mapstruct:1.0.0.Beta4](http://search.maven.org/#artifactdetails&#124;org.mapstruct&#124;mapstruct&#124;1.0.0.Beta4&#124;jar) for the annotation JAR (to be used with Java <= 7) or [org.mapstruct:mapstruct-jdk8:1.0.0.Beta4](http://search.maven.org/#artifactdetails&#124;org.mapstruct&#124;mapstruct-jdk8&#124;1.0.0.Beta4&#124;jar) (for usage with Java >= 8)
* [org.mapstruct:mapstruct-processor:1.0.0.Beta4](http://search.maven.org/#artifactdetails&#124;org.mapstruct&#124;mapstruct-processor&#124;1.0.0.Beta4&#124;jar) for the annotation processor.

Alternatively, you can download distribution bundles (ZIP, TAR.GZ) from [SourceForge](http://sourceforge.net/projects/mapstruct/files/1.0.0.Beta4/).

The Beta4 contains almost all the features we envisioned for the 1.0 release. We'll now focus on bug-fixing and addressing some more minor edge cases. The CR1 (candidate release) should be out in four to six weeks from now, followed by 1.0 Final after four more weeks from there.

Finally, some useful links:

* Get help at the [mapstruct-users](https://groups.google.com/forum/?fromgroups#!forum/mapstruct-users) group
* Report bugs and feature requests via the [issue tracker](https://github.com/mapstruct/mapstruct/issues)
* Follow [@GetMapStruct](https://twitter.com/GetMapStruct) on Twitter
* Follow MapStruct on [Google+](https://plus.google.com/u/0/118070742567787866481/posts)
