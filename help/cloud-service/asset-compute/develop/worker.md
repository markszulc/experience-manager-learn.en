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
function customHelperFunctions() { ... }
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

In this worker, we will leverage the [image-js](https://www.npmjs.com/package/image-js) to create a rendition from the original image asset directly in Node.js code.

1. Open terminal in the root of your Asset Compute application project and execute the command:

```
$ npm install image-js
```

1. Next, import the `image-js` module into the worker code so it can be used via the `Image` JavaScript object. 
Update the `require` directives at the top of the worker's `index.js` to import the following:

 ```javascript
'use strict';

const { Image } = require('image-js');
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

## Read parameters

Asset Compute workers can read in parameters that can be passed in via Processing Profiles defined in AEM as a Cloud Service. The parameters are passed into the worker via the `rendition.instructions` object.

These can be read by simply accessing `rendition.instructions.<parameter name>` in the worker code.

```javascript
'use strict';

const { Image } = require('image-js'); 
const { worker, SourceCorruptError } = require('@adobe/asset-compute-sdk');
const fs = require('fs').promises;

exports.main = worker(async (source, rendition, params) => {
    const stats = await fs.stat(source.path);
    if (stats.size === 0) {
        throw new SourceCorruptError('source file is empty');
    }

    // Read in parameters and set defaults if parameters are provided
    const HEIGHT = rendition.instructions.height || 600;
    const WIDTH = rendition.instructions.width || 1280;
    const BLUR = rendition.instructions.blur || 30;

    // The rendition.instructions.name is the name the rendition will be saved as to AEM
    // and as typically a file name, such as `rendition.jpg`.
    // Parse the format from the rendition's extension.
    const FORMAT = rendition.instructions.name.substring(rendition.instructions.name.lastIndexOf('.') + 1);

    // Do work here
}
```

## Throwing errors

Asset Compute workers may encounter situations that result in errors. The Adobe Asset Compute SDK provides [a suite of predefined errors](https://github.com/adobe/asset-compute-commons#asset-compute-errors) that can be thrown when such situations are encountered. If no specific error type applies, the `GenericError` can be used.

Here we check to ensure the requested rendition format, derived previously from the rendition's name, is supported by the image processing npm module (`image-js`) used to creat the renditions.

```javascript
'use strict';

const { Image } = require('image-js'); 
// Import the `RenditionFormatUnsupportedError` type as this is thrown in the check below
const { worker, SourceCorruptError, RenditionFormatUnsupportedError } = require('@adobe/asset-compute-sdk');
const fs = require('fs').promises;

exports.main = worker(async (source, rendition, params) => {
    const stats = await fs.stat(source.path);
    if (stats.size === 0) {
        throw new SourceCorruptError('source file is empty');
    }

    const HEIGHT = rendition.instructions.height || 600;
    const WIDTH = rendition.instructions.width || 1280;
    const BLUR = rendition.instructions.blur || 30;
    const FORMAT = rendition.instructions.name.substring(rendition.instructions.name.lastIndexOf('.') + 1);

    // Ensure the target format is supported by the image transformation library (image-js)
    // and throw an error if the format is not supported.
    if (['jpg', 'png', 'bmp'].indexOf(FORMAT) === -1) {
        // Notice the `RenditionFormatUnsupportedError` is now imported above via the `@adobe/asset-compute-sdk` 
        // which proxies the errors in from '@adobe/asset-compute-commons`
        throw new RenditionFormatUnsupportedError(`Rendition format '${FORMAT}' is not supported`);
    }

    // Do work here
}
```

## Creating a rendition

With the workers parameters read, sanitized and validated, code can be written to generate the rendition. The pseudo code for the rendition generation is as follows:

1. Create a new "final" image canvas in the dimenstions specified via the `height` and `width` parameters.
1. Create a "main" image object from the source image and resize it to fit vertically into the "final" image.
1. Create a "background" image object from the source image and resize it so it covers the "final" image horizontally, and apply a blur effect specified via the `blur` parameter.
1. Insert and center the "background" image into the "final" image.
1. Insert and center the "main" image into the "final" image on top of the "background" image.
1. Write the composed, "final" image to `rendition.path` so it can saved back into AEM as an asset rendition.

## Finished worker index.js

The finished worker `index.js` should look like:

```javascript
'use strict';

const { Image } = require('image-js'); 
const { worker, SourceCorruptError, RenditionFormatUnsupportedError } = require('@adobe/asset-compute-sdk');
const fs = require('fs').promises;

exports.main = worker(async (source, rendition, params) => {
    const stats = await fs.stat(source.path);
    if (stats.size === 0) {
        throw new SourceCorruptError('source file is empty');
    }

    // Read in parameters and set defaults if parameters are provided
    const HEIGHT = rendition.instructions.height || 600;
    const WIDTH = rendition.instructions.width || 1280;
    const BLUR = rendition.instructions.blur || 30;

    // Parse the format from the rendition's extension
    const FORMAT = rendition.instructions.name.substring(rendition.instructions.name.lastIndexOf('.') + 1);

    // Ensure the target format is supported by the image transformation library
    if (['jpg', 'png', 'bmp'].indexOf(FORMAT) === -1) {
        throw new RenditionFormatUnsupportedError(`Rendition format '${FORMAT}' is not supported`);
    }

    // Create a new image object that will be sent back as the rendition
    const final = new Image(WIDTH, HEIGHT);

    // Read the source asset into an Image object and resize it
    let main = (await Image.load(source.path)).resize({ height: HEIGHT });

    // Read the source asset into an Image object and resize it, and apply a blur 
    let background = (await Image.load(source.path)).resize({ width: WIDTH }).gaussianFilter({ radius: BLUR });
    
    // Insert the background image into the final image
    final.insert(background, { x: 0, y: getBackgroundYCoordinate(background, final), inPlace: true });
    
    // Insert the main image into the final image
    final.insert(main, { x: getMainXCoordinate(main, final), y: 0, inPlace: true});

    // Save the final image (composed of the blurred background image, and centered main image) to the rendition
    await final.save(rendition.path, { format: FORMAT });
});

function getBackgroundYCoordinate(background, final) {
    if (background.height > final.height) {
        // The background image is taller than the final image 
        // So, shift the background image Y insertion coordinate up image up so it is centered in the final image
        return -1 * ((background.height -  final.height) / 2);
    } else {
        return 0;
    }
}

function getMainXCoordinate(main, final) {
    // Compute the X insertion coordinate so it is centered horizontally in the final image
    return (final.width / 2) - (main.width / 2);
}
```

## Running the worker

Now that the worker code is complete, and it is registered and configured in the [manifest.yml](todo), it can be executed using the local Asset Compute Dev Tool to see the results.

1. In a new terminal window, navigate to the root of your Asset Compute project
1. Execute `app aio run`
1. Wait for Asset Compute Dev Tool to open in a new window
1. 








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