---
title: Asset Compute microservices extensibility for AEM as a Cloud Service
description: This tutorial walks through the creation of a simple Asset Compute worker that creates an asset rendition by cropping the original asset to a circle, and applies configurable contrast and brightness. While the worker itself is basic, this tutorial uses it to explore creating, developing, and deploying a custom Asset Compute worker for use with AEM as a Cloud Service.
feature: asset-compute
topics: renditions, development
version: cloud-service
doc-type: tutorial
activity: develop
audience: developer
kt: 5802
thumbnail: KT-5802.jpg
---

# Asset Compute microservices extensibility

AEM as Cloud Service's Asset Compute microservices support the development and deployment of custom workers that are used to read, and manipulate binary data of assets stored in AEM, most commonly, to create custom asset renditions.

Whereas in AEM 6.x custom AEM Workflow processes were used to read, transform, and write back asset renditions, in AEM as a Cloud Service Asset Compute workers satisfy this need.

## What you will do

>[!VIDEO](https://video.tv.adobe.com/v/40965?quality=12&learn=on)

This tutorial walks through the creation of a simple Asset Compute worker that creates an asset rendition by cropping the original asset to a circle, and applies configurable contrast and brightness. While the worker itself is basic, this tutorial uses it to explore creating, developing, and deploying a custom Asset Compute worker for use with AEM as a Cloud Service.

### Objectives {#objective}

1. Provision and set up the necessary accounts and services to build and deploy an Asset Compute worker
1. Create and configure an Asset Compute project
1. Develop am Asset Compute worker that generates a custom rendition 
1. Write tests for, and learn how to debug the custom Asset Compute worker
1. Deploy the Asset Compute worker, and integrate it AEM as a Cloud Service Author service via Processing Profiles

## Set up

 Learn how to properly prepare for extending Asset Compute workers, and understand what services and accounts must be provisioned and configured, and software installed locally for development.

### Account and service provisioning{#accounts-and-services}

The following accounts and services require provisioning and access to in order to complete the tutorial, AEM as a Cloud Service Dev environment or Sandbox program, access to Adobe Project Firefly and  Microsoft Azure Blob Storage.

+ [Provision accounts and services](./set-up/accounts-and-services.md)

### Local development environment

Local development of Asset Compute projects requires a specific developer tool set, different from traditional AEM development, including: Microsoft Visual Studio Code, Docker Desktop, Node.js and supporting npm modules.
 
+ [Set up local development environment](./set-up/development-environment.md)

### Adobe Project Firefly

Asset Compute projects are specially defined Adobe Project Firefly projects, and as such, require access to Adobe Project Firefly in the Adobe Developer Console in order to set up and deploy them.

+ [Set up Adobe Project Firefly](./set-up/firefly.md)

## Develop 

Learn how to create and configure an Asset Compute project and then develop a custom worker that generates a bespoke asset rendition.

### Create a new Asset Compute project

Asset Compute projects, which contain one or more Asset Compute workers, are generated using the the interactive Adobe I/O CLI. Asset Compute projects are specially structured Adobe Project Firefly projects, which are in turn Node.js projects. 

+ [Create a new Asset Compute project](./develop/project.md)

### Configure environment variables

Environment variables are maintained in the `.env` file for local development, and are used to provide Adobe I/O credentials and cloud storage credentials required for local development.

+ [Configure the environment variables](./develop/environment-variables.md)

### Configure the manifest.yml

Asset Compute projects contain manifests which define all the Asset Compute workers contained within the project, as well as what resources they have available when deployed to Adobe I/O Runtime for execution.

+ [Configure the manifest.yml](./develop/manifest.md)

### Develop a worker

Developing an Asset Compute worker is the core of extending Asset Compute microservices, as the worker contains the custom code that generates, or orchestrates, the generation of the resultant asset rendition.

+ [Develop an Asset Compute worker](./develop/worker.md)

### Use the Asset Compute Development Tool

The Asset Compute Development Tool provides a local Web harness for deploying, executing and previewing worker-generated renditions, supporting rapid and iterative Asset Compute worker development.

+ [Use the Asset Compute Development Tool](./develop/development-tool.md)

## Test and Debug

Learn how to test custom Asset Compute workers to be confident in their operation, and debug Asset Compute workers to understand and troubleshoot how the custom code is executed.

### Test a worker

Asset Compute provides a test framework for creating test suites for workers, making defining tests that ensure proper behavior is easy.

+ [Test a worker](./test-debug/test.md)

### Debug a worker

Asset Compute workers provide various levels of debugging from traditional `console.log(..)` output, to integrations with __VS Code__ and  __wskdebug__, allowing developers step through worker code as it executes in real time.

+ [Debug a worker](./test-debug/debug.md)

## Deploy

Learn how to integrate custom Asset Compute workers with AEM as a Cloud Service, by first deploying them to Adobe I/O Runtime and then invoking from AEM as a Cloud Service Author via AEM Assets' Processing Profiles.

### Deploy to Adobe I/O Runtime

Asset Compute workers must be deployed to Adobe I/O Runtime to be used with AEM as a Cloud Service.

+ [Using Processing Profiles](./deploy/runtime.md)

### Integrate workers via AEM Processing Profiles

Once deployed to Adobe I/O Runtime, Asset Compute workers can be registered in AEM as a Cloud Service via [Assets Processing Profiles](../../assets/configuring/processing-profiles.md). Processing Profiles are, in turn, applied to asset folders applying to the assets therein.

+ [Integrate with AEM Processing Profiles](./deploy/processing-profiles.md)

## Advanced

These abridged tutorials tackle more advanced use cases building upon foundational learnings established in the prior chapters.

+ [Develop a Asset Compute metadata worker](./advanced/metadata.md) that can write metadata back to the 

## Codebase on Github

The tutorial's codebase is available on Github at:

+ [adobe/aem-guides-wknd-asset-compute](https://github.com/adobe/aem-guides-wknd-asset-compute) @ master branch

The source code does not contain the required `.env` or `config.json` files. These must be added and configured using your [accounts and services](#accounts-and-services) information.

## Additional resources

The following are various Adobe resources that provide further information and useful APIs and SDKs for developing Asset Compute workers.

### Documentation

+ [Asset Compute Service documentation](https://docs.adobe.com/content/help/en/asset-compute/using/extend/understand-extensibility.html)
+ [Asset Compute Development Tool readme](https://github.com/adobe/asset-compute-devtool)
+ [Asset Compute example workers](https://github.com/adobe/asset-compute-example-workers)

### APIs and SDKs

+ [Asset Compute SDK](https://github.com/adobe/asset-compute-sdk)
    + [Asset Compute Commons](https://github.com/adobe/asset-compute-commons)
    + [Asset Compute XMP](https://github.com/adobe/asset-compute-xmp#readme)
+ [Adobe Cloud Blobstore Wrapper library](https://github.com/adobe/node-cloud-blobstore-wrapper)
+ [Adobe Node Fetch Retry library](https://github.com/adobe/node-fetch-retry)
+ [Asset Compute example workers](https://github.com/adobe/asset-compute-example-workers)
