---
title: Develop an Asset Compute worker
description: Asset Compute workers are the core of an Asset Compute projects as provide custom functionality that performs, or orchestrates, the work performed on an asset to create a new rendition.
feature: asset-compute
topics: renditions, development
version: cloud-service
activity: develop
audience: developer
doc-type: tutorial
kt: 6282
thumbnail: KT-6282.jpg
---

# Develop an Asset Compute worker

Asset Compute workers are the core of an Asset Compute project as provide custom functionality that performs, or orchestrates, the work performed on an asset to create a new rendition.

The Asset Compute project auto-generates a simple worker that copies the asset's original binary into a named rendition, without any transformations. In this tutorial we'll modify this worker to make a more interesting rendition, to illustrate the power of Asset Compute workers.

 We will create an Asset Compute worker that generates a new horizontal image rendition, that covers empty space to the left and right of the asset rendition with a blurred version of the asset. The width, height and blur of the final rendition will be parameterized.

## Logical flow of an Asset Compute worker invocation

Asset Compute workers implement the Asset Compute SDK worker API contract, in the `renditionCallback(...)` function, which is conceptually:

+ __Input:__ An AEM asset's original asset binary and parameters
+ __Output:__ One or more renditions to be added to the AEM asset

![Asset Compute worker logical flow](./assets/worker/logical-flow.png)

1. When an Asset Compute worker is invoked from AEM Author service, it is against an AEM asset via a Processing Profile. The asset's __(1a)__ original binary is passed to the worker via rendition callback function's `source` parameter, and __(1b)__ any parameters defined in the Processing Profile via `rendition.instructions` parameter set.
1. The Asset Compute SDK layer accepts the request from the processing profile, and orchestrates the execution of the custom Asset Compute worker's `renditionCallback(...)` function, transforming the source binary provided in __(1a)__ based on any parameters provided by __(1b)__ to generate a rendition of the source binary.
    + In this tutorial the rendition is created "in process", meaning the worker composes the rendition, however the source binary can be sent to other Web service APIs for rendition generation as well.
1. The Asset Compute worker saves the rendition's binary representation to `rendition.path` which makes it available to be saved into the AEM Author service.
1. Upon completion, the binary data written to `rendition.path` is transported via the Asset Compute SDK and exposed via the AEM Author Service as a rendition available in the AEM UI.

The above diagram articulates the Asset Compute developer-facing concerns and logical flow ot Asset Compute worker invocation. For the curious, the [internal details of Asset Compute execution](https://docs.adobe.com/content/help/en/asset-compute/using/extend/custom-application-internals.html) are available, however only the public Asset Compute SDK API contracts should be depended upon.

## Anatomy of a worker

All Asset Compute workers follow the same basic structure and input/output contract.

```javascript
'use strict';

// Any npm module imports used by the worker
const { worker, SourceCorruptError } = require('@adobe/asset-compute-sdk');
const fs = require('fs').promises;

/**
Exports the worker implemented by a custom rendition callback function, which parametrizes the input/output contract for the worker.
 + `source` represents the asset's original binary used as the input for the worker.
 + `rendition` represents the worker's output, which is the creation of a new asset rendition.
 + `params` are optional parameters, which map to additional key/value pairs, including a sub `auth` object that contains Adobe I/O access credentials.
**/
exports.main = worker(async (source, rendition, params) => {
    // Perform any necessary source (input) checks
    const stats = await fs.stat(source.path);
    if (stats.size === 0) {
        // Throw appropriate errors whenever an erring condition is met
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
Optionally create helper classes or functions the worker's rendition callback function invokes to help organize code.

Code shared across workers, or to complex to be managed in a single file, can be broken out across supporting JavaScript files in the project and imported normally into the worker. 
**/
function customHelperFunctions() { ... }
```

## Opening the worker index.js

![Auto-generated index.js](./assets/worker/autogenerated-index-js.png)

1. Ensure the Asset Compute project is open in VS Code
1. Navigate to the `/actions/worker` folder
1. Open the `index.js` file

This is the worker JavaScript file we will modify in this tutorial.

## Install and import supporting npm modules

Being Node.js based, Asset Compute projects benefit from the robust [npm module ecosystem](https://npmjs.com). To leverage npm modules we must first install them into our Asset Compute project.

In this worker, we leverage the [jimp](https://www.npmjs.com/package/jimp) to create and manipulate the rendition image directly in the Node.js code.

>[!WARNING]
>
>Not all npm modules for asset manipulation are supported by Asset Compute. npm modules that rely on the existing of other applications such as ImageMagick or OS-dependent libraries. It is best to limit to the use of JavaScript-only npm modules.

1. Open the command line in the root of your Asset Compute project (this can be done in VS Code via __Terminal > New Terminal__) and execute the command:

    ```
    $ npm install jimp
    ```

1. Import the `jimp` module into the worker code so it can be used via the `Jimp` JavaScript object. 
Update the `require` directives at the top of the worker's `index.js` to import the `Jimp` object from the `jimp` module:

    ```javascript
    'use strict';

    const { Jimp } = require('jimp');
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

Asset Compute workers can read in parameters that can be passed in via Processing Profiles defined in AEM as a Cloud Service Author service. The parameters are passed into the worker via the `rendition.instructions` object.

These can be read by accessing `rendition.instructions.<parameterName>` in the worker code.

Here we'll read in the configurable rendition's `SIZE`, `BRIGHTNESS` and `CONTRAST`, providing default values if none have been provided via the Processing Profile. Note that `renditions.instructions` are passed in as strings when invoked from AEM as a Cloud Service Processing Profiles, so ensure they are transformed into the correct data types in the worker code.

```javascript
'use strict';

const { Jimp } = require('jimp');
const { worker, SourceCorruptError } = require('@adobe/asset-compute-sdk');
const fs = require('fs').promises;

exports.main = worker(async (source, rendition, params) => {
    const stats = await fs.stat(source.path);
    if (stats.size === 0) {
        throw new SourceCorruptError('source file is empty');
    }

    // Read in parameters and set defaults if parameters are provided
    // Processing Profiles pass in instructions as Strings, so make sure to parse to correct data types
    const SIZE = parseInt(rendition.instructions.size) || 800; 
    const CONTRAST = parseFloat(rendition.instructions.contrast) || 0;
    const BRIGHTNESS = parseFloat(rendition.instructions.brightness) || 0;

    // Do work here
}
```

## Throwing errors{#errors}

Asset Compute workers may encounter situations that result in errors. The Adobe Asset Compute SDK provides [a suite of predefined errors](https://github.com/adobe/asset-compute-commons#asset-compute-errors) that can be thrown when such situations are encountered. If no specific error type applies, the `GenericError` can be used, or specific custom `ClientErrors` can be defined.

Before starting to process the rendition, check to ensure all the parameters are valid and supported in the context of this worker:

+ Ensure the rendition instruction parameters for `SIZE`, `CONTRAST`, and `BRIGHTNESS` are valid. If not, throw a custom error `RenditionInstructionsError`.
    + A custom `RenditionInstructionsError` class that extends `ClientError` is defined at the bottom of this file. The use of a specific, custom error is useful when [writing tests](../test-debug/test.md) for the worker.

```javascript
'use strict';

const { Jimp } = require('jimp');
// Import the Asset Compute SDK provided `ClientError` 
const { worker, SourceCorruptError, ClientError } = require('@adobe/asset-compute-sdk');
const fs = require('fs').promises;

exports.main = worker(async (source, rendition, params) => {
    const stats = await fs.stat(source.path);
    if (stats.size === 0) {
        throw new SourceCorruptError('source file is empty');
    }

    // Read in parameters and set defaults if parameters are provided
    const SIZE = parseInt(rendition.instructions.size) || 800; 
    const CONTRAST = parseFloat(rendition.instructions.contrast) || 0;
    const BRIGHTNESS = parseFloat(rendition.instructions.brightness) || 0;

    if (SIZE <= 10 || SIZE >= 10000) {
        // Ensure size is within allowable bounds
        throw new RenditionInstructionsError("'size' must be between 10 and 1,0000");
    } else if (CONTRAST <= -1 || CONTRAST >= 1) {
        // Ensure contrast is valid value
        throw new RenditionInstructionsError("'contrast' must between -1 and 1");
    } else if (BRIGHTNESS <= -1 || BRIGHTNESS >= 1) {
        // Ensure contrast is valid value
        throw new RenditionInstructionsError("'brightness' must between -1 and 1");
    }

    // Do work here
}

// Create a new ClientError to handle invalid rendition.instructions values
class RenditionInstructionsError extends ClientError {
    constructor(message) {
        // Provide a:
        // + message: describing the nature of this erring condition
        // + name: the name of the error; usually same as class name
        // + reason: a short, searchable, unique error token that identifies this error
        super(message, "RenditionInstructionsError", "rendition_instructions_error");

        // Capture the strack trace
        Error.captureStackTrace(this, RenditionInstructionsError);
    }
}
```

## Creating the rendition

With the parameters read, sanitized and validated, code is written to generate the rendition. The pseudo code for the rendition generation is as follows:

1. Create a new `renditionImage` canvas in square dimensions specified via the `size` parameter.
1. Create a `image` object from the source asset's binary
1. Use the __Jimp__ library to transform the image:
    + Crop the original image to a centered square
    + Cut a circle from the center of the "squared" image
    + Scale to fit within the dimensions defined by the `SIZE` parameter value
    + Adjust contrast based on the `CONTRAST` parameter value
    + Adjust brightness based on the `BRIGHTNESS` parameter value
1. Place the transformed `image` into the center of the `renditionImage` which has a transparent background
1. Write the composed, `renditionImage` to `rendition.path` so it can saved back into AEM as an asset rendition.

This code employs the [Jimp APIs](https://github.com/oliver-moran/jimp#jimp) to perform these image transformations.

Asset Compute workers must finish their work synchronously, and the `rendition.path` must be fully written back to before the worker's `renditionCallback` completes. This requires that asynchronous functions calls are made synchronous using the `await` operator. If you are not familiar with JavaScript asynchronous functions and how to have them execute in a synchronous manner, familiarize yourself with [JavaScript's await operator](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/await).

The finished worker `index.js` should look like:

```javascript
'use strict';

const Jimp = require('jimp');
const { worker, SourceCorruptError, ClientError } = require('@adobe/asset-compute-sdk');
const fs = require('fs').promises;

exports.main = worker(async (source, rendition, params) => {
    const stats = await fs.stat(source.path);
    if (stats.size === 0) {
        throw new SourceCorruptError('source file is empty');
    }

    const SIZE = parseInt(rendition.instructions.size) || 800; 
    const CONTRAST = parseFloat(rendition.instructions.contrast) || 0;
    const BRIGHTNESS = parseFloat(rendition.instructions.brightness) || 0;

    if (SIZE <= 10 || SIZE >= 10000) {
        throw new RenditionInstructionsError("'size' must be between 10 and 10,000");
    } else if (CONTRAST <= -1 || CONTRAST >= 1) {
        throw new RenditionInstructionsError("'contrast' must between -1 and 1");
    } else if (BRIGHTNESS <= -1 || BRIGHTNESS >= 1) {
        throw new RenditionInstructionsError("'brightness' must between -1 and 1");
    }

    // Create target rendition image of the target size with a transparent background (0x0)
    let renditionImage =  new Jimp(SIZE, SIZE, 0x0);

    // Read and perform transformations on the source binary image
    let image = await Jimp.read(source.path);

    // Crop a circle from the source asset, and then apply contrast and brightness using Jimp
    image.crop(
            image.bitmap.width < image.bitmap.height ? 0 : (image.bitmap.width - image.bitmap.height) / 2,
            image.bitmap.width < image.bitmap.height ? (image.bitmap.height - image.bitmap.width) / 2 : 0,
            image.bitmap.width < image.bitmap.height ? image.bitmap.width : image.bitmap.height,
            image.bitmap.width < image.bitmap.height ? image.bitmap.width : image.bitmap.height
        )   
        .circle()
        .scaleToFit(SIZE, SIZE)
        .contrast(CONTRAST)
        .brightness(BRIGHTNESS);

    // Place the transformed image onto the transparent renditionImage to save as PNG
    renditionImage.composite(image, 0, 0)

    // Write the final transformed image to the asset's rendition
    renditionImage.write(rendition.path);
});

// Custom error used for renditions.instructions parameter checking
class RenditionInstructionsError extends ClientError {
    constructor(message) {
        super(message, "RenditionInstructionsError", "rendition_instructions_error");
        Error.captureStackTrace(this, RenditionInstructionsError);
    }
}
```

## Running the worker

Now that the worker code is complete, and was previously registered and configured in the [manifest.yml](./manifest.md), it can be executed using the local Asset Compute Development Tool to see the results.

1. From the root of the Asset Compute project
1. Execute `app aio run`
1. Wait for Asset Compute Development Tool to open in a new window
1. In the __Select a file...__ drop down, select a sample image to process
    + Select a sample image file to use as the source asset binary
    + If none exist yet, tap the __(+)__ to the left, and upload a [sample image](../assets/samples/sample-file.jpg) file, and refresh the Development Tools browser window
1. Update `"name": "rendition.png"` as this worker to generates a transparent PNG. 
    + Note this "name" parameter is only used for the Development Tool, and should not relied on.

    ```json
    {
        "renditions": [
            {
                "worker": "...",
                "name": "rendition.png"
            }
        ]
    }
    ```
1. Tap __Run__ and wait for the rendition to generate
1. The __Renditions__ section previews the generated rendition. Tap the rendition preview to download the full rendition

    ![Default PNG rendition](./assets/worker/default-rendition.png) 

### Run the worker with parameters

Parameters, passed in via Processing Profile configurations, can be simulated in Asset Compute Development Tools by providing them as key/value pairs on the rendition parameter JSON.

>[!WARNING]
>
>During local development, values can be passed in using various data types, when passed in from AEM as Cloud Service Processing Profiles as strings, so make sure the correct data types are parsed if needed. 
> For example, Jimp's `crop(width, height)` function requires its parameters to be `int`'s. If `parseInt(rendition.instructions.size)` is not parsed to an int, then the call to `jimp.crop(SIZE, SIZE)` will fail as the parameters will be incompatible 'String' type.

Our code accepts parameters for:

+ `size` defines the size of the rendition (height and width as integers)
+ `contrast` defines the contrast adjust, must be between -1 and 1, as floats
+ `brightness`  defines the bright adjust, must be between -1 and 1, as floats

These are read in the worker `index.js` via:

+ `const SIZE = parseInt(rendition.instructions.size) || 800`
+ `const CONTRAST = parseFloat(rendition.instructions.contrast) || 0`
+ `const BRIGHTNESS = parseFloat(rendition.instructions.brightness) || 0`

1. Update the rendition parameters to customize the size, contrast and brightness.

    ```json
    {
        "renditions": [
            {
                "worker": "...",
                "name": "rendition.png",
                "size": "450",
                "contrast": "0.30",
                "brightness": "0.15"
            }
        ]
    }
    ```
    
1. Tap __Run__ again
1. Tap the rendition preview to download and review the generated rendition. Note its dimensions and how the contrast and brightness have been changed in comparison to the default rendition.

    ![Parameterized PNG rendition](./assets/worker/parameterized-rendition.png) 

1. Upload other images to the __Source file__ dropdown, and try running the worker against them with different parameters!

## Worker index.js on Github

The final `index.js` is available on Github at:

+ [aem-guides-wknd-asset-compute/actions/worker/index.js](https://github.com/adobe/aem-guides-wknd-asset-compute/blob/master/actions/worker/index.js)

## Troubleshooting

### Rendition is returned partially drawn

+ __Error__: Rendition renders incompletely, when total rendition file size is large

  ![Troubleshooting - Rendition is returned partially drawn](./assets/worker/troubleshooting__await.png)

+ __Cause__: The worker's `renditionCallback` function is exiting before the rendition can be completely written to `rendition.path`.
+ __Resolution__: Review the custom worker code and ensure all asynchronous calls are made synchronous.
