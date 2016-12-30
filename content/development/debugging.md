+++
date = "2016-02-14T16:11:58+05:30"
draft = true
title = "Debugging"
weight = 500
teaser = "Debugging the annotation processor"
[menu]
[menu.main]
parent = "Development"
+++

The most straight-forward way to debug the MapStruct annotation processor is to use your IDE and debug one of the JUnit tests in the processor module. The processor is then executed with the same JDK that you use the run the tests with.

But there are subtle differences in the way different compilers implement the annotation processor API, so you might come to a point where you need to debug a specific problem with a certain compiler. The MapStruct integration tests run different smaller Maven projects with different compilers, by using compiler implementations pulled in as dependencies to the maven-compiler-plugin, and by [Maven Toolchains](http://maven.apache.org/guides/mini/guide-using-toolchains.html) (see [etc/toolchains-example.xml](https://github.com/mapstruct/mapstruct/blob/master/etc/toolchains-example.xml) for a template to modify and put into your local ```~/.m2``` directory).

To debug an integration test, pass ```-DprocessorIntegrationTest.debug=true``` to the test process. A test case that uses Maven Toolchains (currently ```oracle_java_6``` and ```oracle_java_7```) will wait for a remote debugger to attach on port ```8000```. The other tests will launch ```mvnDebug``` internally, which by default also lets the Maven process wait on port ```8000``` for a remote debugger.

If you like to launch the test with maven, use a command such as the following to focus on a single test case:

{{< prettify bash>}}mvn test -Dtest=<TestClass>#<TestCase> -DprocessorIntegrationTest.debug=true

mvn test -Dtest=SimpleTest#oracle_java_6 -DprocessorIntegrationTest.debug=true
{{< /prettify >}}
