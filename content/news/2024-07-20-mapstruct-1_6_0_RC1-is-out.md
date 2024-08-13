---
title: "MapStruct 1.6.0.RC1 is out"
author: Filip Hrisafov
date: "2024-07-20"
tags: [release, news]
---

I am very happy to announce the first (and last) release candidate of MapStruct 1.6.
We are looking into release the final version of 1.6 in the next two weeks.

This release provides mostly bug fixes since [1.6.0.Beta2](https://mapstruct.org/news/2024-04-20-mapstruct-1_6_0_Beta2-is-out/).

This release contains 2 breaking changes, have a look at them when upgrading

<!--more-->

We'd like to thank our new supporters:

* [Lee Anne](https://github.com/AnneMayor)

And of course thanks to our previous supporters:

* [adesso SE](https://github.com/adessoSE)
* [Bileto](https://opencollective.com/bileto)
* [Cybozu](https://github.com/cybozu)
* [Frederik Hahne](https://opencollective.com/atomfrede)
* [Juyoung Kim](https://github.com/kjuyoung)
* [Lansana](https://opencollective.com/lansana)
* [Mariselvam](https://github.com/marisnb)
* [PRISMA European Capacity Platform GmbH](https://github.com/jan-prisma)
* [St. Galler Kantonalbank AG](https://opencollective.com/st-galler-kantonalbank-ag)

If you'd like to join this list and donate to the project MapStruct is accepting donations through [Open Collective](https://opencollective.com/mapstruct) or [GitHub](https://github.com/sponsors/mapstruct).

Altogether, not less than [8 issues](https://github.com/mapstruct/mapstruct/issues?q=milestone%3A1.6.0.RC1) were fixed for this release.

This would not have been possible without our fantastic community of contributors:

* [@cmcgowanprovidertrust](https://github.com/cmcgowanprovidertrust)
* [@hduelme](https://github.com/hduelme)
* [@Hypnagokali](https://github.com/Hypnagokali)
* [@Obolrom](https://github.com/Obolrom)

* and of course seasoned MapStruct hackers [Ben Zegveld](https://github.com/Zegveld), [Oliver Erhart](https://github.com/thunderhook), [Sjaak Derksen](https://github.com/sjaakd), [Filip Hrisafov](https://github.com/filiphr).

Thank you everyone for all your hard work!

Enough of the pep talk, let's take a closer look at the breaking changes:

### Revert `BeanMapping#ignoreByDefault` interaction with `unmappedSourcePolicy`

In 1.5.0 we started applying the `BeanMapping#ignoreByDefault` to source properties as well.
However, we've decided that this was not the right approach, and we are reverting this change.
The `BeanMapping#ignoreByDefault` should only be applied to target properties and not to source properties.
Source properties are ignored anyway, the `BeanMapping#unmappedSourcePolicy` should be used to control what should happen with unmapped source policy.

### Presence checks for source parameters

In the 1.6 beta releases we added support for [presence checks on source parameters](2024-05-11-mapstruct-1_6_0_Beta2-is-out.md#conditional-mapping-for-source-parameters).

This means that even if you want to map a source parameter directly to some target property the new `@SourceParameterCondition` or `@Condition(appliesTo = ConditionStrategy.SOURCE_PARAMETERS)` should be used.

e.g.

If we had the following in 1.5:
{{< prettify java >}}
@Mapper
public interface OrderMapper {

    @Mapping(source = "dto", target = "customer", conditionQualifiedByName = "mapCustomerFromOrder")
    Order map(OrderDTO dto);

    @Condition
    @Named("mapCustomerFromOrder")
    default boolean mapCustomerFromOrder(OrderDTO dto) {
        return dto != null && dto.getCustomerName() != null;
    }

}
{{< /prettify >}}

Then MapStruct would generate

{{< prettify java >}}
public class OrderMapperImpl implements OrderMapper {

    @Override
    public Order map(OrderDTO dto) {
        if ( dto == null ) {
            return null;
        }

        Order order = new Order();

        if ( mapCustomerFromOrder( dto ) ) {
            order.setCustomer( orderDtoToCustomer( orderDTO ) );
        }

        return order;
    }
}
{{< /prettify >}}

In order for the same to be generated in 1.6, the mapper needs to look like this:

{{< prettify java >}}
@Mapper
public interface OrderMapper {

    @Mapping(source = "dto", target = "customer", conditionQualifiedByName = "mapCustomerFromOrder")
    Order map(OrderDTO dto);

    @SourceParameterCondition
    @Named("mapCustomerFromOrder")
    default boolean mapCustomerFromOrder(OrderDTO dto) {
        return dto != null && dto.getCustomerName() != null;
    }

}
{{< /prettify >}}

### Download

This concludes our tour through MapStruct 1.6 RC1.
If you'd like to try out the features described above, you can fetch the new release from Maven Central using the following GAV coordinates:

* Annotation JAR: [org.mapstruct:mapstruct:1.6.0.RC1](http://search.maven.org/#artifactdetails|org.mapstruct|mapstruct|1.6.0.RC1|jar) 
* Annotation processor JAR: [org.mapstruct:mapstruct-processor:1.6.0.RC1](http://search.maven.org/#artifactdetails|org.mapstruct|mapstruct-processor|1.6.0.Beta2|jar)

Alternatively, you can get ZIP and TAR.GZ distribution bundles - containing all the JARs, documentation etc. - [from GitHub](https://github.com/mapstruct/mapstruct/releases/tag/1.6.0.RC1).

If you run into any trouble or would like to report a bug, feature request or similar, use the following channels to get in touch:

* Get help in [GitHub Discussions](https://github.com/mapstruct/mapstruct/discussions) or [StackOverflow](https://stackoverflow.com/questions/tagged/mapstruct)
* Report bugs and feature requests via the [issue tracker](https://github.com/mapstruct/mapstruct/issues)
* Follow [@GetMapStruct](https://twitter.com/GetMapStruct) on Twitter
