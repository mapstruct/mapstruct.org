---
title: "Support for builders, mapper constructor injection and much more: MapStruct 1.3.0.Beta1 is out"
author: Filip Hrisafov
date: "2018-07-15"
tags: [release, news]
---

It' my pleasure to announce the first Beta release of MapStruct 1.3.

The new release comes with a whole lot of new functionality, e.g.:

* Mapping of (immutable) objects using builders
* Constructor injection for Annotation Based component models
* `unmappedSourcePolicy` support
* Support for defaultExpression
* Limit mapping only to explicitly defined mappings
* Performance improvement of `constant` / `defaultValue` primitive to `String` mappings

<!--more-->

Altogether, not less than [59 issues](https://github.com/mapstruct/mapstruct/issues?q=milestone%3A1.3.0.Beta1) were fixed for this release.

This would not have been possible without our fantastic community of contributors:
[Christian Bandowski](https://github.com/chris922), 
[David Feinblum](https://github.com/dvfeinblum), 
[Darren Rambaud](https://github.com/xyzst), 
[Daniel Strobusch](https://github.com/dastrobu), 
[Eric Martineau](https://github.com/ericmartineau), 
[Gervais Blaise](https://github.com/gervaisb), 
[Jeff Smyth](https://github.com/smythie86), 
[Joshua Spoerri](https://github.com/spoerri),
[Kevin Grüneberg](https://github.com/kevcodez),
[Lauri Apple](https://github.com/lappleapple),
[Richard Lea](https://github.com/chigix),
[Sergey Grekov](https://github.com/sgrekov),
[Tomoya Yokota](https://github.com/yokotaso),
as well as seasoned MapStruct hackers [Andreas Gudian](https://github.com/agudian), [Filip Hrisafov](https://github.com/filiphr), [Gunnar Morling](https://github.com/gunnarmorling) and [Sjaak Derksen](https://github.com/sjaakd).

Thanks a lot everyone for all your hard work!

Big thanks to all the users of the 1.3.0-SNAPSHOT dependency of MapStruct.
Without their input we would not have been able to release such a thorough support of the Builder mappings.

Enough of the pep talk, let's take a closer look at some of the new features!

### Mapping of (immutable) objects using builders

Use of builder to [map (immutable) objects](https://github.com/mapstruct/mapstruct/issues/782) has been one of the most requested features of MapStruct.

We are happy to announce that as of 1.3.0.Beta1 MapStruct has out of the box support for builders.
Works with:

* [Lombok](https://projectlombok.org/) - requires having the Lombok classes in a separate module see [rzwitserloot/lombok#1538](https://github.com/rzwitserloot/lombok/issues/1538)
* [AutoValue](https://github.com/google/auto/blob/master/value/userguide/index.md)
* [Immutables](https://immutables.github.io/)
* [FreeBuilder](https://github.com/google/FreeBuilder)
* [Protocol Buffer builder](https://developers.google.com/protocol-buffers/docs/javatutorial)
* It also works for custom builders if the object being build provides a parameterless public static method for instantiating the builder. Otherwise, you would need to write a custom `BuilderProvider`

For more details how the Builder support works have a look at the [Using builders](http://mapstruct.org/documentation/dev/reference/html/#mapping-with-builders) of the reference guide 

We have modified our example project with protobuf support to use the out of the box support for Builders. Have a look at it [here](https://github.com/mapstruct/mapstruct-examples/tree/master/mapstruct-protobuf3).

### Constructor injection for annotation based component models

Construction injection for annotation based component models (`spring`, `cdi`, `jsr330`) can bow [be used](https://github.com/mapstruct/mapstruct/issues/571).

Example:

{{< prettify java >}}
@Mapper(uses = OrderMapper.class, componentModel = "spring", injectionStrategy = InjectionStrategy.CONSTRUCTOR)
public interface CustomerMapper {

    CustomerDto mapCustomer(Customer customer);
}
{{< /prettify >}}

### Support for unmapped properties in the source type

Using `Mapper#unmappedSourcePolicy` one can now control how unmapped properties of the source type of a mapping should be reported.
For backwards compatibility it is set to `ReportingPolicy.IGNORE`.

### Support for defaultExpression

`Mapping#defaultExpression` can now [be used](https://github.com/mapstruct/mapstruct/issues/1363) to customize the default value of a mapping.

{{< prettify java >}}
@Mapper
public interface CustomerMapper {

    @Mapping(target = "id", defaultExpression = "java(UUID.randomUUID().toString())")
    PersonDto map(Person person);
}
{{< /prettify >}}

### Limit mapping only to explicitly defined mappings

By using `@BeanMapping(ignoreByDefault = true)` one can limit the mapping only to the explicitly defined mappings. 
This annotation actually applies ignore to all target properties, which means that it can be used in configuration mappings to only map explicit properties in base classes.

### Performance improvement of constant / defaultValue primitive to String mappings

With [#1401](https://github.com/mapstruct/mapstruct/issues/1401) we now try to check if it is possible to assign a `defaultValue` and / or a `constant` directly without doing a conversion. 
For example for the following mapper:

{{< prettify java >}}
@Mapper
public interface PersonMapper {

    @Mapping(target = "price", constant = "10.5")
    @Mapping(target = "age", defaultValue = "10)
    Order order(OrderDto source);   
}
{{< /prettify >}}

Before the following was generated:

{{< prettify java >}}
public class PersonMapperImpl implements PersonMapper {

    @Override
    public Order order(OrderDto source) {
        if (source == null) {
            return null;
        }

        Order order = new Order();
        order.setConstant(Double.parseDouble("10.5"));
        if (source.getAge() == null) {
            order.setAge(Integer.parse("10"));
        } else {
            order.setAge(source.getAge());
        }
        return order;
    } 
}
{{< /prettify >}}

And now the following is generated:

{{< prettify java >}}
public class PersonMapperImpl implements PersonMapper {

    @Override
    public Order order(OrderDto source) {
        if (source == null) {
            return null;
        }

        Order order = new Order();
        order.setConstant(10.5));
        if (source.getAge() == null) {
            order.setAge(10);
        } else {
            order.setAge(source.getAge());
        }
        return order;
    } 
}
{{< /prettify >}}

### Enhancements

* Package private mappers with the default component model
* Improve performance of `mapstruct-processor` on Java 9
* Support for using `@ObjectFactory` on objects passed with `@Context`
* Implicit converstion between `String` and `java.util.Currency`
* Improved error messages and locations

### Download

This concludes our tour through MapStruct 1.3 Beta1.
If you'd like to try out the features described above, you can fetch the new release from Maven Central using the following GAV coordinates:

* Annotation JAR: [org.mapstruct:mapstruct-jdk8:1.3.0.Beta1](http://search.maven.org/#artifactdetails|org.mapstruct|mapstruct-jdk8|1.3.0.Beta1|jar) (for usage with Java >= 8) 
or [org.mapstruct:mapstruct:1.3.0.Beta1](http://search.maven.org/#artifactdetails|org.mapstruct|mapstruct|1.3.0.Beta1|jar) (for earlier Java versions)
* Annotation processor JAR: [org.mapstruct:mapstruct-processor:1.3.0.Beta1](http://search.maven.org/#artifactdetails|org.mapstruct|mapstruct-processor|1.3.0.Beta1|jar)

Alternatively, you can get ZIP and TAR.GZ distribution bundles - containing all the JARs, documentation etc. - [from GitHub](https://github.com/mapstruct/mapstruct/releases/tag/1.3.0.Beta1).

If you run into any trouble or would like to report a bug, feature request or similar, use the following channels to get in touch:

* Get help at the [mapstruct-users](https://groups.google.com/forum/?fromgroups#!forum/mapstruct-users) group or in our [Gitter room](https://gitter.im/mapstruct/mapstruct-users)
* Report bugs and feature requests via the [issue tracker](https://github.com/mapstruct/mapstruct/issues)
* Follow [@GetMapStruct](https://twitter.com/GetMapStruct) on Twitter
* Follow MapStruct on [Google+](https://plus.google.com/u/0/118070742567787866481/posts)
