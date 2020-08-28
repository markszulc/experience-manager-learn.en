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

This tutorial requires the following services to be provisioning and accessible. All Adobe services must be accessible through the same Adobe Org, using your Adobe ID.

+ [AEM as a Cloud Service](https://my.cloudmanager.adobe.com/)
+ Adobe I/O Asset Compute project (based on [Adobe Project FireFly](https://www.adobe.io/apis/experienceplatform/project-firefly.html))
+ Cloud storage
    + [Azure Blob Storage](https://azure.microsoft.com/en-us/services/storage/blobs/)
    + or [Amazon S3](https://aws.amazon.com/s3/?did=ft_card&trk=ft_card)
+ Asset processing Web service
    + This tutorial uses [Adobe Photoshop APIs](https://www.adobe.io/apis/creativecloud/photo-imaging-api.html).
    + __[Sign-up for free](https://photoshop.adobelanding.com/api-signup/)__. Make sure you request access using the e-mail address associated with your AEM as a Cloud Service program/environment.

Ensure you have access to all of the aforementioned services, prior to continuing through this tutorial.

## AEM as a Cloud Service{#aem-as-a-cloud-service}

Access to an AEM as a Cloud Service environment is required in order to configure AEM Assets Processing Profiles to invoke the custom Asset Compute application. 

Ideally a sandbox program or a non-sandbox Development environment is available for use.

Note that a local AEM SDK is insufficient to full complete this tutorial, as the local AEM SDK cannot communicate with Asset Compute microservices, instead a true AEM as a Cloud Service environment is required.

## Adobe Project Firefly{#asset-compute-project}

The [Adobe Project Firefly](https://www.adobe.io/apis/experienceplatform/project-firefly.html) framework is used for building and deploying custom applications to Adobe I/O Runtime, Adobe's serverless platform. AEM Asset Compute workers are specially built Firefly applications that integrate with AEM Assets via Processing Profiles, and provide the ability to process asset binaries.

Create and set up an Adobe Project Firefly Adobe I/O project:

2. As a System Administrator or Developer Role access, log into the [Adobe Developer Console](https://console.adobe.io). Ensure the Adobe Experience Cloud Organization that is part of the AEM as a Cloud Service integration is selected in the Organization switcher. 

3. Create a Firefly project by tapping __Create new project > Project from template > Project Firefly__. 
    + Give the Project title a meaningful name, such as `WKND AEM Asset Compute`.
    + The App name must be unique across all Firefly apps and is not modifiable later. Prefixing the your Company or Organizations name, and postfixing with a meaningful suffix is a good approach, such as `wkndAemAssetCompute`.
_If either __Create new project__ or the __Project Firefly__ type is not available, this means your Organization has not been provisioned with Firefly. //TODO_
    + Under __Workspaces__ add a new environment named `Development`.
    + Under __Adobe I/O Runtime__ ensure `Include Runtime with each workspace` is selected.


 creates a new Firefly Project with two workspaces: Production and Stage. Add additional workspaces, for example Development, as required.

In the Firefly Project, select a workspace and subscribe to the services needed for Asset Compute. Click Add to Project > API and add Asset Compute, IO Events, and IO Events Management services. When adding the first API, it prompts to create a private key. Save this information on your machine as you need this key to test your custom application with the developer tool.


## Cloud storage

### Microsoft Azure Blob Storage{#azure-blob-storage}

If you do not already have access to Microsoft Azure Blob Storage, sign up for a [free 12 month account](https://azure.microsoft.com/en-us/free/).

This tutorial will use Azure Blob Storage, however [Amazon S3](#amazon-s3) can be used as well only minor variation to the tutorial.

### Amazon S3{#amazon-s3} 

Using [Azure Blob Storage](#azure-blob-storage) is recommended when following along with this tutorial, however  [Amazon S3](https://aws.amazon.com/s3/?did=ft_card&trk=ft_card) can also be used. 

If you need to provision cloud storage specially for this tutorial, we recommend using [Azure Blob Storage](#azure-blob-storage).

### Adobe Photoshop APIs

This tutorial uses Adobe Photoshop APIs to create custom renditions of assets. 

Ensure you sign-up for (free access to the Adobe Photoshop APIs)(https://photoshop.adobelanding.com/api-signup/) using the e-mail address associated with the Adobe ID used to access [AEM as a Cloud Service](#aem-as-a-cloud-service) and [Adobe Project Firefly](#adobe-project-firefly).
