+++
date = "2016-12-31T13:23:50+01:00"
draft = false
title = "Technical Documentation"
weight = 300
teaser = "Useful information on the inner workings of MapStruct"
[menu]
[menu.main]
parent = "Development"
+++

The MapStruct code base is thoroughly documented via JavaDoc. You can find the latest docs [here](https://mapstruct.org/documentation/stable/api/). The individual pages contain generated class diagrams showing type hierarchies and package contents.

To get yourself acquainted with the code base, you could start by taking a look at the docs of the [MappingProcessor](https://mapstruct.org/documentation/stable/api/org/mapstruct/ap/MappingProcessor.html) which give a high-level overview of the general architecture. Then check out the [org.mapstruct.ap.internal.model](https://mapstruct.org/documentation/stable/api/org/mapstruct/ap/internal/model/package-summary.html) and [org.mapstruct.ap.internal.processor](https://mapstruct.org/documentation/stable/api/org/mapstruct/ap/internal/processor/package-summary.html) packages.

If you have any questions don't hesitate to ask in our [GitHub Discussions](https://github.com/mapstruct/mapstruct/discussions) or [StackOverflow](https://stackoverflow.com/questions/tagged/mapstruct), we are here to help!
