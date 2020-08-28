
# Develop an Asset Compute worker

Asset Compute workers are the core of an Asset Compute application as they are what provide the custom functionality that performs or orchestrates the work performed on an asset to create a new rendition.

The Asset Compute project auto-generates a simple worker that simply copies the asset's original binary into a named rendition, without any transformations. We could modify this worker implementation with our custom logic, but instead, we'll create a brand new worker so it's clear how brand new workers can be defined and registered for use within a single project.


## Understanding how an Asset Compute worker orchestrates work

Asset Compute workers most often rely on external web services to perform that actual renditioning of an assets, and merely act as an orchestrator of the work to be done.

![TODO]()


1. When an Asset Compute worker is invoked from AEM Author service, it is against an AEM asset via a Processing Profile. The asset's original binary is passed to the worker via rendition callback function's `source` parameter, and any parameters defined in the Processing Profile, via the optional `params` parameter.
1. The Asset Compute worker creates presigned PUT and GET URLs in the configured cloud storage (Azure Blob Storage or Amazon S3). This is a protected, but internet-available end-point both the Asset Compute worker and any asset processing web service can access and will be used as a location the asset processing web service can write the transformed rendition binary back to.
1. The worker makes a HTTP call to the Web service, providing the presigned GET url to the assets original binary, available via `source.url` , and the presigned PUT (meaining it can be written to) URL generated in Step 2.
1. Upon invoking the Web service's API, the original rendition's binary is retrieved by the Web service via the presigned `source.url` and the Web service performs the requested computations and transformations on it, generating the rendition.
1. The Web service saves the rendition to the presigned PUT URL in cloud storage, so the worker can retrieve it.
1. Upon completion, the worker is notified of completion (usually by polling the Web service since it doesnt have a public HTTP end-point), and then, the worker copies the rendition stored at the in the Cloud storage, into the rendition in AEM Author service.
1. 


## Anatomy of a worker

Workers follow the same basic structure and input/output contract.

    ```javascript
'use strict';

const { worker, SourceCorruptError } = require('@adobe/asset-compute-sdk');
const fs = require('fs').promises;

exports.main = worker(async (source, rendition, params) => {
    // Example of how to throw a standard asset compute error
    // if e.g. the file is empty or broken.
    const stats = await fs.stat(source.path);
    if (stats.size === 0) {
        throw new SourceCorruptError('source file is empty');
    }

    // Working with sources and renditions happens through local files,
    // downloading and uploading is handled by the asset-compute-sdk.
    // In this example, simply copy source 1:1 to rendition:
    await fs.copyFile(source.path, rendition.path);

    // Tip: custom worker parameters are available in rendition.instructions
});

function customHelperFunction() { ... }
```

1. __Line 3-4:__ Imports the code Asset Compute SDK libraries, and any other [npm modules](https://www.npmjs.com/) required by this worker.
1. __Line 6:__ Exports the worker defined by a custom rendition callback function, which parameterizes the input/output contract for the worker.
    + `source` represents the asset's original binary used as the input for the worker.
    + `rendition` represents the worker's output, which is the creation of a new asset rendition.
    + `params` are optional parameters, which map to additional key/value pairs, including a sub `auth` object that contians Adobe I/O access credentials.
1. __Lines 7-17:__ Implements the custom work to be performed and is where the bulk od the custom code is written.
    + __Line 15__: Non-erring conditions in workers should always end with copying some data into the rendition, as a new rendition is a the expected output of asset compute workers.
1. __Line 19+:__ Create helper functions the worker's rendition callback function invokes to help organize code.

## Creating a new worker

Ensure the Asset Compute project is open in VS Code.

1. Navigate to the `/actions` folder.
1. Create a new folder under `/actions` named `auto-straighten`. This folder will contain the new worker, so name it semantically based on what the worker does.
1. In the newly created `/actions/auto-straighten` folder, create a file named `index.js`. 
1. Copy the following code into `/actions/auto-straighten/index.js`. This content can alternatively be copied from the generated worker at `/actions/worker/index.js`. 

    ```javascript
    'use strict';

    const { worker, SourceCorruptError } = require('@adobe/asset-compute-sdk');
    const fs = require('fs').promises;

    exports.main = worker(async (source, rendition, params) => {
        // Example of how to throw a standard asset compute error
        // if e.g. the file is empty or broken.
        const stats = await fs.stat(source.path);
        if (stats.size === 0) {
            throw new SourceCorruptError('source file is empty');
        }

        // Working with sources and renditions happens through local files,
        // downloading and uploading is handled by the asset-compute-sdk.
        // In this example, simply copy source 1:1 to rendition:
        await fs.copyFile(source.path, rendition.path);

        // Tip: custom worker parameters are available in rendition.instructions
    });
    ```
1. The first thing to do is to initialize the cloud storage with presigned .

## Setting up cloud storage

One of the first things we need to do is create presigned PUT and GET URLs that will be used to share tne rendition back to the worker. We'll use Azure Blob storage, but Amazon S3 can used following similar APIs calls.

Adobe provides a the `@adobe/cloud-blobstore-wrapper` [npm module](https://www.npmjs.com/package/@adobe/cloud-blobstore-wrapper) that can be used to generate presigned URLs for Azure Blob Storage and Amazon S3 cloud storage.

1. Install the `@adobe/cloud-blobstore-wrapper` in your project, by running the following command in the root of the Asset Compute project from the terminal:

    `$ npm install @adobe/cloud-blobstore-wrapper`
    
1. Once this npm module is installed, import it into your worker exporting the `CloudStorage` object.

```javascript
'use strict';

const { CloudStorage } = require('@adobe/cloud-blobstore-wrapper');
const { worker, SourceCorruptError } = require('@adobe/asset-compute-sdk');
const fs = require('fs').promises;
...
```

This makes the API available to the worker via the `CloudStorage` object.

1. 

```javascript
'use strict';

const { v4: uuidv4 } = require('uuid');
const { CloudStorage } = require('@adobe/cloud-blobstore-wrapper');
const { worker, SourceCorruptError } = require('@adobe/asset-compute-sdk');
const fs = require('fs').promises;
...
```

1. Initialize a new CloudStorage object with your cloud storage credentials. We'll hardcode these in code for now, but will explore to how extract them from the code base later.

The following signature is used for Azure Blob Storage:

```javascript
...
const cloudStorage = new CloudStorage({
        accountName: azureAccountName,
        accountKey: azureAccountKey
    },
    azureStorageContainerName);
...
```    

The following signature is used for Amazon S3:

```javascript
...
const cloudStorage = new CloudStorage({
        accessKeyId: awsAccessKeyId,
        secretAccessKey: awsSecretAccessKey
    },
    awsStorageContainerName);
```

1. Next, create a function that generates the presigned GET and PUT urls in the cloud storage.

```javascript
async function getPresignedUrls(cloudStorage) {
    const now = new Date();
    const path = `/adobe-lightroom/tmp/${now.getYear()}-${now.getMonth()}-${now.getDate()}/${uuidv4()}`;
    const expiry = 60000; 

    return {
        path: path,
        get: cloudStorage.presignGet(path, expiry),
        put: cloudStorage.presignPut(path, expiry)
    }
}   
```

 + __Line 1:__ Defines an `async` function that takes the configured `cloudStorage` object as a parameter.
 + __Line 2-3:__ Generates a unique path in the cloud storage using the current date and `uuid`. It's good to provide some logical organization to the temporary storage to aid in potential troubelshooting and clean-up.
 + __Line 4:__ Sets an expiry for the presigned URLs. Ensure when setting the expiry it affords enough time for whatever process creating the rendition to complete its work.
 + __Line 6-10:__ Return an object that contains:
    + __Line 7:__ the unique path in the cloud storage the presigned URLs will point at.
    + __Line 8:__ A presigned GET URL to the cloud storage path allowing anyone holding this URL to read the contents at the path. This worker will use the GET URL later to download the transformed rendition binary.
    + __Line 9:__ A presigned PUT URL to the cloud storage path allowing anyone holding this URL to read the contents at the path. Adobe I/O  web site will use the PUT URL later to save the transformed rendition binary.


1. Back in the rendition callback function of the worker, perform an awaiting call to the `getPresignedUrls(...)` to generate the presigned URLs.

```javascript
    const presignedUrls = await getPresignedUrls(cloudStorage);
```


1. At this point your index.js should look like:

    ```javascript
    'use strict';

    const { v4: uuidv4 } = require('uuid');
    const { CloudStorage } = require('@adobe/cloud-blobstore-wrapper');
    const { worker, SourceCorruptError } = require('@adobe/asset-compute-sdk');
    const fs = require('fs').promises;

    exports.main = worker(async (source, rendition, params) => {
        // Example of how to throw a standard asset compute error
        // if e.g. the file is empty or broken.
        const stats = await fs.stat(source.path);
        if (stats.size === 0) {
            throw new SourceCorruptError('source file is empty');
        }

        const cloudStorage = new CloudStorage({
            accountName: 'aemguideswkndassetcomput',
            accountKey: 'xxx'
        },
        'asset-compute');

        const presignedUrls = await getPresignedUrls(cloudStorage);

        // Working with sources and renditions happens through local files,
        // downloading and uploading is handled by the asset-compute-sdk.
        // In this example, simply copy source 1:1 to rendition:
        await fs.copyFile(source.path, rendition.path);

        // Tip: custom worker parameters are available in rendition.instructions
    });

    // Generate presigned temporary GET and PUT URLs 
    async function getPresignedUrls(cloudStorage) {
        const now = new Date();
        const path = `/adobe-lightroom/tmp/${now.getYear()}-${now.getMonth()}-${now.getDate()}/${uuidv4()}`;
        const expiry = 60000; 

        return {
            path: path,
            get: cloudStorage.presignGet(path, expiry),
            put: cloudStorage.presignPut(path, expiry)
        }
    } 
    ```

## Calling the Adobe I/O XXX API

Once the Cloud Storage is prepared, we need to set up the integration with the Adobe XXX APIs.

When calling the XXX API we will use self-composed HTTP requests using JavaScript fetch (and friends) modules. This is to help illustrate the types of interactions that can be made with any HTTP-based web api for manipulating images. Different Web services may have their own JavaScript SDK npm modules, or different access and return patterns, however this should give you a sense of how to construct custom workers for any API.

1. Before writing any code, review the API docs, to understand the API and what information we have to pass.

.... // TODO


1. Install the @adobe/node-fetch-retry npm module

Since we are communicating over HTTP with the Adobe XX API we need to make an HTTP call from our Asset Compute worker. 

To do this, we'll use the [https://www.npmjs.com/package/@adobe/node-fetch-retry](@adobe/node-fetch-retry) npm module. The retry capability will be necessary later when we poll to determine when the Adobe XX API has finished processing the asset.

```shell
$ npm install @adobe/node-fetch-retry
```

1. Import the fecth object

```

```

1. Next create a new function that will invoke the Adobe XX APIs.

```javascript
async function autoStraighten(clientId, accessToken, sourceUrl, presignedPutUrl) {
    
    const parameters = {
        'inputs': {
          'href': sourceUrl, // The presigned GET URL provided by Asset Compute to the source asset's binary
          'storage': 'azure' // Azure since our AEM as a Cloud Service is using Azure Blob Storage to house it's assets
        },
        'outputs': [ {
            'href': presignedPutUrl, // The temporary presigned PUT URL, the XX APIs will store the transformed asset here.
            'storage': 'azure', // Azure since were using Azure Blob storage to back the presigned PUT URL
            'type': 'image/jpeg', // Defines the file format for output file the XX APIs should generate
            'overwrite': true // 
        }]
      };

    // Invoke the XX APIs over HTTP, passing the parameters as JSON in the body and the Adobe I/O authentication as HTTP request headers.
    const response = await fetch('https://image.adobe.io/lrService/autoStraighten', {
        method: 'post',
        body:    JSON.stringify(parameters),
        headers: { 
            'Content-Type': 'application/json', 
            'authorization': 'Bearer ' + accessToken,
            'x-api-key': clientId
        }
    });

    // The HTTP call to the XX APIs respond with a Job status.
    // Note that this API performs the work asynchronously and this API call runs the information for a Job, that can be polled for completion
    return await response.json();    
}
```

1. Call the new `autoStraighten` function from the worker to invoke the Adobe XX API.

Since this is an Adobe I/O service, we use the Adobe I/O Client Id and Access Token generated by AEM Author service and used to communicate with Asset Compute microservices to allow our worker to interact with futher Adobe I/O integrations. 

Note that these integrations must be added to the FireFly project workspaces this worker will be deployed to. 

```javascript
...
const response = await autoStraighten(params.auth.clientId, params.auth.accessToken, source.url, presignedUrls.put);
```

After the call to the Adobe XX API is invoked, a JSON esponse is returned describing the asynchronous Adobe XX API job created that will complete the transformation. The response contains a URL, at `response['_links'].self.href`, that's used to check if the job is complete and the rendition has been put into the presigned PUT URL location. 

Note that not all web services use this asynchronous processing pattern, so ensure you understand the contract with any APIs you integrate with and code against them accordingly. 


1. Poll the Adobe XX API for job completion

Next, poll the Adobe XX API using the URL provided in the initial API call's response to determine when the Adobe API has completed its work. 


```javascript
...
const statusResponse = await fetch(response['_links'].self.href, { 
    method: 'POST' 
    retryOptions: {
        retryMaxDuration: 60000,  // 1 minute retry max duration
        retryInitalDelay: 2000, // Retry every 2 seconds
        retryOnHttpResponse: function (response) {
            const json = await response.json();
            return json.outputs[0].status === 'pending'; // Retry while the job is pending
        }
    } 
});

// Collect the status of the job
const status = json.outputs[0].status;

if (status === 'succeeded') {
    // Victory! The work completed and the transformed image was placed into the provided presigned PUT URL 
} else {
    // Either the work failed or did not complete within the expected time (retryMaxDuration = 1 min), so consider this a fail state
}
```

1. Handle the success case

```javascript
if (status === 'succeeded') {
    // Victory! The work completed and the transformed image was placed into the provided presigned PUT URL 
    
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


1. Handle the unsuccessful case

```javascript
if (status === 'succeeded') {
    // Victory! The work completed and the transformed image was placed into the provided presigned PUT URL 
    ...
} else {
    // Either the work failed or did not complete within the expected time (retryMaxDuration = 1 min), so consider this a fail state
    throw new GenericError("Unable to obtain rendition from Adobe XX API", "WKND Asset Compute");
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