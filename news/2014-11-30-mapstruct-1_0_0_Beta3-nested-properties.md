---
title: "MapStruct 1.0.0.Beta3 is out with nested properties, qualifiers and more"
author: Gunnar Morling
layout: news
tags: [release, news]
---

I'm delighted to announce the release of MapStruct 1.0.0.Beta3.

This version brings the long awaited support for mapping nested source properties, built-in mappings for Java 8 date/time types, fine-grained selection of mapping methods via qualifiers and much more. You can find the complete list of a whopping 46 closed issues [here](https://github.com/mapstruct/mapstruct/issues?page=2&q=milestone%3A1.0.0.Beta3+is%3Aclosed).

Note that existing applications using MapStruct need to adapt to some changes we had to do in order to iron out some glitches from the previous beta releases. These changes are described in more detail at the end of this post.

Before diving into the details, let me say a huge thank you to [Sjaak Derksen](https://github.com/sjaakd/), [Andreas Gudian](https://github.com/agudian), [Timo Eckhardt](https://github.com/timoe) and [Christian Schuster](https://github.com/chschu)! Again you guys went far beyond what anyone could have hoped for; this release would not have been possible without you.

### Mapping nested properties

One of the most wished-for features in MapStruct was to map attributes from nested elements of a source object (tree) into target objects. That's finally possible now, using simple "dot paths", just as you'd expect it:

<pre class="prettyprint linenums">
@Mapper
public interface CustomerMapper {

    @Mapping(source = "address.firstName", target = "firstName")
    @Mapping(source = "address.lastName", target = "lastName")
    CustomerDto customerToDto(Customer customer);
}
</pre>

This mapping method will map the `firstName` and `lastName` attributes from the `Address` object referenced by the mapped `Customer` object to the `firstName` and `lastName` properties of the target object.

Of course you also can refer to properties nested deeper in the hierarchy, e.g. `address.city.name`. That's a great way to flatten and select parts of complex hierarchies e.g. for view objects returned to a client.

### Improved built-in mappings

There is now built-in support for the Java 8 time and date types (JSR 310). That means properties of types such as `java.time.ZonedDateTime` or `java.time.LocalDateTime` will automatically be mapped to `String`s as well as the legacy date types `java.util.Calendar` and `java.util.Date`. Also `java.util.Calendar` will automatically mapped to `String` and `java.util.Date`.

Refer to the [documentation](/documentation/#section-05) for the list of all built-in mappings.

Another improvement relates to the mapping of collection-typed properties. Let's assume the `Order` class from the previous example had a `List<OrderLine>` which should be mapped to a list of DTOs in the target object. So far you would have been required to declare a method such as the following on the mapper interface:

<pre class="prettyprint linenums">
List&lt;OrderLineDto&gt; orderLinesToOrderLineDtos(Iterable&lt;OrderLine&gt; orderLines);
</pre>

That's not necessary any longer, it will now be added automatically as a private method to the generated mapper class if required.

### Qualifiers

Qualifiers provide a way to resolve ambiguities in case several mapping methods are suitable to map a given bean property. E.g. let's assume you'd have two methods for mapping `Date`s into `String`s in a manually implemented mapper class:

<pre class="prettyprint linenums">
public class DateMapper {

    // returns e.g. 2014-30-11
    String dateToString(Date date) { ... }

    // returns e.g. 2014-30-11 18:16
    String dateToStringWithTime(Date date) { ... }
}
</pre>

That mapper is used by MapStruct-generated mapper:

<pre class="prettyprint linenums">
@Mapper(uses=DateMapper.class)
public class OrderMapper {

    // Order#date of type Date, OrderDto#date of type String
    OrderDto orderToOrderDto(Order order);
}
</pre>

In previous releases you'd have gotten an error during generation, as both methods from `DateMapper` are suitable to map the `date` property. You can now use qualifiers to resolve that ambiguity and specify which method should be used. To do so, define a simple qualifier annotation type:

<pre class="prettyprint linenums">
@Qualifier
@Target(ElementType.METHOD)
public @interface ShortDate {}
</pre>

Tag mapping methods using such qualifiers like so:

<pre class="prettyprint linenums">
public class DateMapper {

    @ShortDate
    String dateToString(Date date) { ... }

    @LongDate
    String dateToStringWithTime(Date date) { ... }
}
</pre>

And specify a qualifier via `@Mapping` for the concerned property:

<pre class="prettyprint linenums">
@Mapper(uses=DateMapper.class)
public class OrderMapper {

    @Mapping(target="date", qualifiedBy = ShortDate.class)
    OrderDto orderToOrderDto(Order order);
}
</pre>

This will make sure that the `dateToString()` method will be invoked to map the order date property. If required, you also could specify several qualifiers via `qualifiedBy()`.

### Migration notes

For the sake of increased consistency and better usability, we had to do some changes which may require existing applications which already use MapStruct to be adapted. Most prominently, [reverse mapping methods](/documentation/#section-10) must now be explicitly marked as such using the new `@InheritInverseConfiguration` annotation:

<pre class="prettyprint linenums">
@Mapper(uses=DateMapper.class)
public class OrderMapper {

    OrderDto orderToOrderDto(Order order);

    @InheritInverseConfiguration
    Order orderDtoToOrder(OrderDto order);
}
</pre>

That annotation makes it explicit which one is the reverse mapping method and thus should inherit the configuration from its counterpart. You still can add further mappings to the reverse method in order to amend or override the inherited mappings. `@InheritInverseConfiguration` can also be used to specify the name of the method to inherit from in case several methods qualify as per their source and target types.

Another change affects the existing [processor options](http://localhost:9009/documentation/#section-02-01). In order to avoid conflicts with other annotation processors, these options must now be given using the "mapstruct." prefix, e.g. "mapstruct.suppressGeneratorTimestamp".

We have created a [wiki page](https://github.com/mapstruct/mapstruct/wiki/Migration-notes) where we'll collect all incompatible changes for future releases. Of course we'll try hard to avoid this sort of changes whenever possible.

### How do I get it?

You can fetch distribution bundles (ZIP, TAR.GZ) from [SourceForge](http://sourceforge.net/projects/mapstruct/files/1.0.0.Beta3/). Alternatively, you can obtain the dependencies from Maven Central. The GAV coordinates are:

* [org.mapstruct:mapstruct:1.0.0.Beta3](http://search.maven.org/#artifactdetails&#124;org.mapstruct&#124;mapstruct&#124;1.0.0.Beta3&#124;jar) for the annotation JAR (to be used with Java <= 7) or [org.mapstruct:mapstruct-jdk8:1.0.0.Beta3](http://search.maven.org/#artifactdetails&#124;org.mapstruct&#124;mapstruct-jdk8&#124;1.0.0.Beta3&#124;jar) (for usage with Java >= 8)
* [org.mapstruct:mapstruct-processor:1.0.0.Beta3](http://search.maven.org/#artifactdetails&#124;org.mapstruct&#124;mapstruct-processor&#124;1.0.0.Beta3&#124;jar) for the annotation processor.

The Beta3 release is planned to be the last beta, next will be CR1 (candidate release).

Anything you'd like to propose for inclusion in the 1.0 Final release? Then let us know by commenting below or posting to the [mapstruct-users](https://groups.google.com/forum/?fromgroups#!forum/mapstruct-users) group. Bugs and feature requests can be reported in the [issue tracker](https://github.com/mapstruct/mapstruct/issues). And if you'd like to hack on MapStruct yourself, check out the [development guide](/contributing).
