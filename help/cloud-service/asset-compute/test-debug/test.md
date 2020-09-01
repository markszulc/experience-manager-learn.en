# Test an Asset Compute worker

The Asset Compute project defines a pattern for executing tests of Asset Compute workers.

The general pattern 

## Anatomy of a worker test


## Writing a test

1. Ensure [Docker Desktop](../set-up/development-environment.md#docker) is running.
1. First delete the auto-generated `simple-worker` tests case at `/test/asset-compute/simple-worker` since this is now an invalid test, as the worker no longer copies the source binary to the rendition.
1. Create a new `test-case` folder under `/test/asset-compute/worker` named `success` to test a successful execution of the.
1. Add this [new input file](assets/test/file.jpg) for this test case and name it `file.jpg`. This file represents the `source` input file that will be processed by the worker.
1. Add this [new rendition file](assets/test/rendition.jpg) for this test case and name it `rendition.jpg`. This file represents the `rendition` file that will output by the worker. 
1. Add a new file named `params.json` that defines the input parameters of the worker. This should be what is passed into the [Dev Tool's Asset Compute profile definition](../develop/dev-tool.md), less the `worker` key.

 with the contents:

```json
{ 
    "fmt": "jpg"
}
```

1. Create a mock server for the XXX API. This file mocks the responses for the HTTP requests made from the worker. 

The name of the file is in the format: `mock-<host>.json`, so in this case, `mock-image.adobe.io.json`.

```
[{
    "httpRequest": {
        "path": "/lrService/autoStraighten"
        "method": "POST"
    },
    "httpResponse": {
        "statusCode": 202,
        "body": {
            "_links": {
                "self" :{
                    "href" : "https://image.adobe.io/lrService/status/1234-5678-90"
                }
            }
        }
    }
},
{
    "httpRequest": {
        "path": "/lrService/status/1234-5678-90"
        "method": "GET"
    },
    "httpResponse": {
        "statusCode": 202,
        "body": {
            "jobId":"f54e0fcb-260b-47c3-b520-de0d17dc2b67",
            "created":"2018-01-04T12:57:15.12345:Z",
            "modified":"2018-01-04T12:58:36.12345:Z",
            "outputs":[{
                "input":"/file.jpg",
                "status":"succeeded",
                "_links": {
                    "self": {
                        "href":"/OUTPUT/rendition.jpg",
                        "storage":"azure"
                    }
                }
            }],
            "_links": {
                "self": {
                    "href":"https://image.adobe.io/lrService/status/1234-5678-90"
                }
            }
        }
    }
}]
```


https://aemguideswkndassetcomput.blob.core.windows.net/asset-compute/source/WKND087-Photo-01.jpg

1. Create a mock of the cloud storage service. This file mocks the responses for the HTTP requests made from the worker to the  cloud storage.

The name of the file is in the format: `mock-<host>.json`, so in this case, `mock-aemguideswkndassetcomput.blob.core.windows.net.json`.

```
[{
    "httpRequest": {
        "path": "/asset-compute/"
        "method": "POST"
    },
    "httpResponse": {
        "statusCode": 202,
        "body": {
            "_links": {
                "self" :{
                    "href" : "https://image.adobe.io/lrService/status/1234-5678-90"
                }
            }
        }
    }
},
{
    "httpRequest": {
        "path": "/lrService/status/1234-5678-90"
        "method": "GET"
    },
    "httpResponse": {
        "statusCode": 202,
        "body": {
            "jobId":"f54e0fcb-260b-47c3-b520-de0d17dc2b67",
            "created":"2018-01-04T12:57:15.12345:Z",
            "modified":"2018-01-04T12:58:36.12345:Z",
            "outputs":[{
                "input":"/file.jpg",
                "status":"succeeded",
                "_links": {
                    "self": {
                        "href":"/OUTPUT/rendition.jpg",
                        "storage":"azure"
                    }
                }
            }],
            "_links": {
                "self": {
                    "href":"https://image.adobe.io/lrService/status/1234-5678-90"
                }
            }
        }
    }
}]





https://docs.adobe.com/content/help/en/asset-compute/using/extend/test-custom-application.html