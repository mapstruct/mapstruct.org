+++
date = "2016-12-31T13:23:04+01:00"
draft = false
title = "Frequently Asked Questions (FAQ)"
linkTitle = "FAQ"
weight = 500
[menu]
[menu.main]
+++

{{% faq_question "How is MapStruct different from other bean mapping tools?" %}}

Unlike most other bean mapping tools, MapStruct doesn't work at runtime but is a compile-time code generator.

Generating mapping code at build time has many advantages:

* Early feedback about erroneous or incomplete mappings, in command line builds as well as within your IDE
* Excellent performance, as no reflection or byte code generation at runtime is needed;
the generated code contains plain method invocations, just as if the mapper was hand-written
* No runtime dependencies, making MapStruct a great solution for Android applications
* The generated code is easy to understand (and debug, if ever needed)
* The optional [Eclipse plug-in]({{< ref "ide-support.md#eclipse" >}}) assists you when writing mappings, e.g. by auto-completion

{{% /faq_question %}}

{{% faq_question "Can I use MapStruct within Eclipse?" %}}
Yes.

Check out the [set-up instructions]({{< ref "ide-support.md#eclipse" >}}) for Eclipse.
There is also a work-in-progress [Eclipse plug-in](https://marketplace.eclipse.org/content/mapstruct-eclipse-plugin#group-metrics-tab)
which facilitates the definition of mapper interfaces with auto-completion and some quick fixes.
{{% /faq_question %}}

{{% faq_question "Can I use MapStruct together with Project Lombok?" %}}
Yes, as of MapStruct 1.2.0.Beta1 and Lombok 1.16.14.

[Project Lombok](https://projectlombok.org/) is an annotation processor that (amongst other things) adds getters and setters to the AST (abstract syntax tree) of compiled bean classes.
AST modifications are not foreseen by Java annotation processing API,
so quite some trickery was required within Lombok as well MapStruct to make both of them work together.
Essentially, MapStruct will wait until Lombok has done all its amendments before generating mapper classes for Lombok-enhanced beans.

An example for using the two projects together can be found [here](https://github.com/mapstruct/mapstruct-examples/tree/master/mapstruct-lombok).

If you are on an older version of MapStruct or Lombok,
the solution is to put the JavaBeans to be amended by Lombok and the mapper interfaces
to be processed by MapStruct into two separate modules of your project.
Then Lombok will run in the compilation of the first module,
causing the bean classes to be complete when MapStruct runs during the compilation of the second module.
{{% /faq_question %}}
