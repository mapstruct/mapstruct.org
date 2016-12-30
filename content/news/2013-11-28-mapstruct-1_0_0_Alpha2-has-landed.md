---
title: MapStruct 1.0.0.Alpha2 has landed!
author: Gunnar Morling
date: "2013-11-28"
tags: [release, news]
---

It is my great pleasure to announce the release of MapStruct 1.0.0.Alpha2.

This took us a bit longer than expected, but the new release offers quite a few exciting new features we hope you'll enjoy. The JARs have already been synched to Maven Central. The coordinates are:

* [org.mapstruct:mapstruct:1.0.0.Alpha2](http://search.maven.org/#artifactdetails&#124;org.mapstruct&#124;mapstruct&#124;1.0.0.Alpha2&#124;jar) for the annotation JAR and 
* [org.mapstruct:mapstruct-processor:1.0.0.Alpha2](http://search.maven.org/#artifactdetails&#124;org.mapstruct&#124;mapstruct-processor&#124;1.0.0.Alpha2&#124;jar) for the annotation processor.

Alternatively you can get a [distribution bundle](http://sourceforge.net/projects/mapstruct/files/1.0.0.Alpha2/) from SourceForge.

Beside several new mapping features (e.g. combining several sources into one target object) the release provides integration with CDI and Spring to make the retrieval of mapper objects more comfortable. We've added several new implicit data type conversions and there is now also support for converting `Map` objects.

Let's have a closer look at some of the additions.

### Advanced mapping features

When working with data transfer objects (DTO) to pass data from the backend to the client, it is common to have one DTO which transports the data from several entities. For this purpose MapStruct supports now mapping methods with several source methods. The following shows an example:

<pre class="prettyprint linenums">
@Mapper
public interface OrderMapper {

    @Mappings({
        @Mapping(source = "order.name", target = "name"),
        @Mapping(source = "houseNo", target = "houseNumber")
    })
    OrderDto orderAndAddressToOrderDto(Order order, Address deliveryAddress);
}
</pre>

As for single parameter methods all attributes are mapped by name from the source objects to the target object, performing a type conversion if required. In case a property with the same name exists in more than one source object, the source parameter from which to retrieve the property must be specified using the `@Mapping` annotation as shown for the `name` property.

One of the core principles in MapStruct is type-safety. Therefore an error will be raised at generation time when such an ambiguity is not resolved. Note that when mapping a property which only exists once in the source objects to another target property name, it is optional to specify the source parameter's name.

Also related to type-safety and correctness of generated mappings is the new option to raise an error in case an attribute of the mapping target is not populated, as this typically indicates an oversight or configuration error. By default a compiler warning is created in this case. To change this e.g. into a compile error instead, the `unmappedTargetPolicy` property can be used like this:

<pre class="prettyprint linenums">
@Mapper(unmappedTargetPolicy=ERROR)
public interface OrderMapper {
    
    //...
}
</pre>

In some cases it is required to update an existing object with the properties from a given source object instead of instantiating a new target object. This use case can be addressed with help of the `@MappingTarget` annotation which denotes one method parameter as the target of the mapping like this:

<pre class="prettyprint linenums">
@Mapper
public interface OrderMapper {

    void updateOrderEntityFromDto(OrderDto dto, @MappingTarget Order order);
}
</pre>

Instead of instantiating a new `Order` object, the generated implementation of `updateOrderEntityFromDto()` method will update the given order instance with the attributes from the passed `OrderDto`.

### More implicit type conversions

Several new implicit type conversions have been added for the case that the source and target type of a mapped property differ. `BigDecimal` and `BigInteger` can now automatically be converted into other numeric types as well as into `String`. You can finde a list of all supported conversions in the [reference documentation](http://localhost:4242/documentation/#section-05-01).

Please beware of a possible value or precision loss when performing such conversions from larger to smaller numeric types. It [is planned](https://github.com/mapstruct/mapstruct/issues/5) for the next milestone to optionally raise a warning in this case.

It is now also possible to convert `Date` into `String` and vice versa. For that purpose a new parameter has been added to the `@Mapping` annotation which allows to specify a format string as interpreted by `SimpleDateFormat`:

<pre class="prettyprint linenums">
@Mapper
public interface OrderMapper {

    @Mapping(source="orderDate", dateFormat="dd.MM.yyyy HH:mm:ss")
    OrderDto orderToOrderDto(Order order);
}
</pre>

### Integration with CDI and Spring

The recommended way for obtaining mapper instances in the 1.0.0.Alpha1 release was to use the `Mappers` factory.

Alternatively it is now also possible to work with dependency injection. To make this possible, MapStruct can generate mappers which are CDI or Spring beans, based on which flavor of DI you prefer. In the following example MapStruct is adviced to make the generated mapper implementation a CDI bean by specifying "cdi" via the `componentModel` attribute in the `@Mapper` annotation:

<pre class="prettyprint linenums">
@Mapper(componentModel="cdi")
public interface OrderMapper {

    //...
}
</pre>

This allows to obtain an order mapper simply via `@Inject` (provided you have CDI enabled within your application):

<pre class="prettyprint linenums">
@Inject
private OrderMapper orderMapper;
}
</pre>

Note that all other mappers a generated mapper class references are also obtained via the configured component model. So if you e.g. hook in hand-written mapper classes via `@Mapper#uses()` make sure that these mappers are compliant with the chosen component model, e.g. are CDI beans themselves. Refer to the documentation which [describes](/documentation/#section-04-02) all the specifics in detail.

On a related note, if you prefer to work with the `Mappers` factory as before, you'll have to adapt your imports because this class has been moved to the new package `org.mapstruct.factory`.

### Further info

This concludes our tour through the new features in MapStruct 1.0.0.Alpha2. You can find the complete list of addressed issues in the [change log](https://github.com/mapstruct/mapstruct/issues?milestone=2&state=closed) on GitHub. The [reference documentation](/documentation) has been updated to cover all new functionality.

If you have any kind of feedback please make sure to let us know. Either post a comment here or open a discussion in the [mapstruct-users](https://groups.google.com/forum/?fromgroups#!forum/mapstruct-users) group. Bugs and feature requests can be reported in the [issue tracker](https://github.com/mapstruct/mapstruct/issues) and your pull request on GitHub is highly welcome! The [contribution guide](/contributing) has all the info you need to get started with hacking on MapStruct.

Many thanks to [Andreas Gudian](https://github.com/agudian) and [Lukasz Kryger](https://github.com/kryger) who contributed to this release, that's awesome!
