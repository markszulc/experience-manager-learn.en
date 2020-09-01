Only the AIO_runtime_namespace and AIO_runtime_auth for the correct workspace are necessary for deployment. I think this document will help explain: https://www.adobe.io/apis/experienceplatform/project-firefly/docs.html#!AdobeDocs/project-firefly/master/guides/deployment.md



I'm pretty sure these could be set locally as environment variables, not in a .env file, just locally via bash:

export AIO_runtime_namespace=*

export AIO_runtime_auth=*

(I have not tried this to confirm, but I don't see any reason why this wouldn't work.)

https://wiki.corp.adobe.com/pages/viewpage.action?spaceKey=DMSArchitecture&title=KT+-+AEM+Assets+-+Asset+Compute+Microservices+%28Nui%29+Extensibility


https://docs.adobe.com/content/help/en/asset-compute/using/extend/deploy-custom-application.html






## Deploy

Asset Compute applications must be deployed to Adobe I/O Runtime in order for them to be used by AEM as a Cloud Services. 

When deploying to Adobe I/O Runtime for use by AEM as a Cloud Service Author services, rather than for local development, only two environment variables are required:

+ `AIO_runtime_namespace` points the Adobe Project Firefly Workspace to deploy to.
+ `AIO_runtime_auth` are the Adobe Project Firefly workspace's authentication credentials.


## Development

Because we generated this project using `aio app init` and selected the `Development` workspace, `AIO_runtime_namespace` is automatically set to `81368-wkndaemassetcompute-development` with the corresponding `AIO_runtime_auth` in our local `.env` file. 

If an `.env` file exists in the directory used to issue the deploy command, its values are used.

1. Open a new terminal window in the root of the Asset Compute application project
1. Execute the command `aio app deploy`
1. Execute the command `aio app get-url` to obtain ther URL that will be used in the AEM as a Cloud Service Processing Profile to reference this custom Asset Compute worker. If the project contained multiple worker implmentations, discrete URLs for each worker would be listed.




1. Open the Asset Compute application project's `.env` and review the key `AIO_runtime_namespace`. 
This defines to the Adobe I/O Runtime Workspace the application will deploy to when the `aio app deploy` command is execute. Because we generated this project using `aio app init` and selected the `Development` workspace, the value is: `81368-wkndaemassetcompute-development`.

1. Execute the command `aio app deploy` 
1. This deploys the current code, along with any values in 


## Stage and Production

