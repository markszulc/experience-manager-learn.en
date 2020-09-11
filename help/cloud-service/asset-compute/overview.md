---
title: Developing for AEM as a Cloud Service Asset Compute microservices 
description: 
feature: 
topics: 
version: cloud-service
doc-type: tutorial
activity: git cl
audience: developer
kt: 5802
thumbnail: KT-5802.jpg
---

# Developing for Asset Compute microservices

AEM as Cloud Service's Asset Compute microservices support the development and deployment of custom workers that can be used to read, and manipulate binary data of assets stored in AEM. 

In this tutorial we'll create a simple Asset Compute worker that crops an image to a cirlce, and applied contrast and brightness, and use the process to explore the facets of Asset Compute worker set up, development and deployment.

![Asset Compute tutorial example](./assets/overview/before-and-after.png)

## Set up

In order to begin developing custom Asset Compute applications, accounts and services must be provisioend and configured, and software installed on the local development machines.

### Account and service provisioning 

The following accounts and services require provisioning and access to in order to complete the tutorial, AEM as a Cloud Service Dev environment or Sandbox program, access to Adobe Project Firefly and  Microsoft Azure Blob Storage.

+ [Provision accounts and services](./set-up/accounts-and-services.md)

### Local development environment

Local development of Asset Compute applications requires a discrete developer tool box for traditional AEM development, including, Microsoft Visual Studio Code, Docker Desktop, Node.js and supporting npm modules.
 
+ [Set up local development environment](./set-up/development-environment.md)

### Adobe I/O Project Firefly project

Asset Compute applications are specially defined Adobe Project Firefly applications, and as such, require access to Adobe Project Firefly in the Adobe Developer Console in order to set up and deploy them.

+ [Set up the Adobe Project Firefly project](./set-up/firefly.md)

## Develop 

### Create a new Asset Compute project

Asset Compute application projects, which contain one or more Asset Compute workers, are generated using the the inteactive Adobe I/O CLI. Asset Compute applications are specially structured Adobe Project Firefly applications, which are in turn Node.js applications. 

+ [Create a new Asset Compute project](./develop/project.md)

### Configure environment variables

Environment variables are maintained in the `.env` file for local development, and are used to provide Adobe I/O credentials and cloud storage credentials required for local development.

+ [Configure the Asset Compute project's environment variables](./develop/environment-variables.md)

### Configure the manifest.yml

Asset Compute applications contain manifests which define all the Asset Compute workers contained within the project, as well as what resources they have available when deployed to Adobe I/O Runtime for execution.

+ [Configure the Asset Compute project's manifest.yml](./develop/manifest.md)

### Develop a worker

Developing an Asset Compute worker is the core of extending Asset Compute microservices, as the worker contains the custom code that generates, or orchcestrates the generation of, the asset rendition.

+ [Develop an Asset Compute worker](./develop/worker.md)

### Use the Asset Compute Dev Tool

The Asset Compute Dev Tool provides a local Web harness for deploying, executing and previewing worker-generated renditions, supporting rapid and iterative Asset Compute worker development.

+ [Use the Asset Compute Dev Tool](./develop/dev-tool.md)

## Test and Debug

Testing and debugging Asset Compute applications and workers is crucial in ensuring workers are functioning properly.  

### Test a worker

Asset Compute provides a test framework for creating test suites for workers, making defining tests that ensure proper behavior is easy.

+ [Test a worker](./test-debug/test.md)

### Debug a worker

Asset Compute applications provide various levels of debuggin from simply `console.log(..)` statement output, to integrations with __VS Code__ and  __wskdebug__, allowing developers step through worker code as it executes in real time.

+ [Debug a worker](./test-debug/debug.md)

## Deploy

To deploy and integrate vustom Asset Compute workers with AEM as a Cloud Service, they are deployed to Adobe I/O Runtime and then invoked from AEM as a Cloud Service Author via Assets Processing Profiles.

## Deploying to Adobe I/O Runtime

Asset Compute workers must be deployed to Adobe I/O Runtime to be used with AEM as a Cloud Service.

+ [Using Processing Profiles](./deploy/runtime.md)

## Invoke workers via AEM Processing Profiles

Once deployed to Adobe I/O Runtime, Asset Compute workers can be registered in AEM as a Cloud Service via [Assets Processing Profiles](../../assets/configuring/processing-profiles.md). Processing Profiles are in turn applied to Assets folders, and assets there in 

+ [Using AEM Processing Profiles](./deploy/processing-profiles.md)

## Additional resources

+ [Asset Compute example workers](https://github.com/adobe/asset-compute-example-workers)
+ [Asset Compute Development Tool](https://github.com/adobe/asset-compute-devtool)
+ [Asset Compute SDK](https://github.com/adobe/asset-compute-sdk)
    + [Asset Compute Commons](https://github.com/adobe/asset-compute-commons)
+ [Adobe Cloud Blobstore Wrapper library](https://github.com/adobe/node-cloud-blobstore-wrapper)
+ [Adobe Node Fetch Retry library](https://github.com/adobe/node-fetch-retry)
