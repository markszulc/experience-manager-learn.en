---
title: Set up local development environment
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

# Set up local development environment

Adobe Asset Compute applications cannot be integrated with the local AEM runtime provided by the AEM SDK, and are developed using their own toolchain, seperate from that required by AEM applications based on the AEM Maven project archetype.

To extend Asset Compute, the following tools must be installed on the local developer machine.

## Install Node.js (and npm)

Asset Compute workers are Node.js applications, and thus require Node.js (and npm) to develop and build.

+ [Install Node.js (and npm)](/cloud-service/local-development-environment-set-up/development-tools.html#node-js)

## Install Adobe I/O CLI

[Install the Adobe I/O CLI](/cloud-service/local-development-environment-set-up/development-tools.html#aio-cli), or __aio__ is an command-line (CLI) npm module that facilitates use and interaction with Adobe I/O technologies, and is used for both generate and locally develop custom Asset Compute workers. 

```
$ npm install -g @adobe/aio-cli
```

### Install the Asset Compute Adobe I/O CLI plugin

The [Adobe I/O CLI Asset Compute plugin](https://github.com/adobe/aio-cli-plugin-asset-compute)

```
$ aio plugins:install @adobe/aio-cli-plugin-asset-compute
```

## Install Visual Studio Code{#vscode}

[Microsoft Visual Studio Code](https://code.visualstudio.com/download) is used for developing and debugging Asset Compute applications. While other [JavaScript-compatible IDE](/experience-manager-learn/cloud-service/local-development-environment-set-up/development-tools.html#set-up-the-development-ide) can be used to develop the application. only Visual Studio Code can be integrated to [debug](../test-debug/debug.md) Asset Compute applications.


This tutorial assumes the use of Visual Studio Code as it provides the best developer experience for extending Asset Compute.

## Install wskdebug{#wskdebug}

Download and install the [Apache OpenWhisk debug](https://www.npmjs.com/package/@openwhisk/wskdebug) npm module to support local debugging of Asset Compute applications.

```
$ npm install -g https://github.com/apache/openwhisk-wskdebug
```



## Install ngrok{#ngrok}

Download and install the [ngrok](https://www.npmjs.com/package/ngrok) npm module, which provides public access to your local development machine, to support local debugging of Asset Compute applications.

```
$ npm install -g ngrok --unsafe-perm=true
```

## Install Docker Desktop{#docker}

Download and install the latest, stable [Docker Desktop](https://www.docker.com/products/docker-desktop), as this is required to [test](../test-debug/test.md) and [debug](../test-debug/debug.md) Asset Compute workers.
