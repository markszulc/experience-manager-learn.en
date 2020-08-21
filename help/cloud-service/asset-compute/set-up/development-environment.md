# Set up local development environment

Adobe Asset Compute applications cannot be integrated with the local AEM runtime provided by the AEM SDK, and are created and managed using their own developer toolchain, seperate from the AEM Maven project archetype.

To extend Asset Compute, the following tools must be installed on the local developer machine.

## Install Node.js (and npm)

Asset Compute workers are Node.js applications, and thus require Node.js (and npm) in order to develop and build.

+ [Install Node.js (and npm)](/cloud-service/local-development-environment-set-up/development-tools.html#node-js)

## Install Adobe I/O CLI

[Install the Adobe I/O CLI](/cloud-service/local-development-environment-set-up/development-tools.html#aio-cli), or __aio__ is an command-line (CLI) npm module that facilitates use and interaction with Adobe Cloud technologies, and is used for both generate and locally develop custom Asset Compute workers. 

```
$ npm install -g @adobe/aio-cli
```

### Install the Asset Compute Adobe I/O CLI plugin

The [Adobe I/O CLI Asset Compute plugin](https://github.com/adobe/aio-cli-plugin-asset-compute)

```
$ aio plugins:install @adobe/aio-cli-plugin-asset-compute
```

## Install Docker Desktop

Download and install the latest, stable [Docker Desktop](https://www.docker.com/products/docker-desktop), as this is required to debug Asset Compute workers.


## Install Visual Studio Code

[Microsoft Visual Studio Code](https://code.visualstudio.com/download) is recommended for developing Asset Compute applications, however any [JavaScript-compatible IDE](/experience-manager-learn/cloud-service/local-development-environment-set-up/development-tools.html#set-up-the-development-ide) can be used.

This tutorial assumes the use of Visual Studio Code as it provides the best developer experience for extending Asset Compute.



