+++
date = "2017-01-04T21:20:00+01:00"
title = "IDE Support"
weight = 300
teaser = "Fully leverage the fast feedback of MapStruct in your IDE"
[menu]
[menu.main]
parent = "Documentation"
+++

One of the big advantages of MapStruct is the early feedback on problems with the mapping configuration. To fully leverage this in your IDE, make sure the annotation processor runs with each compilation.

## Eclipse

### Maven Integration

If your work with a Maven project, then make sure you have the latest version of the [m2e-apt](https://marketplace.eclipse.org/content/m2e-apt) plugin installed, which picks up and applies the annotation processor settings automatically.

For best results, add the following to the `pom.xml`:

```xml
<properties>
  <!-- automatically run annotation processors within the incremental compilation -->
  <m2e.apt.activation>jdt_apt</m2e.apt.activation>
</properties>
```

### Editing Support

For Eclipse, we are also working on a Plugin that adds *Code Completion* (e.g. for property names) and *Quick Fixes* for common use cases:

#### Completion for Properties and Enum Constants

<div style="text-align:center">
    <img src="/images/eclipse/still-completion-1.png" alt="Code completion for properties and enum constants" style="padding-bottom: 3px;"/>
</div>

#### Quick Fix to Ignore an Unmapped Property

<div style="text-align:center">
    <img src="/images/eclipse/still-quickfix-1.png" alt="Quick Fix to ignore an unmapped property" style="padding-bottom: 3px;"/>
</div>

#### Installation

Drag into your running Eclipse workspace: 
<a href="http://marketplace.eclipse.org/marketplace-client-intro?mpc_install=2844337" class="drag" title="Drag to your running Eclipse workspace."><img class="img-responsive" src="https://marketplace.eclipse.org/sites/all/themes/solstice/public/images/marketplace/btn-install.png" alt="Drag to your running Eclipse workspace." /></a> - or search for the MapStruct Eclipse Plugin within the Eclipse Marketplace client.

For more information and for installing the latest Snapshot version, visit the [plugins GitHub project](https://github.com/mapstruct/mapstruct-eclipse).

## IntelliJ IDEA

Depending on how you configured the annotation processor in your Maven or Gradle project, IntelliJ may or may not pick it up automatically. You might need to make sure of it yourself in the project configuration. 

### Maven Integration

For example, if you use the way of Maven configuration that is proposed in our documentation using `annotationProcessorPaths` in the maven-compiler-plugin, then you need to configure IntelliJ manually until the feature request [IDEA-150621](https://youtrack.jetbrains.com/issue/IDEA-150621) is implemented. An alternative is to add the `mapstruct-processor` as a project dependency with `<optional>true</optional>` in your `pom.xml`, which should then be picked up automatically again. 

### Editing Support

As for the editing support of MapStruct mappers, there is an open feature request in the IntelliJ backlog: [MapStruct support](https://youtrack.jetbrains.com/issue/IDEABKL-7174). Perhaps some additional votes help there. Or better yet, if you want to start with it, we'd probably join you in your efforts.

## NetBeans

### Maven Integration

If you use a Maven project, then there's nothing more to do. NetBeans uses Maven to compile your sources, which includes the invocation of the annotation processor.

### Editing Support

There are no plans of special editing support for MapStruct mappers in NetBeans that we know of, yet. But we'd love to see one!