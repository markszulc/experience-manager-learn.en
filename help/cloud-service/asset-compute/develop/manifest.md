

# Configure the manifest.yml

The `manifest.yml`, located in the root of the Asset Compute application project, describes all the workers in this project that are available when deployed.

## Basic worker definition

Workers are defined as Adobe I/O Runtime Action entries under `actions`.

Workers accessing other Adobe I/O integrations must set the `annotations -> require-adobe-auth` property to `true` as this [exposes the worker's Adobe I/O credentials](https://docs.adobe.com/content/help/en/asset-compute/using/extend/develop-custom-application.html#access-adobe-apis) via the `params.auth` object.

1. Open and review the auto-generated worker `manifest.yml`. Projects that contains multiple Asset Compute workers, must define an entry for each worker under the `actions` array.

```yml
packages:
  __APP_PACKAGE__:
    license: Apache-2.0
    actions: # the array of workers, more 
      worker: # the auto-generated worker definition
        function: actions/worker/index.js # the entry point to the worker 
        web: 'yes'  # as our worker is invoked over HTTP from AEM Author service
        runtime: 'nodejs:10' # the target nodejs runtime
        limits:
          concurrency: 10
        annotations:
          require-adobe-auth: true # set to true, to pass through Adobe I/O acces token/client id via params.auth in the worker
```          

## Define inputs 

Inputs provide a way to set default params for the worker while specifying their values via environment variables, such as those defined in `.env`.

This is most often used for [passing credentials used to access third-party systems](https://docs.adobe.com/content/help/en/asset-compute/using/extend/develop-custom-application.html#access-adobe-apis), such as the credentials for your cloud storage. If Amazon S3 is used, the 

1. Add an `inputs` section to the new `wknd-asset-compute` actions entry. This acts as a pass-through for environments variables, 

```yml
packages:
  __APP_PACKAGE__:
    license: Apache-2.0
    actions: 
      worker:
        function: actions/worker/index.js 
          web: 'yes' 
          runtime: 'nodejs:10'
          limits:
            concurrency: 10
          annotations:
              require-adobe-auth: true
          inputs: # Optionally define environment value-driven varaibles exposed in the worker via params object
            cloudStorageId: $AZURE_STORAGE_ACCOUNT # the cloud storage account defined by env variable AZURE_STORAGE_ACCOUNT (available in index.js via `params.cloudStoragId`)
            cloudStorageSecret: $AZURE_STORAGE_KEY # the cloud storage secret defined by env variable AZURE_STORAGE_KEY (available in index.js via `params.cloudStorageSecret`)
            cloudStorageContainer: $AZURE_STORAGE_CONTAINER_NAME # the cloud storage container name defined by env variables AZURE_STORAGE_CONTAINER_NAME (available in index.js via `params.cloudStorageContainer`)
``` 

## Define limits

Each worker can be discretely configure the [limits](https://www.adobe.io/apis/experienceplatform/runtime/docs.html#!adobedocs/adobeio-runtime/master/guides/system_settings.md) for its execution context in Adobe I/O runtime. These values should be tuned to provide optimal sizing for the worker, based on the volume and rate of assets it will compute, and the type of work it performs.

Ensure you review [Adobe sizing guidance](https://docs.adobe.com/content/help/en/asset-compute/using/extend/develop-custom-application.html#sizing-workers) before setting limits.

1. Add an `inputs` section to the new `wknd-asset-compute` actions entry. This allows tuning of the Asset Compute worker's overall performance and resource allocation.

```yml
packages:
  __APP_PACKAGE__:
    license: Apache-2.0
    actions: 
      worker:
        function: actions/worker/index.js 
        web: 'yes' 
        runtime: 'nodejs:10'
        limits: # Allows for the tuning of the worker's performance
          timeout: 180000 # timeout in millseconds 
          memorySize: 200 # memory allocated in MB; if the worker offloads heavy computational work to other Web services this number can be reduced
          concurrency: 10 # adjust based on expected concurrent processing and timeout 
        annotations:
          require-adobe-auth: true
        inputs: 
          cloudStorageId: $AZURE_STORAGE_ACCOUNT
          cloudStorageSecret: $AZURE_STORAGE_KEY
          cloudStorageContainer: $AZURE_STORAGE_CONTAINER_NAME
           
```    

## The manifest.yml

The resultant `manifest.yml` looks like:

```yml
packages:
  __APP_PACKAGE__:
    license: Apache-2.0
    actions: 
      worker:
        function: actions/worker/index.js 
        web: 'yes' 
        runtime: 'nodejs:10'
        limits:
          timeout: 180000 # in ms
          memorySize: 200 # in MB
          concurrency: 10 
        annotations:
          require-adobe-auth: true
        inputs: 
          cloudStorageId: $AZURE_STORAGE_ACCOUNT
          cloudStorageSecret: $AZURE_STORAGE_KEY
          cloudStorageContainer: $AZURE_STORAGE_CONTAINER_NAME
```    


## Validating the project configuration

Once the generated Asset Compute `manifest.yml` is updated, run the application local and ensure it starts the Dev Tool successfully.

Open a shell terminal in the project root, and start up the Asset Compute Dev Tool to by executing the command:

```
$ aio app run
```

This starts the local Asset Compute Local Dev Tool at http://localhost:9000 which opens in a new Web browser.

Watch the terminal output as the Asset Compute Dev Tool intializes and the Web browser window for error messages.

To stop the Asset Compute Local Dev Tool, tap `Ctrl-C` in the terminal window that executed `aio app run` to terminate the process.


## Troubleshooting

### TODO
+ __Error message:__ TODO (via standard out from `aio app run` command)
+ __Cause:__ Yaml files are white-spaced sensitive, it likely that your intedentation is incorrect.
+ __Resolution:__ Review your `manifest.yml` and ensure all indentation is correct.



### memorySize limit is set too low

+ __Error message:__  Local Dev Server OpenWhiskError: PUT https://adobeioruntime.net/api/v1/namespaces/81368-wkndaemassetcompute-development/actions/wkndAemAssetCompute-0.0.1/__secured_workeroverwrite=true Returned HTTP 400 (Bad Request) --> "The request content was malformed:requirement failed: memory 64 MB below allowed threshold of 134217728 B"
+ __Cause:__ A `memorySize` limit in the manfest was set beflow the minimum allowed threshold as reported by the error message in bytes.
+ __Resolution:__  Review the `memorySize` limits in the `manifest.yml` and ensure they are all large than the minimum allowed threshold.