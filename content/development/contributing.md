+++
date = "2016-12-31T13:23:24+01:00"
draft = false
title = "Contributing"
weight = 100
teaser = "How to contribute to the MapStruct project"
[menu]
[menu.main]
parent = "Development"
+++

You love MapStruct but miss a certain feature? You found a bug and want to report it, or even better, fix it yourself? That's great! MapStruct is all open source and your help is highly appreciated.

<table class="uk-table">
<thead>
  <tr>
    <th>What</th><th>Where</th>
  </tr>
</thead>
<tbody>
  <tr>
    <td width="20%">Source code</td><td><a href="https://github.com/mapstruct/mapstruct">https://github.com/mapstruct/mapstruct</a></td>
  </tr>
  <tr>
    <td width="20%">Issue tracker</td><td><a href="https://github.com/mapstruct/mapstruct/issues">https://github.com/mapstruct/mapstruct/issues</a></td>
  </tr>
  <tr>
    <td width="20%">Discussions</td><td>Join the <a href="https://groups.google.com/forum/?fromgroups#!forum/mapstruct-users">mapstruct-users</a> Google group</td>
  </tr>
  <tr>
    <td width="20%">CI build</td><td><a href="https://mapstruct.ci.cloudbees.com">https://mapstruct.ci.cloudbees.com</a></td>
  </tr>
  <tr>
    <td width="20%">This web site</td><td><a href="https://github.com/mapstruct/mapstruct.org">https://github.com/mapstruct/mapstruct.org</a></td>
  </tr>
</tbody>
</table>

MapStruct follows the _Fork & Pull_ development approach. To get started just fork the [MapStruct repository](http://github.com/mapstruct/mapstruct) to your GitHub account and create a new topic branch for each change. Once you are done with your change, submit a [pull request](https://help.github.com/articles/using-pull-requests) against the MapStruct repo.

When doing changes, keep the following best practices in mind:

* Provide test cases
* Update the [reference documentation](mapstruct.org/documentation) on [mapstruct.org](mapstruct.org) where required
* Discuss new features you'd like to implement at the [Google group](https://groups.google.com/forum/?fromgroups#!forum/mapstruct-users) before getting started
* Create one pull request per feature
* Provide a meaningful history, e.g. squash intermediary commits before submitting a pull request
* Start your commit messages with "#&lt;issue no&gt;", e.g. "#123 Adding new mapping feature"
* Have git automatically manage line endings as described [here](https://help.github.com/articles/dealing-with-line-endings)
* Format your sources using the provided IntelliJ [code style template](https://github.com/mapstruct/mapstruct/blob/master/etc/mapstruct.xml). Eclipse users can import the [Eclipse code formatter settings](https://github.com/mapstruct/mapstruct/blob/master/etc/eclipse-formatter-config.xml) - it's close enough, but configure the Save Actions to only format edited lines. If you use another IDE stick to the used style as much as possible.
