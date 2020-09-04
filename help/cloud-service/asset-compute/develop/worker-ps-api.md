---
title: Asset compute worker
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

# Develop an Asset Compute worker

Asset Compute workers are the core of an Asset Compute application as they are what provide the custom functionality that performs or orchestrates the work performed on an asset to create a new rendition.

The Asset Compute project auto-generates a simple worker that simply copies the asset's original binary into a named rendition, without any transformations. We could modify this worker implementation with our custom logic, but instead, we'll create a brand new worker so it's clear how brand new workers can be defined and registered for use within a single project.


## Understanding how an Asset Compute worker orchestrates work

Asset Compute workers often rely on external Web services to perform that actual renditioning of an assets, and merely act as an orchestrator of the work to be done.

![TODO]()

1. When an Asset Compute worker is invoked from AEM Author service, it is against an AEM asset via a Processing Profile. The asset's original binary is passed to the worker via rendition callback function's `source` parameter, and any parameters defined in the Processing Profile, via the optional `params` parameter.
1. The Asset Compute worker creates presigned PUT and GET URLs in the configured cloud storage (Azure Blob Storage or Amazon S3). This is a protected, but internet-available end-point both the Asset Compute worker and any asset processing web service can access and will be used as a location the asset processing web service can write the transformed rendition binary back to.
1. The worker makes a HTTP call to the Web service, providing the presigned GET url to the assets original binary, available via `source.url` , and the presigned PUT (meaining it can be written to) URL generated in Step 2.
1. Upon invoking the Web service's API, the original rendition's binary is retrieved by the Web service via the presigned `source.url` and the Web service performs the requested computations and transformations on it, generating the rendition.
1. The Web service saves the rendition to the presigned PUT URL in cloud storage, so the worker can retrieve it.
1. Upon completion, the worker is notified of completion (usually by polling the Web service since it doesnt have a public HTTP end-point), and then, the worker copies the rendition stored at the in the Cloud storage, into the rendition in AEM Author service.


## Anatomy of a worker

Workers follow the same basic structure and input/output contract.

```javascript
'use strict';

// Any npm module imports used by the worker
const { worker, SourceCorruptError, GenericError } = require('@adobe/asset-compute-sdk');
const { GenericError } = require('@adobe/asset-compute-commons');
const fs = require('fs').promises;

/**
Exports the worker defined by a custom rendition callback function, which parameterizes the input/output contract for the worker.
 + `source` represents the asset's original binary used as the input for the worker.
 + `rendition` represents the worker's output, which is the creation of a new asset rendition.
 + `params` are optional parameters, which map to additional key/value pairs, including a sub `auth` object that contians Adobe I/O access credentials.
**/
exports.main = worker(async (source, rendition, params) => {
    // Perform any necessary source (input) checks
    const stats = await fs.stat(source.path);
    if (stats.size === 0) {
        throw new SourceCorruptError('source file is empty');
    }

    // Access any custom parameters provided via the Processing Profile configuration
    let param1 = rendition.instructions.exampleParam;

    /** 
    Perform all work needed to transform the source into the rendition.
    
    The source data can be accessed:
        + In the worker via a file available at `source.path`
        + Or via a presigned GET URL at `source.url`
    **/
    if (success) {
        // A successful worker must write some data back to `renditions.path`. 
        // This example performs a trivial 1:1 copy of the source binary to the rendition
        await fs.copyFile(source.path, rendition.path);
    } else {
        // Upon failure an Asset Compute Error (exported by @adobe/asset-compute-commons) should be thrown.
        throw new GenericError("An error occurred!", "example-worker");
    }
});

/**
Optionally create helper functions the worker's rendition callback function invokes to help organize code.
**/
function customHelperFunction() { ... }
```

## Create a new worker

Ensure the Asset Compute project is open in VS Code.

1. Navigate to the `/actions` folder.
1. Create a new folder under `/actions` named `auto-straighten`. This folder will contain the new worker, so name it semantically based on what the worker does.
1. In the newly created `/actions/auto-straighten` folder, create a file named `index.js`. 
1. Copy the following code into `/actions/auto-straighten/index.js`. This code is a minor derivation of the autogenerated code in `/actions/worker/index.js`, removing some of the implementation details we won't need.

    ```javascript
    'use strict';

    const { worker, SourceCorruptError } = require('@adobe/asset-compute-sdk');
    const fs = require('fs').promises;

    exports.main = worker(async (source, rendition, params) => {
        // Check handle a corrupt input source
        const stats = await fs.stat(source.path);
        if (stats.size === 0) {
            throw new SourceCorruptError('source file is empty');
        }

        // Do work here
    });
    ```

## Install and import supporting npm modules

As a Node.JS application, Asset Compuet workers benefit from the robust [npm module ecosystem](https://npmjs.com). To leverage npm modules we must first install them into our Asset Compute application project.


1. Open terminal in the root of your Asset Compute application project and execute the command:

```
$ npm install uuid @adobe/cloud-blobstore-wrapper @adobe/node-fetch-retry @adobe/httptransfer
```

This installs the following npm modules for use in the project:

    + [@adobe/cloud-blobstore-wrapper](https://www.npmjs.com/package/@adobe/cloud-blobstore-wrapper) used to create cloud storage blobs used to securely expose the asset to trusted Web services for transformation
    + [uuid](https://www.npmjs.com/package/uuid) used to create unique paths in cloud storage to avoid conflicts between concurrent Asset Compute worker execution
    + [@adobe/node-fetch-retry](https://www.npmjs.com/package/@adobe/node-fetch-retry) used to interact with the trusted Web Services that will transform the asset into the rendition
    + [@adobe/httptransfer](https://www.npmjs.com/package/@adobe/httptransfer) used to download the tranformed binary from the cloud storage so it can be saved back into AEM Author service

1. Next, import the npm module into the worker. Update the require directives at the top of the worker's `index.js` to import the following:

```javascript
'use strict';

const { worker, SourceCorruptError, GenericError } = require('@adobe/asset-compute-sdk');
const { CloudStorage } = require('@adobe/cloud-blobstore-wrapper');
const { downloadFile } = require('@adobe/httptransfer');
const { v4: uuidv4 } = require('uuid');
const fetch = require('@adobe/node-fetch-retry');
const fs = require('fs').promises;

exports.main = worker(async (source, rendition, params) => {
    // Check handle a corrupt input source
    const stats = await fs.stat(source.path);
    if (stats.size === 0) {
        throw new SourceCorruptError('source file is empty');
    }

    // Do work here
});
```

## Set up cloud storage

Since the actual transformation of our asset will be performed by a Web service external to the Asset Compute worker, a mechanism for getting the source binary to this Web service, and the transformed binary back to the worker is needed. For this we use secure, presigned GET and PUT URLs in our selected Cloud Storage. This provide a secure way for systems to read (via the presigned GET URL) or write (via the presigned PUT URL) data from commonly accessible location.

Let's create presigned PUT and GET URLs used to faciliate the access to the source and transformed binaries using Adobe's `@adobe/cloud-blobstore-wrapper` npm module.

In this tutorial we'll use [Azure Blob Storage](https://www.npmjs.com/package/@adobe/cloud-blobstore-wrapper#azure), but [Amazon S3 can used following similar APIs calls](https://www.npmjs.com/package/@adobe/cloud-blobstore-wrapper#aws).


1. Initialize a new CloudStorage object with your cloud storage credentials. These are exposed through the `params` object (3rd parameter in the rendition callback function) via the `inputs` defined for this worker in the `manifest.yml`

The following signature is used for [Azure Blob Storage](https://www.npmjs.com/package/@adobe/cloud-blobstore-wrapper#azure), the configuration property names for [Amazon S3](https://www.npmjs.com/package/@adobe/cloud-blobstore-wrapper#aws) differ slightly.

```javascript
...
// Initialize the cloud storage with the credentials defined in the .env, passed through manifest.yml inputs
const cloudStorage = new CloudStorage({
        accountName: params.cloudStorageId,
        accountKey: params.cloudStorageSecret
    },
    params.cloudStorageContainer);
...
```    

1. Next, create a function that generates the presigned GET and PUT URLs in the cloud storage.

```javascript
//  Defines an `async` function that takes the configured `cloudStorage` object as a parameter.
async function getPresignedUrls(cloudStorage) {
    // Make a unique path in the cloud storage using the current date and `uuid`. 
    // Use a pathing-system that supports troubleshooting and clean-up.
    const now = new Date();
    const path = `/tmp/wknd-asset-compute/${now.getYear()}-${now.getMonth()}-${now.getDate()}/${uuidv4()}`;
    
    // Sets an expiry for the presigned URLs. 
    // Ensure the expiry is long enough for all worker that depends on them to be completed, but not unncessarily long.
    const expiry = 60000 * 2; // 2 minutes

    return {
        // The (unique) path in the cloud storage the presigned URLs points to
        path: path, 
        // A presigned GET URL to the cloud storage path allowing anyone holding this URL to read the contents at the path. 
        // This worker will use the GET URL later to download (read) the transformed binary.
        get: cloudStorage.presignGet(path, expiry), 
        // A presigned PUT URL to the cloud storage path allowing anyone holding this URL to read the contents at the path. 
        // Adobe I/O Web service will use the PUT URL later to save (write) the transformed binary.
        put: cloudStorage.presignPut(path, expiry) 
    };
}   
```

1. In the rendition callback function of the worker, perform an awaiting call to the `getPresignedUrls(...)` to generate the presigned URLs.

```javascript
...
const presignedUrls = await getPresignedUrls(cloudStorage);

// Do work here
...
```

1. The worker's `index.js` should look like:

```javascript
'use strict';

const { worker, SourceCorruptError, GenericError } = require('@adobe/asset-compute-sdk');
const { CloudStorage } = require('@adobe/cloud-blobstore-wrapper');
const { v4: uuidv4 } = require('uuid');
const fetch = require('@adobe/node-fetch-retry');
const fs = require('fs').promises;

exports.main = worker(async (source, rendition, params) => {
    // Check handle a corrupt input source
    const stats = await fs.stat(source.path);
    if (stats.size === 0) {
        throw new SourceCorruptError('source file is empty');
    }

    const presignedUrls = await getPresignedUrls(cloudStorage);
    
    // Do work here
});

async function getPresignedUrls(cloudStorage) {
    const now = new Date();
    const path = `/tmp/wknd-asset-compute/${now.getYear()}-${now.getMonth()}-${now.getDate()}/${uuidv4()}`;
    const expiry = 60000 * 2; // 2 minutes

    return {
        path: path, 
        get: cloudStorage.presignGet(path, expiry), 
        put: cloudStorage.presignPut(path, expiry) 
    };
}   
```

## Calling the Adobe I/O XXX API

Once the Cloud Storage is prepared, we need to set up the integration with the Adobe XXX APIs.

When calling the XXX API we will use self-composed HTTP requests using JavaScript fetch (and friends) modules. This is to help illustrate the types of interactions that can be made with any HTTP-based web api for manipulating images. Different Web services may have their own JavaScript SDK npm modules, or different access and return patterns, however this should give you a sense of how to construct custom workers for any API.

1. Before writing any code, review the API docs, to understand the API and what information we have to pass.

.... // TODO


1. Create a new function that invokes the Adobe XX APIs used to transform the source binary.

```javascript
async function invokeApi(clientId, accessToken, sourceUrl, presignedPutUrl) {
    
    const parameters = {
        'inputs': {
           // The presigned GET URL provided by Asset Compute to the source asset's binary
          'href': sourceUrl, 
          // Azure since our AEM as a Cloud Service is using Azure Blob Storage to house it's assets
          'storage': 'azure' 
        },
        'outputs': [ {
            // The temporary presigned PUT URL, the XX APIs will store the transformed asset here.
            'href': presignedPutUrl, 
            // Azure since were using Azure Blob storage to back the presigned PUT URL; Set this to 'external' if using Amazon S3
            'storage': 'azure', 
            // Defines the file format for output file the Adobe XX APIs should generate
            'type': 'image/jpeg'
        }]
      };

    // Invoke the XX APIs over HTTP, passing the parameters as JSON in the body and the Adobe I/O authentication as HTTP request headers.
    const response = await fetch('https://image.adobe.io/lrService/autoStraighten', {
        method: 'POST',
        body:    JSON.stringify(parameters),
        // Provide the headers required for this HTTP request to authenticate to the Adobe I/O Web service
        headers: { 
            'Content-Type': 'application/json', 
            // Pass in the Adobe I/O access token originating from `params.auth.accessToken`
            'authorization': 'Bearer ' + accessToken,
            // Pass in the Adobe I/O client Id originating from `params.auth.clientId`
            'x-api-key': clientId
        }
    });

    // The HTTP call to the XX APIs respond with a Job status.
    // Note that this API performs the work asynchronously and this API call runs the information for a Job, that can be polled for completion
    return await response.json();    
}
```

1. Call the new `invokeApi` function from the worker to invoke the Adobe XX API.

Since this is an Adobe I/O service, we use the [Adobe I/O Client Id and Access Token](https://docs.adobe.com/content/help/en/asset-compute/using/extend/develop-custom-application.html#access-adobe-apis) generated by AEM Author service to interact with other Adobe I/O integrations. 

Note that the Adobe I/O integrations must be added to the FireFly project's workspaces and reflected via metascopes in the project's `console.json` file.

```javascript
...
const response = await invokeApi(params.auth.clientId, params.auth.accessToken, source.url, presignedUrls.put);

// Do work here 
```

After the call to the Adobe XX API is invoked, a JSON response is returned describing the asynchronous Adobe XX API job created that will complete the transformation. The response contains a URL, at `response['_links'].self.href`, that's used to check if the job is complete and the rendition has been put into the presigned PUT URL location. 

Note that not all web services use this asynchronous processing pattern, so ensure you understand the contract with any APIs you integrate with and code against them accordingly. 

1. Poll the Adobe XX API for job completion

Next, poll the Adobe XX API using the URL provided in the initial API call's response to determine when the Adobe API has completed its work and the transformed binary can be retrieved.

Create a new function similar to the `invokeApi` that polls the Adobe I/O Web service for job status and returns it's status.

```javascript
async function pollForStatus(clientId, accessToken, statusUrl) {
    const response = await fetch(statusUrl, { 
        method: 'POST', 
        // Provide the Adobe I/O credentials, the same as w dont in the the HTTP request in `invokeApi`
        headers: { 
            'Content-Type': 'application/json', 
            'authorization': 'Bearer ' + accessToken,
            'x-api-key': clientId
        },
        // Use the retryOptions to poll
        retryOptions: {
            // Poll for 1 minute max
            retryMaxDuration: 60000,
            // Retry every 2 seconds (2000 ms)  
            retryInitalDelay: 2000,
            // Create a special retry handler function that only retries while the job is reported as 'pending'
            retryOnHttpResponse: async function (response) {
                const json = await response.json();
                // Continue to retry if the job is 'pending', otherwise (success or failure) top polling
                return json.outputs[0].status === 'pending';
            }
        } 
    });

    // Get the final response as JSON
    const json = await response.json();

    // Return the job status
    return json.outputs[0].status;
}
```

1. Call the new `pollForStatus` function from the worker to poll the Adobe I/O web service and obtain the final status of the job.

Similar to `invokeApi`, since this call it to an Adobe I/O service, we use the [Adobe I/O Client Id and Access Token](https://docs.adobe.com/content/help/en/asset-compute/using/extend/develop-custom-application.html#access-adobe-apis) generated by AEM Author service to authenticate to it.

```javascript
...
const status = await pollForStatus(params.auth.clientId, params.auth.accessToken, response['_links'].self.href);

if (status === 'succeeded') {
    // Victory! The job succeeded and the transformed binary was placed into the provided presigned PUT URL 
} else {
    // Shoot! Either the job failed or did not complete within the expected time (retryMaxDuration = 1 minute), so consider this a failure
}
```

1. Handle success

Upon success, the data writen to the presigned PUT URL must be commited before it can be read, and written back to AEM Author service. 

Once the data is commited to the cloud storage, it can be read via the presigned GET URL and written to the `rendition.path`, which the Asset Compute framework will in turn write back to AEM Author service as a rendition for the asset. This can be easily achieved using the `downloadFile` function provided by [@adobe/httptransfer] npm module.


```javascript
if (status === 'succeeded') {    
    // Commit the changes to the cloud storage written to via the presigned PUT URL so they are available for reading.
    await cloudStorage.commitPut(presignedUrls.path);

    // Copy the data at the presigned GET URL (used for reading the data) into the output rendition using the downloadFile library.
    // Once the bits have been copied to the `rendition.path` the Asset Compute framework will take care of the rest and ensure they show
    // up in AEM Author service as a rendition for the asset
    await downloadFile(presignedUrls.get, rendition.path);
} else {
    // Either the work failed or did not complete within the expected time (retryMaxDuration = 1 min), so consider this a fail state
}
```

1. Handle failure 

In the event the status is not successful, so still pending or a failure, throw the appropriate [Asset Compute error](https://github.com/adobe/asset-compute-commons#asset-compute-errors) to notify the AEM Author service of the failure.

```javascript
if (status === 'succeeded') {
    ...
} else {
    // Either the work failed or did not complete within the expected time (retryMaxDuration = 1 min), so consider this a fail state
    throw new GenericError("Unable to obtain rendition from Adobe XX API", "wknd-asset-compute");
}
```

## Final worker index.js

The final worker `index.js` should look like:

```javascript
'use strict';

const { worker, SourceCorruptError, GenericError } = require('@adobe/asset-compute-sdk');
const { CloudStorage } = require('@adobe/cloud-blobstore-wrapper');
const { v4: uuidv4 } = require('uuid');
const fetch = require('@adobe/node-fetch-retry');
const fs = require('fs').promises;

exports.main = worker(async (source, rendition, params) => {
    const stats = await fs.stat(source.path);
    if (stats.size === 0) {
        throw new SourceCorruptError('source file is empty');
    }

    const cloudStorage = new CloudStorage({
        accountName: params.cloudStorageId,
        accountKey: params.cloudStorageSecret
    },
    params.cloudStorageContainer);

    const presignedUrls = await getPresignedUrls(cloudStorage);

    const response = await invokeApi(params.auth.clientId, params.auth.accessToken, source.url, presignedUrls.put);

    const status = await pollForStatus(params.auth.clientId, params.auth.accessToken, response['_links'].self.href);

    if (status === 'succeeded') {
        await cloudStorage.commitPut(presignedUrls.path);
        await downloadFile(presignedUrls.get, rendition.path);
    } else {
        throw new GenericError("Unable to obtain rendition from Adobe I/O API", "wknd-asset-compute");
    }
});

/** Generate presigned GET and PUT URLs in the provided cloud storage **/
async function getPresignedUrls(cloudStorage) {
    const now = new Date();
    const path = `/tmp/wknd-asset-compute/${now.getYear()}-${now.getMonth()}-${now.getDate()}/${uuidv4()}`;
    const expiry = 60000 * 2; // 2 minutes

    return {
        path: path, 
        get: cloudStorage.presignGet(path, expiry), 
        put: cloudStorage.presignPut(path, expiry) 
    };
}   

/** Invokes the Adobe API via HTTP **/
async function invokeApi(clientId, accessToken, sourceUrl, presignedPutUrl) {
    const parameters = {
        'inputs': {
          'href': sourceUrl, 
          'storage': 'azure' 
        },
        'outputs': [ {
            'href': presignedPutUrl, 
            'storage': 'azure', 
            'type': 'image/jpeg'
        }]
      };

    const response = await fetch('https://image.adobe.io/lrService/autoStraighten', {
        method: 'POST',
        body:    JSON.stringify(parameters),
        headers: { 
            'Content-Type': 'application/json', 
            'authorization': 'Bearer ' + accessToken,
            'x-api-key': clientId
        }
    });

    return await response.json();    
}

/** Polls the Adobe API via HTTP for completion/failure/timeout **/
async function pollForStatus(clientId, accessToken, statusUrl) {
    const response = await fetch(statusUrl, { 
        method: 'POST',
        headers: { 
            'Content-Type': 'application/json', 
            'authorization': 'Bearer ' + accessToken,
            'x-api-key': clientId
        },
        retryOptions: {
            retryMaxDuration: 60000,
            retryInitalDelay: 2000,
            retryOnHttpResponse: async function (response) {
                const json = await response.json();
                return json.outputs[0].status === 'pending';
            }
        } 
    });

    const json = await response.json();

    return json.outputs[0].status;
}
```







## Asset Compute 
+ [Asset Compute Development Tool](https://github.com/adobe/asset-compute-devtool)
+ [Asset Compute Client](https://github.com/adobe/asset-compute-client)
+ [Asset Compute SDK](https://github.com/adobe/asset-compute-sdk)
+ [Asset Compute Commons](https://github.com/adobe/asset-compute-commons)
+ [Cloud Blobstore Wrapper Library](https://github.com/adobe/node-cloud-blobstore-wrapper)
+ [Adobe I/O Events API](https://www.adobe.io/apis/experienceplatform/events/ioeventsapi.html#!adobedocs/adobeio-events/master/events-api-reference.yaml)


https://www.adobe.io/apis/creativecloud/photo-imaging-api.html
https://github.com/AdobeDocs/photoshop-api-docs
https://adobedocs.github.io/photoshop-api-docs/#api-Photoshop-document_operations