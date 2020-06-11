---
title: Debugging AEM SDK using logs
description: Logs act as the frontline for debugging AEM applications, but are dependent on adequate logging in the deployed AEM application.
feature: 
topics: development
version: cloud-service
doc-type: tutorial
activity: develop
audience: developer
kt: 5252
---

# Debugging AEM SDK using logs 

>[!VIDEO](https://video.tv.adobe.com/v/34334/?quality=12&learn=on)

Logs act as the frontline for debugging AEM applications, but are dependent on adequate logging in the deployed AEM application. Adobe recommends keeping local development and AEM as a Cloud Service Dev logging configurations as similar a possible, as it normalizes log visibility on the AEM SDK’s local quickstart and AEM as a Cloud Service's Dev environments, reducing configuration twiddling and re-deployment.

The [AEM Project Archetype](https://github.com/adobe/aem-project-archetype) configures logging at the DEBUG level for your AEM application's Java packages for local development via the Sling Logger OSGi configuration found at

 `ui.apps/src/main/content/jcr_root/apps/example/config/org.apache.sling.commons.log.LogManager.factory.config-example.cfg.json`
 
 which logs to the `error.log`.

If default logging is insufficient for local development, ad hoc logging can be configured via AEM SDK’s local quickstart's Log Support web console, at ([/system/console/slinglog](http://localhost:4502/system/console/slinglog)), however it's not recommended ad hoc changes are persisted to Git unless these same log configurations are needed on AEM as a Cloud Service Dev environments as well. Keep in mind, changes via the Log Support console, are persisted directly to the  AEM SDK’s local quickstart's repository.

Java log statements can be view in the `error.log` file:

```
$ ~/aem-sdk/author/crx-quickstart/logs/error.log
```

Often it it useful to "tail" the `error.log` which streams its output to the terminal.

+ macOS/Linux
    + `$ tail -f ~/aem-sdk/author/crx-quickstart/logs/error.log`
+ Windows requires [3rd party tail applications](https://stackoverflow.com/questions/187587/a-windows-equivalent-of-the-unix-tail-command) or the use of [Powershell's Get-Content command](https://stackoverflow.com/a/46444596/133936).




