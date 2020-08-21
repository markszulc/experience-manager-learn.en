---
title: Set up accounts
description: 
feature: 
topics: 
version: cloud-service
doc-type: tutorial
activity: git cl
audience: developer
doc-type: article
kt: 5802
thumbnail: KT-5802.jpg
---

# Set up accounts

Developing Asset Compute applications introduces several dependencies on 

+ AEM as a Cloud Service
+ Adobe I/O Asset Compute project
+ Cloud storage
    + Azure Blob Storage
    + or Amazon S3
+ Asset processing Web service
    + In this tutorial we will use //TODO

Ensure you have access to all to all of these services, prior to continuing through this tutorial.

## AEM as a Cloud Service 

Access to an AEM as a Cloud Service environment is required in order to configure AEM Assets Processing Profiles to invoke the custom Asset Compute application. Ideally a sandbox program or a non-sandbox Development environment is available for use.

### Adobe I/O Asset Compute project

The [Adobe Firefly](https://www.adobe.io/apis/experienceplatform/project-firefly.html) framework is used for building and deploying custom applications to Adobe I/O Runtime, Adobe's serveless platform. AEM Asset Compute workers are specially built Firefly applications that integrate with AEM Assets via Processing Profiles, and provide the ability to process asset binaries.

Create and set up an Adobe I/O Firefly Project:

2. As a System Administrator or Developer Role access, log into the [Adobe Developer Console](https://console.adobe.io). Ensure the Adobe Experience Cloud Organization that is part of the AEM as a Cloud Service integration is selected in the Organization switcher. 

3. Create a Firefly project by tapping __Create new project > Project from template > Project Firefly__. 
    + Give the Project title a meaningful name, such as `WKND AEM Asset Compute`.
    + The App name must be unique across all Firefly apps and is not modifiable later. Prefixing the your Company or Organizations name, and postfixing with a meaningful suffix is a good approach, such as `wkndAemAssetCompute`.
_If either __Create new project__ or the __Project Firefly__ type is not available, this means your Organization has not been provisioned with Firefly. //TODO_
    + Under __Workspaces__ add a new environment named `Development`.
    + Under __Adobe I/O Runtime__ ensure `Include Runtime with each workspace` is selected.


 creates a new Firefly Project with two workspaces: Production and Stage. Add additional workspaces, for example Development, as required.

In the Firefly Project, select a workspace and subscribe to the services needed for Asset Compute. Click Add to Project > API and add Asset Compute, IO Events, and IO Events Management services. When adding the first API, it prompts to create a private key. Save this information on your machine as you need this key to test your custom application with the developer tool.







### Cloud storage

### Microsoft Azure Blob Storage{#azure-blob-storage}

If you do not already gave access to Microsoft Azure Blob Storage, sign up for a [free 12 month account](https://azure.microsoft.com/en-us/free/).

https://docs.microsoft.com/en-us/azure/storage/common/storage-account-create?tabs=azure-portal

### Amazon AWS S3 
