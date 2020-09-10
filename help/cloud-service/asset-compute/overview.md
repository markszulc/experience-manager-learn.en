---
title: 
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

## Set up

In order to begin developing custom Asset Compute applications, accounts and services must be provisioend and configured, and software installed on the local development machines.

### Account and service provisioning 

The following accounts and services require provisioning and access to in order to complete the tutorial, AEM as a Cloud Service Dev environment or Sandbox program, access to Adobe Project Firefly and  Microsoft Azure Blob Storage.

+ [Provision accounts and services](./set-up/accounts-and-services.md)

### Local development environment

Local development of Asset Compute applications requires a discrete developer tool box for traditional AEM development, including, Microsoft Visual Studio Code, Docker Desktop, Node.js and supporting npm modules.
 
+ [Set up local development environment](./set-up/development-environment.md)

### Set up the Adobe I/O Project Firefly project

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

+ [Use Asset Compute Dev Tool](./develop/dev-tool.md)

## Test and Debug

### Test a worker

### Debug a worker

## Deploy

### Configure Adobe I/O workspaces

### Deploy

### Running workers via AEM Processing Profiles








## Additional resources

+ [Asset compute example worker Github repository](https://github.com/adobe/asset-compute-example-workers)