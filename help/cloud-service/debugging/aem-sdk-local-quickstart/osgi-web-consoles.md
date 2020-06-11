---
title: Debugging AEM SDK using the OSGi web console
description: The AEM SDK’s local quickstart has an OSGi web console that provides a variety of information and introspections into the local AEM runtime that are useful to understand how your application is recognized by, and functions within AEM.
feature: 
topics: development
version: cloud-service
doc-type: tutorial
activity: develop
audience: developer
kt: 5265, 5366, 5267
---

# Debugging AEM SDK using the OSGi web console

The AEM SDK’s local quickstart has an OSGi web console that provides a variety of information and introspections into the local AEM runtime that are useful to understand how your application is recognized by, and functions within AEM.

AEM provides many OSGi consoles, each providing key insights into different aspects of AEM, however the following are typically the most useful in debugging your application.

## Bundles

>[!VIDEO](https://video.tv.adobe.com/v/34335/?quality=12&learn=on)

The Bundles console is a catalog of the OSGi bundles, and their details, deployed to AEM, along with the ad hoc ability to start and stop them.

The Bundles console is located at:

+ Tools > Operations > Web Console > OSGi > Bundles
+ Or directly at: [http://localhost:4502/system/console/bundles](http://localhost:4502/system/console/bundles)

Clicking into each bundle, provides details that help with the debugging your application.

+ Validating the OSGi bundle is present
+ Validating if an OSGi bundle is active
+ Determining if an OSGi bundle has unsatisfied imports preventing it from starting

## Components

>[!VIDEO](https://video.tv.adobe.com/v/34336/?quality=12&learn=on)

The Components console is a catalog of all the OSGi components deployed to AEM, and provides a all information about them, from their defined OSGi component life cycle, to what OSGi services they may reference to 

The Components console is located at:

+ Tools > Operations > Web Console > OSGi > Components
+ Or directly at: [http://localhost:4502/system/console/components](http://localhost:4502/system/console/components)

Key aspects that help with the debugging activities:

+ Validating the OSGi bundle is present
+ Validating if an OSGi bundle is active
+ Determining if an OSGi bundle has unsatisfied imports preventing it from starting
+ Obtaining the component's PID, in order create OSGi configurations for them in Git
+ Identifying OSGi property values bound to the active OSGi configuration

## Sling Models

>[!VIDEO](https://video.tv.adobe.com/v/34337/?quality=12&learn=on)

The Sling Models console is located at:

+ Tools > Operations > Web Console > Status > Sling Models
+ Or directly at: [http://localhost:4502/system/console/status-slingmodels](http://localhost:4502/system/console/status-slingmodels )

Key aspects that help with the debugging activities:

+ Validating Sling Models are registered to the proper resource type
+ Validating Sling Models are adaptable from the correct objects (Resource or SlingHttpRequestServlet)
+ Validating Sling Model Exporters are properly registered
