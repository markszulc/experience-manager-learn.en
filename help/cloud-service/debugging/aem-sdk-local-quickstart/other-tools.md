---
title: Other tools for debugging AEM SDK’s local quickstart
description: A variety of other tools can aid in debugging the AEM SDK's local quickstart.
feature: 
topics: development
version: cloud-service
doc-type: tutorial
activity: develop
audience: developer
kt: 5251
---
  
# Other tools for debugging AEM SDK’s local quickstart

A variety of other tools can aid in debugging your application on the AEM SDK's local quickstart. 

## CRXDE Lite

![CRXDE Lite](./assets/other-tools/crxde-lite.png)

CRXDE Lite is a web-based interface for interacting with the JCR, AEM's data repository. CRXDE Lite provides completely visibility into the JCR, including nodes, properties, property values, and permissions.

CRXDE Lite is located at:

+ Tools > General > CRXDE Lite
+ or directly at [http://localhost:4502/crx/de/index.jsp](http://localhost:4502/crx/de/index.jsp)

## Explain Query

![Explain Query](./assets/other-tools/explain-query.png)

Explain Query web-based tool in AEM SDK's local quickstart, that provides key insights into how AEM interprets and executes queries, and an invaluable tool to ensure queries are being executed in a performant manner by AEM.

Explain Query is located at:

+ Tools > Diagnosis > Query Performance > Explain Query Tab
+ [http://localhost:4502/libs/granite/operations/content/diagnosistools/queryPerformance.html](http://localhost:4502/libs/granite/operations/content/diagnosistools/queryPerformance.html) > Explain Query tab

## QueryBuilder Debugger 

![QueryBuilder Debugger](./assets/other-tools/query-debugger.png)

QueryBuilder debugger is web-based tool that helps you debug and understand search queries using AEM's [QueryBuilder](https://docs.adobe.com/content/help/en/experience-manager-65/developing/platform/query-builder/querybuilder-api.html) syntax.

QueryBuilder Debugger is located at:

+ [http://localhost:4502/libs/cq/search/content/querydebug.html](http://localhost:4502/libs/cq/search/content/querydebug.html)

## Sling Log Tracer and AEM Chrome plug-in

![Sling Log Tracer and AEM Chrome plug-in](./assets/other-tools/log-tracer.png)

[Sling Log Tracer](https://sling.apache.org/documentation/bundles/log-tracers.html), which ships with AEM SDK's local quickstart, allows for in-depth tracing of HTTP Requests, exposing in depth debugging information per request. The [Log Tracer OSGi configuration must be configured](https://sling.apache.org/documentation/bundles/log-tracers.html#configuration-1) to enable this feature.

The open source [AEM Chrome plug-in](https://chrome.google.com/webstore/detail/aem-chrome-plug-in/ejdcnikffjleeffpigekhccpepplaode?hl=en-US) for the [Google Chrome web browser](https://www.google.com/chrome/), integrates with Log Tracer, exposing the debug information directly in Chrome's Dev Tools.

_The AEM Chrome plug-in is an open source tool, and Adobe does not provide support for it._

