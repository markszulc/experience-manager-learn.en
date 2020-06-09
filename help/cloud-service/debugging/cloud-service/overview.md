---
title: Debugging AEM as a Cloud Service
description: on self-service, scalable, cloud infrastructure, which makes requires AEM developers to understand how to understand and debug various facets of AEM as a Cloud Service, from build and deploy to obtaining details of running AEM applications.
feature: 
topics: development
version: cloud-service
doc-type: tutorial
activity: develop
audience: developer
kt: 5346
---

# Debugging AEM as a Cloud Service

AEM as a Cloud Service is the cloud-native way of leveraging the AEM applications. AEM as a Cloud Service runs on self-service, scalable, cloud infrastructure, which makes requires AEM developers to understand how to understand and debug various facets of AEM as a Cloud Service, from build and deploy to obtaining details of running AEM applications.

## Logs

Logs provide details into how your application is functioning in AEM as a Cloud Service, as well as insights into issues with deployments.

[Debugging using logs](./logs.md)

## Developer Console

The Developer console provides a variety of information and introspections into the AEM as a Cloud Service environments that are useful to understand how your application is recognized by, and functions within AEM.

[Debugging with the Developer Console](./developer-console.md)

## Build and deployments

Cloud Manager pipeline deploys AEM application through a series of steps to ensure it is of the highest quality and will operate as expected when deployed to AEM as a Cloud Service. Each of these steps may result in failure, an it is important to understand how to debug the builds in order to understand the root cause as well as how to resolve any failures.

[Debugging builds](./build-and-deployment.md)
