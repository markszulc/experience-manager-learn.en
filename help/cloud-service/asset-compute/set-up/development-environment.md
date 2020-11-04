---
title: Set up a local development environment for Asset Compute extensibility
description: Developing Asset Compute workers, which are Node.js JavaScript applications, require specific development tooling that differs from traditional AEM development, ranging from Node.js and various npm modules to Docker Desktop and Microsoft Visual Studio Code.
feature: asset-compute
topics: renditions, development
version: cloud-service
activity: develop
audience: developer
doc-type: tutorial
kt: 6266
thumbnail: KT-6266.jpg
---

# Set up local development environment

Adobe Asset Compute projects cannot be integrated with the local AEM runtime provided by the AEM SDK and are developed using their own tool chain, separate from that required by AEM applications based on the AEM Maven project archetype.

To extend Asset Compute microservices, the following tools must be installed on the local developer machine.

## Abridged set up instructions

The following is an abridge set up instructions. Details on these development tools are described in discrete sections below.

1. [Install Docker Desktop](https://www.docker.com/products/docker-desktop) and pull the required Docker images:

    ```
    $ docker pull openwhisk/action-nodejs-v12:latest
    $ docker pull adobeapiplatform/adobe-action-nodejs-v12:latest
    ```

1. [Install Visual Studio Code](https://code.visualstudio.com/download)
1. [Install Node.js 10+](../../local-development-environment/development-tools.md#node-js)
1.  Install the required npm modules and Adobe I/O CLI plug-ins from the command line:

    ```
    $ npm i -g @adobe/aio-cli @openwhisk/wskdebug ngrok --unsafe-perm=true \
    && aio plugins:install @adobe/aio-cli-plugin-asset-compute
    ```

For more information on the abridged install instructions, read the sections below.

## Install Visual Studio Code{#vscode}

[Microsoft Visual Studio Code](https://code.visualstudio.com/download) is used for developing and debugging Asset Compute workers. While other [JavaScript-compatible IDE](../../local-development-environment/development-tools.md#set-up-the-development-ide) can be used to develop the worker, only Visual Studio Code can be integrated to [debug](../test-debug/debug.md) Asset Compute worker.

_Visual Studio Code 1.48.x+ is required for [wskdebug](#wskdebug) to work._

This tutorial assumes the use of Visual Studio Code as it provides the best developer experience for extending Asset Compute.

## Install Docker Desktop{#docker}

Download and install the latest, stable [Docker Desktop](https://www.docker.com/products/docker-desktop), as this is required to [test](../test-debug/test.md) and [debug](../test-debug/debug.md) Asset Compute projects locally.

After installing Docker Desktop, start it and install the following Docker images from the command line:

```
$ docker pull openwhisk/action-nodejs-v12:latest
$ docker pull adobeapiplatform/adobe-action-nodejs-v12:3.0.22
```

Developers on Windows machines should make sure that they are using Linux containers for the images above. The steps to switch to Linux containers are described in the [Docker for Windows documentation](https://docs.docker.com/docker-for-windows/).

## Install Node.js (and npm){#node-js}

Asset Compute workers are [Node.js](https://nodejs.org/)-based, and thus require Node.js 10+ (and npm) to develop and build.

+ [Install Node.js (and npm)](../../local-development-environment/development-tools.md#node-js) in the same manner as for traditional AEM development.

## Install Adobe I/O CLI{#aio}

[Install the Adobe I/O CLI](../../local-development-environment/development-tools.md#aio-cli), or __aio__ is an command-line (CLI) npm module that facilitates use of and interaction with Adobe I/O technologies, and is used for both generate and locally develop custom Asset Compute workers. 

```
$ npm install -g @adobe/aio-cli
```

## Install the Adobe I/O CLI Asset Compute plugin{#aio-asset-compute}

The [Adobe I/O CLI Asset Compute plugin](https://github.com/adobe/aio-cli-plugin-asset-compute)

```
$ aio plugins:install @adobe/aio-cli-plugin-asset-compute
```

## Install wskdebug{#wskdebug}

Download and install the [Apache OpenWhisk debug](https://www.npmjs.com/package/@openwhisk/wskdebug) npm module to facilitate local debugging of Asset Compute workers.

_Visual Studio Code 1.48.x+ is required for [wskdebug](#wskdebug) to work._

```
$ npm install -g @openwhisk/wskdebug
```

## Install ngrok{#ngrok}

Download and install the [ngrok](https://www.npmjs.com/package/ngrok) npm module, which provides public access to your local development machine, to facilitate local debugging of Asset Compute workers.

```
$ npm install -g ngrok --unsafe-perm=true
```
