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

AEM as a Cloud Service is the cloud-native way of leveraging the AEM applications. AEM as a Cloud Service runs on self-service, scalable, cloud infrastructure, which requires AEM developers to understand how to understand and debug various facets of AEM as a Cloud Service, from build and deploy to obtaining details of running AEM applications.

## Logs

Logs provide details into how your application is functioning in AEM as a Cloud Service, as well as insights into issues with deployments.

[Debugging AEM as a Cloud Service using logs](./logs.md)

## Build and deployment

Adobe Cloud Manager pipelines deploys AEM application through a series of steps to determine code quality and viability when deployed to AEM as a Cloud Service. Each of the steps may result in failure, making it important to understand how to debug builds in order to determine the root cause of, and how to resolve any failures.

[Debugging AEM as a Cloud Service build and deployment](./build-and-deployment.md)

## Developer Console

The Developer console provides a variety of information and introspections into AEM as a Cloud Service environments that are useful to understand how your application is recognized by and functions within AEM as a Cloud Service.

[Debugging AEM as a Cloud Service with the Developer Console](./developer-console.md)   

## CRXDE Lite

CRXDE Lite is a classic, yet powerful tool for debugging AEM as a Cloud Service Developer environments. CRXDE Lite provides a suite of functionality that aids debugging from inspecting all resources and properties, manipulating the mutable portions of the JCR, investigating permissions and evaluating queries. 

[Debugging AEM as a Cloud Service with CRXDE Lite](./crxde-lite.md)
