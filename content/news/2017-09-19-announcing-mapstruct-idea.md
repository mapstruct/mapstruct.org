---
title: "MapStruct support for IntelliJ IDEA"
author: Filip Hrisafov
date: "2017-09-19"
tags: [release, news, intellij, ide]
---

I am very happy to announce the first version of the MapStruct IntelliJ IDEA plugin.
Now we have official support for 2 IDEs, Eclipse being the first IDE for which we had support from earlier (plugin [here](https://marketplace.eclipse.org/content/mapstruct-eclipse-plugin)).

With the power of IntelliJ you now get completions in `@Mapping` and `@ValueMapping` annotations (also for nested mappings ;)).
Apart from that you also get support for: finding usages of methods directly within annotations, 
going to declarations from annotations, highlighting support within annotations and refactoring support.

<!--more-->

Changing a property and it's getters / setters now leads to change of the source / target values accordingly.

With this plugin we are bringing first class support for MapStruct within IntelliJ and addressing long lasting requests
from users for the support (such as [mapstruct#520](https://github.com/mapstruct/mapstruct/issues/520) and [IDEABKL-7174](https://youtrack.jetbrains.com/issue/IDEABKL-7174)).

Some of the new features:

#### Completion for Properties and Enum Constants

<div style="text-align:left">
    <img src="/images/idea/source-auto-complete.gif" alt="Code completion for source"/>
</div>

#### Go To Declaration from annotation

<div style="text-align:center">
    <img src="/images/idea/go-to-declaration-from-target.gif" alt="Go To Declaration"/>
</div>

#### Find Usages

<div style="text-align:center">
    <img src="/images/idea/find-usages-from-source-method.png" alt="Find usages from Source methods"/>
</div>

I would also like to thank everyone in the [Plugin Developers gitter chat](https://gitter.im/IntelliJ-Plugin-Developers/Lobby) 
and the people from Jetbrains for their help and guidance in developing this plugin :).

### Download

You can find the plugin in the Jetbrains Plugins repository [here](https://plugins.jetbrains.com/plugin/10036-mapstruct-support).

Alternatively, you can get ZIP [from GitHub](https://github.com/mapstruct/mapstruct-idea/releases/tag/1.0.0).

### Next steps

We would like to add support for Inspections and Quick Fixes for recommended usages of MapStruct.

Please try out the plugin and let us know what you think and what you would like to see in it.
To get in touch, post a comment below or use one the following channels:

* Get help at the [mapstruct-users](https://groups.google.com/forum/?fromgroups#!forum/mapstruct-users) group or in our [Gitter room](https://gitter.im/mapstruct/mapstruct-users)
* Report bugs and feature requests via the [issue tracker](https://github.com/mapstruct/mapstruct-idea/issues)
* Follow [@GetMapStruct](https://twitter.com/GetMapStruct) on Twitter
* Follow MapStruct on [Google+](https://plus.google.com/u/0/118070742567787866481/posts)
* Talk with us in our [gitter room](https://gitter.im/mapstruct/mapstruct-users)
