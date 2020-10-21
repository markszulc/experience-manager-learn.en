---
title: Set up Adobe Project Firefly for Asset Compute extensibility
description: Asset Compute projects are specially defined Adobe Project Firefly projects, and as such, require access to Adobe Project Firefly in the Adobe Developer Console in order to set up and deploy them.
feature: asset-compute
topics: renditions, development
version: cloud-service
activity: develop
audience: developer
doc-type: tutorial
kt: 6268
thumbnail: 40183.jpg
---

# Set up Adobe Project Firefly

Asset Compute projects are specially defined Adobe Project Firefly projects, and as such, require access to Adobe Project Firefly in the Adobe Developer Console in order to set up and deploy them.

## Create and set up Adobe Project Firefly in Adobe Developer Console{#set-up}

>[!VIDEO](https://video.tv.adobe.com/v/40183/?quality=12&learn=on)

_Click-through of setting up Adobe Project Firefly (No audio)_

1. Log in to [Adobe Developer Console](https://console.adobe.io) using the Adobe ID associated with the provisioned [accounts and services](./accounts-and-services.md). Ensure you are a __System Administrator__ or in the __Developer Role__ for the correct Adobe Org.
1. Create a Firefly project by tapping __Create new project > Project from template > Project Firefly__

    _If either __Create new project__ button or the __Project Firefly__ type is not available, this means your Adobe Org is not [provisioned with Project Firefly](#request-adobe-project-firefly)._
    
    + __Project title__: `WKND AEM Asset Compute`
    + __App name__: `wkndAemAssetCompute<YourName>`
        + The __App name__ must be unique across all Firefly projects and is not modifiable later. Prefixing the your company or organization's name, and postfixing with a meaningful suffix is a good approach, such as: `wkndAemAssetCompute`.
        + For self-enablement it is often best to postfix your name to the __App name__, such as `wkndAemAssetComputeJaneDoe` to avoid collisions with other Project Firefly projects.
    + Under __Workspaces__ add a new environment named `Development`
    + Under __Adobe I/O Runtime__ ensure __Include Runtime with each workspace__ is selected
    + Tap __Save__ to save the project
1. In the Adobe Firefly project, select `Development` from the workspace selector
1. Tap __+ Add Service > API__ to open the __Add an API__ wizard, use this approach to add the following APIs:

    + __Experience Cloud > Asset Compute__
        + Select __Generate a key pair__ and tap the __Generate keypair__ button, and save the downloaded `config.zip` to a safe location for [later use](#private-key)
        + Tap __Next__
        + Select the Product profile __Integrations - Cloud Service__ and tap __Save configured API__
    + __Adobe Services > I/O Events__ and tap __Save configured API__
    + __Adobe Services > I/O Management API__ and tap __Save configured API__

## Access the private.key{#private-key}

When setting up the [Asset Compute API integration](#set-up) a new key pair was generated and a `config.zip` file was automatically downloaded. This `config.zip` contains the generated public certificate and matching `private.key` file. 

1. Unzip `config.zip` to a safe place on your file system as the `private.key` is [used later](../develop/environment-variables.md)
    + Secrets and private keys should never be added to Git as a matter of security.

## Review the Service Account (JWT) Credentials

This Adobe I/O project's credentials are used by the local [Asset Compute Development Tool](../develop/development-tool.md) to interact with Adobe I/O Runtime, and will need to be incorporated into the Asset Compute project. Familiarize yourself with the Service Account (JWT) credentials.

![Adobe Developer Service Account credentials](./assets/firefly/service-account.png)

1. From the Adobe I/O Project Firefly project, ensure the `Development` workspace is selected
1. Tap on __Service Account (JWT)__ under __Credentials__ 
1. Review the Adobe I/O Credentials displayed
    + The __public key__ listed at the bottom has it's __private.key__ counterpart in the `config.zip` downloaded when the __Asset Compute API__ was added to this project.
        + If the private key is lost or compromised, the matching public key can be removed, and a new key pair generated in or uploaded to Adobe I/O using this interface.
