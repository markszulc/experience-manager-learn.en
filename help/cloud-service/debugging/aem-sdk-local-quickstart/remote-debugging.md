---
title: Remote debugging the AEM SDK
description: The AEM SDK’s local quickstart allows remote Java debugging from your IDE, allowing you to step through live code execution in AEM  to understand the exact execution flow.
feature: 
topics: development
version: cloud-service
doc-type: tutorial
activity: develop
audience: developer
kt: 5251
---
 
# Remote debugging the AEM SDK

>[!VIDEO](https://video.tv.adobe.com/v/34338/?quality=12&learn=on)

The AEM SDK’s local quickstart allows remote Java debugging from your IDE, allowing you to step through live code execution in AEM  to understand the exact execution flow.

To connect a remote debugger to AEM, the AEM SDK’s local quickstart must be started with specific parameters (`-agentlib:...`) allowing the IDE to connect to it.

```
$ java -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5005 -jar aem-author-p4502.jar   
```

+ `address` specifies the port AEM listens on for remote debug connections and can be changed to any available port on the local development machine.
+ The last parameter (eg. `aem-author-p4502.jar`) is the AEM SKD Quickstart Jar. This can be either the AEM Author service (`aem-author-p4502.jar`) or the AEM Publish service (`aem-publish-p4503.jar`).

## IDE set up instructions

Most Java IDE's provide support for remote debugging of Java programs, however each IDE's exact set up steps vary. Please review your IDE's remote debugging set up instructions for the exact steps. Typically IDE configurations require:

+ The host AEM SDK's local quickstart is listening on, which is `localhost`.
+ The port AEM SDK's local quickstart is listening on for remote debug connection, which is the port specified by the `address` parameter when starting AEM SDK's local quickstart.
+ Occasionally, the Maven project(s) that provide the source code to remote debug must be specified; this is your OSGi bundle maven projects project(s).

### Set up instructions

+ [VS Code Java Remote debugger set up](https://code.visualstudio.com/docs/java/java-debugging)
+ [IntelliJ IDEA Remote debugger set up](https://www.jetbrains.com/help/idea/run-debug-configuration-remote-debug.html)
+ [Eclipse Remote debugger set up](https://javapapers.com/core-java/java-remote-debug-with-eclipse/)
