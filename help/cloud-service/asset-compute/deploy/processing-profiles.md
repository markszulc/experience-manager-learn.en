## Deployment to AEM as a Cloud Service

To use the custom Asset Compute workers, they must be referenced in AEM as a Cloud Service Author service via a Processing Profile.

1. Login to AEM as a Cloud Service Author service as an __AEM Administrator__. As this is a tutorial we recommned using a Dev environment or an environment in a Sandbox.
1. Navigate to __Tools > Assets > Processing Profiles__
1. Tap __Create__ button
1. Provide a meaningful name for the Processing Profile, `XX`
1. Tap the __Custom__ tab, and tap __Add New__
1. Define the new service
    + __Rendition name:__ `XXX`
        + The file name rendition that will be used to identify this rendition in AEM Assets
    + __Extension:__ `png`
        + The extension of the rendition that will be generated. Set to `png` as this is the supported output format the worker's web service supports.
    + __Endpoint:__ `https://81368-wkndaemassetcompute-development.adobeioruntime.net/api/v1/web/wkndAemAssetCompute-0.0.1/worker`
        + This is th URL to the worker obtained via `aio app get-url`. Ensure the URL points at the correct workspace based on the AEM as a Cloud Service environent the Processing Profile is being configured in. Note that this sub-domain matches the `development` workspace.
    + __Service Parameters__
        + Tap `Add Parameter`
            + Key: `maskFormat`
            + Value: `soft`
                + Allowed values per the API are `soft` or `binary`
        + Key/value pairs that are passed into the Asset Compute worker and available via `rendition.instructions` JavaScript object.
    + __Mime Types__
        + __Includes:__ `image/jpeg`, `image/png`
            + Only process assets with these MIME Types using this service configuration. These two MIME types are the only MIME types the worker's web service supports, therefore we'll limit which assets can be processed by the worker.
        + __Excludes:__ `Leave blank`
            + Never process assets with these MIME Types using this service configuration
1. Tap __Save__ in the top right
1. Select the newly created Processing Profile
1. Tap __Apply Profile to Folder(s)__ in the top action bar
1. Select an a folder to apply the Processing Profile to, such as `WKND / XXX / XXX` and tap __Apply__
1. Navigate to the folder the Processing Profile was not applied to via __AEM > Assets > Files__ and tap into  `WKND / XXX / XXX`.
1. Upload a [new asset](./assets/processing-profiles/new-asset.jpeg) to the folder that has the new Processing Profile applied, and wait for the uploaded asset to be processed.
1. Tap the asset to open it's details
1. Open the __Renditions__ view from the left sidebar
1. Tap on the asset named `XXX` and review the generated rendition