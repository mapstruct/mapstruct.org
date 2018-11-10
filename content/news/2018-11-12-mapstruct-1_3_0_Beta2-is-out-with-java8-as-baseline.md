---
title: "Java 8 as a baseline, null value property mappings improve builders supper and much more: MapStruct 1.3.0.Beta2 is out"
author: Filip Hrisafov
date: "2018-11-12"
tags: [release, news]
---

It's my pleasure to announce the second Beta release of MapStruct 1.3.

With the new Release we have finally made the switch to Java 8 as a baseline.

There are a whole lot of new enhancements as well, e.g.:

* New `NullValuePropertyMappingStrategy` for controlling how properties are for update methods
* Warnings for precision loss
* Caching and reusing `javax.xml.datatype.DatatyeFactory`
* Recursive source presence tracking
* Improvements in the builders support

<!--more-->

Altogether, no less than [35 issues](https://github.com/mapstruct/mapstruct/issues?q=milestone%3A1.3.0.Beta2) were fixed for this release.

This would not have been possible without our fantastic community of contributors:
[Florian Tavares](https://github.com/neoXfire),
[Christian Bandowski](https://github.com/chris922),
[Sivaraman Viswanathan](https://github.com/sivviswa22),
[Sebastian Haberey](https://github.com/sebastianhaberey),
[Saheb Preet Singh](https://github.com/sahebpreet),
as well as seasoned MapStruct hackers [Andreas Gudian](https://github.com/agudian), [Filip Hrisafov](https://github.com/filiphr), [Gunnar Morling](https://github.com/gunnarmorling) and [Sjaak Derksen](https://github.com/sjaakd).

Thanks a lot everyone for all your hard work!

Big thanks to all the users of the 1.3.0.Beta1 dependency of MapStruct.
It has helped us in ironing out our Builders support.

Enough of the pep talk, let's take a closer look at some of the new enhancements!

### Java 8 Baseline

Java 8 has been around for a long time and MapStruct has been working nicely with it for a long time.
Using it as a baseline would allow us to use some of it features and make it easier for us to maintain it for you.

The `mapstruct-jdk8` module has been relocated to `mapstruct`. 
Upgrade your dependencies in to use the `mapstruct` module.

### Control how null or not present properties are updated within a target bean

We have added a `NullValuePropertyMappingStrategy` that can be used to control how `null` or not present source properties are updated within a target.
The possibilities are:

* `SET_TO_NULL` - If the source property is `null` or not present the target property is set to `null`. 
This is also the default, which is the same behaviour from before.
* `SET_TO_DEFAULT` - If the source property is `null` or not present the target property is set to default (empty list, empty set, new object instantiation etc)
* `IGNORE` - If the source property is `null` or not present the target property is not set at all

This strategy can be set on `@Mapping`, `@BeanMapping`, `@Mapper` or `@MapperConfig` in precedence order.

While working on this we noticed that we handle bean properties that are collections or maps differently. This requires some background information: MapStruct generates mappings in-line in the bean mapping method implementation when the elemnts in the collections and key/values are of the same type. In this particular case, MapStruct was generating code that setting the target property to `null` when the source property was `null` or not present. 

We were generating code that looks like:

{{< prettify java >}}
public class CustomerMapperImpl implements CustomerMapper {

    @Override
    public CustomerDto mapCustomer(Customer customer) {
        ...
        CustomerDto customerDto = new CustomerDto();
        
        List<String> orders = customer.getOrders();
        if (orders != null) {
            customerDto.setOrders(orders);
        } else {
            customerDto.setOrders(nuLL);
        }
    }
}
{{< /prettify >}}

This generated code is not consistent with how other properties are mapped. 
Therefore we have adapted this not create the `else` branch.
In case you were relying on that branch we advice to use `@ObjectFactory` or set the default in the constructor of the target object.

The newly generated code looks like:

{{< prettify java >}}
public class CustomerMapperImpl implements CustomerMapper {

    @Override
    public CustomerDto mapCustomer(Customer customer) {
        ...
        CustomerDto customerDto = new CustomerDto();
        
        List<String> orders = customer.getOrders();
        if (orders != null) {
            customerDto.setOrders(orders);
        }
    }
}
{{< /prettify >}}

**NB**: In 1.2.0.Final with [#1273](https://github.com/mapstruct/mapstruct/issues/1273) we added support for using `NullValueMappingStrategy#RETURN_DEFAULT` to control how collections / maps default values are set in the scenario described above. 
We realised that this was a mistake on our side. The `NullValueMappingStrategy` is intended to be used on the result of the entire bean mapping mehod given a `null` source bean mapping argument (source bean). Specifically for update methods, the `NullValuePropertyMappingStrategy#SET_TO_DEFAULT` is intended to complement this functionality: giving control over the property mappings in case of `null` property source.
See [this](https://github.com/mapstruct/mapstruct/issues/1273#issuecomment-433507374) for more information.

### Warnings for precision loss

The `@Mapper` and `@MapperConfig` now have new `typeConversionPolicy` option that could be set to control how lossy (narrowing) conversion
(e.g. `long` to `int) should be reported.

### Caching and reusing DatatypeFactory

We are no longer creating a new `DatatypeFactory` instance when mapping into `XmlGregorianCalendar`.
Before we were doing a call to `DatatypeFactory.newInstance()` on every mapping. 
This call is an expensive call as it involves `ServiceLoader`usages.
In the new solution fields in the mapper initialized in the constructor of the mapper is used instead. 


### Improvements in the builders support

We have ironed out the builder support.
There was an issue with generic builders, which is now fixed.
Fluent setters were not working for methods starting with `is`.
Some imports for Immutables were missing.
Support for FreeBuilder has been enhanced by using a custom `FreeBuilderAccessorNamingStrategy` that disables the check for fluent setters. 
(see [this](https://github.com/mapstruct/mapstruct/commit/104ebf88da8c6145b790905f0c1db66a3cd35a6b) for more information).

For people that provide their own `BuilderProvider`.
We have changed the signature of the `findBuilderInfo` method. 
The `Elements` and `Types` utils are no longer passed in the method, but rather the SPI is initialized with the `MapStructProcessingEnvironment` before each annotation processing round.
If you are using the `DefaultBuilderProvider` as a basis you can access those utils through a `protected` class variable.

### When will 1.3.0.Final be released?

We have received this question a lot lately. 
We hope that this would be the last release before the 1.3.0.Final release.
We don't anticipate more issues with the builders support and if the feedback is good we would release the final in few weeks.

### Download

This concludes our tour through MapStruct 1.3 Beta2.
If you'd like to try out the features described above, you can fetch the new release from Maven Central using the following GAV coordinates:

* Annotation JAR: [org.mapstruct:mapstruct:1.3.0.Beta2](http://search.maven.org/#artifactdetails|org.mapstruct|mapstruct|1.3.0.Beta2|jar)
* Annotation processor JAR: [org.mapstruct:mapstruct-processor:1.3.0.Beta2](http://search.maven.org/#artifactdetails|org.mapstruct|mapstruct-processor|1.3.0.Beta2|jar)

Alternatively, you can get ZIP and TAR.GZ distribution bundles - containing all the JARs, documentation etc. - [from GitHub](https://github.com/mapstruct/mapstruct/releases/tag/1.3.0.Beta2).

If you run into any trouble or would like to report a bug, feature request or similar, use the following channels to get in touch:

* Get help at the [mapstruct-users](https://groups.google.com/forum/?fromgroups#!forum/mapstruct-users) group or in our [Gitter room](https://gitter.im/mapstruct/mapstruct-users)
* Report bugs and feature requests via the [issue tracker](https://github.com/mapstruct/mapstruct/issues)
* Follow [@GetMapStruct](https://twitter.com/GetMapStruct) on Twitter
* Follow MapStruct on [Google+](https://plus.google.com/u/0/118070742567787866481/posts)
