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

The following accounts and services require provisioning and access to in order to complete the tutorial:

+ AEM as a Cloud Service Dev environment or Sandbox program
+ Access to Adobe Project Firefly
+ Access to Microsoft Azure Blob Storage


[Provision accounts and services](./set-up/accounts-and-services.md)

### Local development environment

Local development of Asset Compute applications requires a discrete developer tool box for traditional AEM development, including:

+ Microsoft Visual Studio Code
+ Docker Desktop
+ Node.js and supporting npm modules

[Set up local development environment](./set-up/development-environment.md)

### Set up the Adobe I/O Project Firefly project

Asset Compute applications are specially defined Adobe Project Firefly applications, and as such, require access to Adobe Project Firefly in the Adobe Developer Console in order to set up and deploy them.

[Set up the Adobe Project Firefly project](./set-up/firefly.md)

## Develop 

### Create a new Asset Compute project

+ [Create a new Asset Compute project](./develop/project.md) using the Adobe I/O CLI.

### Configure environment variables

+ [Configure the Asset Compute project's environment variables](./develop/environment-variables.md) for local development.

### Configure the manifest.yml

+ [Configure the Asset Compute project's manifest.yml](./develop/manifest.md).

### Develop a worker

+ [Developer a customer Asset Compute worker](./develop/worker.md).

### Use Dev Tool to execute the worker

+ [Use Asset Compute Dev Tool](./develop/worker.md) to try out your worker from the local development environment.

## Debug and Test

### Debug a worker

### Test a worker

## Deploy

### Configure Adobe I/O workspaces

### Deploy

### Running workers via AEM Processing Profiles








## Additional resources

+ [Asset compute example worker Github repository](https://github.com/adobe/asset-compute-example-workers)