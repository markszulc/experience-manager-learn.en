---
title: Set up local development environment for Asset Compute
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

To develop custom Asset Compute applications, the following tools must be installed on the local developer machine.

## Abridged set up instructions

The following is an abridge set up instructions. Details around the various development tools are described in their sections below.

![Abridged install](./assets/development-environment/abridged-install.png--TODO)

1. [Install Docker Desktop](https://www.docker.com/products/docker-desktop) for local test execution
    ```
    $ docker pull openwhisk/action-nodejs-v10:latest
    $ docker pull adobeapiplatform/adobe-action-nodejs-v10:3.0.21
    ```
1. [Install Visual Studio Code](https://code.visualstudio.com/download)
1. [Install Node.js 10+](../../local-development-environment/development-tools.md#node-js)
1.  Install npm modoules and AIO plug-ins from the command line:
    ```
    $ npm i -g @adobe/aio-cli @openwhisk/wskdebug ngrok --unsafe-perm=true \
    && aio plugins:install @adobe/aio-cli-plugin-asset-compute
    ```

## Install Visual Studio Code{#vscode}

[Microsoft Visual Studio Code](https://code.visualstudio.com/download) is used for developing and debugging Asset Compute applications. While other [JavaScript-compatible IDE](/../../local-development-environment/development-tools.md#set-up-the-development-ide) can be used to develop the application. only Visual Studio Code can be integrated to [debug](../test-debug/debug.md) Asset Compute applications.

_Visual Studio Code 1.48.x+ is required for [#wskdebug](#wskdebug) to work._

This tutorial assumes the use of Visual Studio Code as it provides the best developer experience for extending Asset Compute.

## Install Docker Desktop{#docker}

Download and install the latest, stable [Docker Desktop](https://www.docker.com/products/docker-desktop), as this is required to [test](../test-debug/test.md) Asset Compute applications locally.

After installing Docker Desktop, start it and install the following Docker images from the command line:

```
$ docker pull openwhisk/action-nodejs-v10:latest
$ docker pull adobeapiplatform/adobe-action-nodejs-v10:3.0.21
```

Developers on Windows machines should make sure that they are using Linux containers for the images above. The steps to switch to Linux containers are described in the [Docker for Windows documentation](https://docs.docker.com/docker-for-windows/).

## Install Node.js (and npm)

Asset Compute workers are [Node.js](https://nodejs.org/) applications, and thus require Node.js 10+ (and npm) to develop and build.

+ [Install Node.js (and npm)](../../local-development-environment/development-tools.md#node-js)

```
$ npm install -g @adobe/aio-cli
```

## Install Adobe I/O CLI

[Install the Adobe I/O CLI](/../../local-development-environment/development-tools.md#aio-cli), or __aio__ is an command-line (CLI) npm module that facilitates use and interaction with Adobe I/O technologies, and is used for both generate and locally develop custom Asset Compute workers. 

```
$ npm install -g @adobe/aio-cli
```

### Install the Adobe I/O CLI Asset Compute plugin

The [Adobe I/O CLI Asset Compute plugin](https://github.com/adobe/aio-cli-plugin-asset-compute)

```
$ aio plugins:install @adobe/aio-cli-plugin-asset-compute
```

## Install wskdebug{#wskdebug}

Download and install the [Apache OpenWhisk debug](https://www.npmjs.com/package/@openwhisk/wskdebug) npm module to facilitate local debugging of Asset Compute applications.

_Visual Studio Code 1.48.x+ is required for wskdebug(#wskdebug) to work._

```
$ npm install -g @openwhisk/wskdebug
```

## Install ngrok{#ngrok}

Download and install the [ngrok](https://www.npmjs.com/package/ngrok) npm module, which provides public access to your local development machine, to facilitate local debugging of Asset Compute applications.

```
$ npm install -g ngrok --unsafe-perm=true
```
