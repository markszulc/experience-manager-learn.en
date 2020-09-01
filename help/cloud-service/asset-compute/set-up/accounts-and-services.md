---
title: Set up accounts
description: 
feature: 
topics: 
version: cloud-service
doc-type: tutorial
activity: 
audience: developer
kt: 
thumbnail: 
---

# Set up accounts

This tutorial requires the following services to be provisioning and accessible via the learner's Adobe ID. All Adobe services must be accessible through the same Adobe Org, using your Adobe ID.

+ [AEM as a Cloud Service](#aem-as-a-cloud-service)
+ [Adobe Project FireFly](#adobe-project-firefly) 
+ Cloud storage
    + [Azure Blob Storage](https://azure.microsoft.com/en-us/services/storage/blobs/)
    + or [Amazon S3](https://aws.amazon.com/s3/?did=ft_card&trk=ft_card)
+ Asset processing Web service
    + This tutorial uses [Adobe Photoshop APIs](https://www.adobe.io/apis/creativecloud/photo-imaging-api.html).
    + __[Sign-up for free](https://photoshop.adobelanding.com/api-signup/)__. Request access using the Adobe Id (e-mail address) associated with your AEM as a Cloud Service program/environment.

_Ensure you have access to all of the aforementioned services, prior to continuing through this tutorial._

## AEM as a Cloud Service{#aem-as-a-cloud-service}

Access to an AEM as a Cloud Service environment is required in order to configure AEM Assets Processing Profiles to invoke the custom Asset Compute application. 

Ideally a sandbox program or a non-sandbox Development environment is available for use.

Note that a local AEM SDK is insufficient to full complete this tutorial, as the local AEM SDK cannot communicate with Asset Compute microservices, instead a true AEM as a Cloud Service environment is required.

## Adobe Project Firefly{#adobe-project-firefly}

The [Adobe Project Firefly](https://www.adobe.io/apis/experienceplatform/project-firefly.html) framework is used for building and deploying custom applications to Adobe I/O Runtime, Adobe's serverless platform. AEM Asset Compute applications are specially built Firefly applications that integrate with AEM Assets via Processing Profiles, and provide the ability to access and process asset binaries.

To gain access to Project Firefly, sign-up for the preview.

1. [Sign up for Project Firefly preview](https://adobeio.typeform.com/to/obqgRm). 
1. Wait until you have been provisioned before continuing with the tutorial.
    + If you are unsure if you've been provisioned, continue with the next steps and if you are unable to create a __Project Firefly__ project in [Adobe Developer Console](https://console.adobe.io) you still have not been provisioned.

### Adobe Photoshop APIs

This tutorial uses Adobe Photoshop APIs to create custom renditions of assets. 

1. [Sign-up for free access to the Adobe Photoshop APIs](https://photoshop.adobelanding.com/api-signup/) using the Adobe Id (e-mail address) associated with the Adobe ID used to access [AEM as a Cloud Service](#aem-as-a-cloud-service) and [Adobe Project Firefly](#adobe-project-firefly).

## Cloud storage

Cloud storage is required for local development of Asset Compute applications. 

When Asset Compute applications are deployed to the Adobe I/O Runtime for direct use by AEM as a Cloud Service, this cloud storage is not strictly required as AEM provides the cloud storage from which the asset is read and rendition written to. However, common use cases of often require "extra" cloud storage to facilitates the interaction with Web services that transform the asset. This tutorial explores this use of integrating an Asset Compute worker with Adobe Photoshop API, and this cloud storage to faciliate the delivery of the transformed image from Adobe Photoshop APIs to the Asset Compute worker, and thus making this cloud storage mandatory for this implementation, even past local development.

### Microsoft Azure Blob Storage{#azure-blob-storage}

If you do not already have access to Microsoft Azure Blob Storage, sign up for a [free 12 month account](https://azure.microsoft.com/en-us/free/).

This tutorial will use Azure Blob Storage, however [Amazon S3](#amazon-s3) can be used as well only minor variation to the tutorial.

### Amazon S3{#amazon-s3} 

Using [Azure Blob Storage](#azure-blob-storage) is recommended when following along with this tutorial, however [Amazon S3](https://aws.amazon.com/s3/?did=ft_card&trk=ft_card) can also be used. 

If you need to provision cloud storage specially for this tutorial, we recommend using [Azure Blob Storage](#azure-blob-storage).

