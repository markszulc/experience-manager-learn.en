
# Develop an Asset Compute worker

Asset Compute workers are the core of an Asset Compute application as they are what provide the custom functionality that performs or orchestrates the work performed on an asset to create a new rendition.

The Asset Compute project auto-generates a simple worker that simply copies the asset's original binary into a named rendition, without any transformations. We could modify this worker implementation with our custom logic, but instead, we'll create a brand new worker so it's clear how brand new workers can be defined and registered for use within a single project.


## Understanding how an Asset Compute worker orchestrates work

Asset Compute workers most often rely on external web services to perform that actual renditioning of an assets, and merely act as an orchestrator of the work to be done.






1. When an Asset Compute worker is invoked from AEM Author service, it is against an AEM asset via a Processing Profile. The asset's original binary is passed to the worker via rendition callback function's `source` parameter, and any parameters defined in the Processing Profile, via the optional `params` parameter.
1. The Asset Compute worker creates pre-signed PUT and GET URLs in the configured cloud storage (Azure Blob Storage or Amazon S3). This is a protected, but internet-available end-point both the Asset Compute worker and any asset processing web service can access and will be used as a location the asset processing web service can write the transformed rendition binary back to.
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
    ```

1. __Line 3-4:__ Imports the code Asset Compute SDK libraries, and any other [npm modules](https://www.npmjs.com/) required by this worker.
1. __Line 6:__ Exports the worker defined by a custom rendition callback function, which parameterizes the input/output contract for the worker.
    + `source` represents the asset's original binary used as the input for the worker.
    + `rendition` represents the worker's output, which is the creation of a new asset rendition.
    + `params` are optional parameters, which map to additional key/valye pairs.
1. __Lines 7-17:__ Implements the custom work to be performed and is where the bulk od the custom code is written.
    + __Line 15__: Non-erring conditions in workers should always end with copying some data into the rendition, as a new rendition is a the expected output of asset compute workers.

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
1. The first thing to do is to initialize the cloud storage with pre-signed .

## Setting up cloud storage

One of the first things we need to do is create pre-signed PUT and GET URLs that will be used to share tne rendition back to the worker. We'll use Azure Blob storage, but Amazon S3 can used following similar APIs calls.

Adobe provides a the `@adobe/cloud-blobstore-wrapper` npm module that can be used to generate pre-signed URLs.

1. Install the `@adobe/cloud-blobstore-wrapper` in your project, by running the following command in the root of the Asset Compute project from the terminal:

    `npm install @adobe/cloud-blobstore-wrapper`
    
1. Once this npm module is installed, it can be used in the worker, by adding as an require import statement.

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


```javascript
    const cloudStorage = new CloudStorage({
        accountName: 'aemguideswkndassetcomput',
        accountKey: 'xxx'
    },
    'asset-compute');
```    



1. Next, create a function that generates the presigned GET and PUT urls in the cloud storage.

```javascript
async function getPresignedUrls(cloudStorage) {
    const uniquePath = 'tmp/' + uuidv4();
    const expiry = 60000; 

    return {
        path: uniquePath,
        get: cloudStorage.presignGet(uniquePath, expiry),
        put: cloudStorage.presignPut(uniquePath, expiry)
    }
}   
```

 + __Line 1:__ Defines an `async` function that takes the configured `cloudStorage` object as a parameter.
 + __Line 2:__ Generates a unique path in the cloud storage using the `uuid` npm module.
 + __Line 3:__ Sets an expiry for the presigned URLs. Ensure when setting the expiry it affords enough time for whatever process creating the rendition to complete its work.
 + __Line 5-9:__ Return an object that contains:
    + __Line 6:__ the unique path in the cloud storage the pre-signed URLs will point at.
    + __Line 7:__ A pre-signed GET URL to the cloud storage path allowing anyone holding this URL to read the contents at the path. This worker will use the GET URL later to download the transformed rendition binary.
    + __Line 8:__ A pre-signed PUT URL to the cloud storage path allowing anyone holding this URL to read the contents at the path. Adobe I/O  web site will use the PUT URL later to save the transformed rendition binary.


1. Back in the rendition callback function of the worker, perform an awaiting call to the `getPresignedUrls(...)` to generate all the pre-signed URLs.

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

    // Generate Pre-signed temporary GET and PUT URLs 
    async function getPresignedUrls(cloudStorage) {
        const uniquePath = 'tmp/' + uuidv4();
        const expiry = 60000; 

        return {
            path: uniquePath,
            get: cloudStorage.presignGet(uniquePath, expiry),
            put: cloudStorage.presignPut(uniquePath, expiry)
        }
    }   

    ```



## Invoking Adobe I/O Services



## Asset Compute 
+ [Asset Compute Development Tool](https://github.com/adobe/asset-compute-devtool)
+ [Asset Compute Client](https://github.com/adobe/asset-compute-client)
+ [Asset Compute SDK](https://github.com/adobe/asset-compute-sdk)
+ [Asset Compute Commons](https://github.com/adobe/asset-compute-commons)
+ [Cloud Blobstore Wrapper Library](https://github.com/adobe/node-cloud-blobstore-wrapper)
+ [Adobe I/O Events API](https://www.adobe.io/apis/experienceplatform/events/ioeventsapi.html#!adobedocs/adobeio-events/master/events-api-reference.yaml)