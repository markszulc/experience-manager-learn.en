---
title: Set up accounts and services for Asset Compute extensibility
description: Developing Asset Compute workers require access to accounts and services including AEM as a Cloud Service, Adobe Project Firefly, and cloud storage provided by Microsoft or Amazon.
feature: asset-compute
topics: renditions, development
version: cloud-service
activity: develop
audience: developer
doc-type: tutorial
kt: 6264
thumbnail: 40377.jpg
---

# Set up accounts and services

This tutorial requires the following services to be provisioning and accessible via the learner's Adobe ID.

All Adobe services must be accessible through the same Adobe Org, using your Adobe ID.

+ [AEM as a Cloud Service](#aem-as-a-cloud-service)
+ [Adobe Project FireFly](#adobe-project-firefly) 
    + Provisioning can take between 2 - 10 days
+ Cloud storage
    + [Azure Blob Storage](https://azure.microsoft.com/en-us/services/storage/blobs/)
    + or [Amazon S3](https://aws.amazon.com/s3/?did=ft_card&trk=ft_card)

>[!WARNING]
>
>Ensure you have access to all of the aforementioned services, prior to continuing through this tutorial.
> 
> Review sections below on how to set and provision the required services.

## AEM as a Cloud Service{#aem-as-a-cloud-service}

Access to an AEM as a Cloud Service environment is required in order to configure AEM Assets Processing Profiles to invoke the custom Asset Compute worker. 

Ideally a sandbox program or a non-sandbox Development environment is available for use.

Note that a local AEM SDK is insufficient to complete this tutorial, as the local AEM SDK cannot communicate with Asset Compute microservices, instead a true AEM as a Cloud Service environment is required.

## Adobe Project Firefly{#adobe-project-firefly}

The [Adobe Project Firefly](https://www.adobe.io/apis/experienceplatform/project-firefly.html) framework is used for building and deploying custom actions to Adobe I/O Runtime, Adobe's serverless platform. AEM Asset Compute projects are specially built Firefly projects that integrate with AEM Assets via Processing Profiles, and provide the ability to access and process asset binaries.

To gain access to Project Firefly, sign-up for the preview.

1. [Sign up for Project Firefly preview](https://adobeio.typeform.com/to/obqgRm). 
1. Wait approximately 2 - 10 days until you're notified via e-mail that you are provisioned before continuing with the tutorial.
    + If you are unsure if you've been provisioned, continue with the next steps and if you are unable to create a __Project Firefly__ project in [Adobe Developer Console](https://console.adobe.io) you still have not been provisioned.

## Cloud storage

Cloud storage is required for local development of Asset Compute projects. 

When Asset Compute workers are deployed to the Adobe I/O Runtime for direct use by AEM as a Cloud Service, this cloud storage is not strictly required as AEM provides the cloud storage from which the asset is read and rendition written to. 

### Microsoft Azure Blob Storage{#azure-blob-storage}

If you do not already have access to Microsoft Azure Blob Storage, sign up for a [free 12 month account](https://azure.microsoft.com/en-us/free/).

This tutorial will use Azure Blob Storage, however [Amazon S3](#amazon-s3) can be used as well only minor variation to the tutorial.

>[!VIDEO](https://video.tv.adobe.com/v/40377/?quality=12&learn=on)

_Click-through of provisioning Azure Blob Storage (No audio)_


1. Log in to your [Microsoft Azure account](https://azure.microsoft.com/en-us/account/).
1. Navigate to the __Storage Accounts__ Azure services section
1. Tap __+ Add__ to create a new Blob Storage account
1. Create a new __Resource group__ as needed, for example: `aem-as-a-cloud-service`
1. Provide a __Storage account name__, for example: `aemguideswkndassetcomput`
    + The __Storage account name__ will be used for [configuring cloud storage](../develop/environment-variables.md) for the local Asset Compute Development Tool
    + The __Access keys__ associated with the storage account are also required when [configuring cloud storage](../develop/environment-variables.md).
1. Leave everything else as default, and tap the __Review + create__ button
    + Optionally, select the __location__ close to you.
1. Review the provisioning request for correctness, and tap __Create__ button if satified

### Amazon S3{#amazon-s3} 

Using [Microsoft Azure Blob Storage](#azure-blob-storage) is recommended for completing this tutorial, however [Amazon S3](https://aws.amazon.com/s3/?did=ft_card&trk=ft_card) can also be used.

If using Amazon S3 storage, specify the Amazon S3 cloud storage credentials when [configuring the project's environment variables](../develop/environment-variables.md#amazon-s3).

If you need to provision cloud storage specially for this tutorial, we recommend using [Azure Blob Storage](#azure-blob-storage).
