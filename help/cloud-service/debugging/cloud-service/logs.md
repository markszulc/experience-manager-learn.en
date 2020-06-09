---
title: Logs
description: Logs act as the frontline for debugging AEM applications in AEM as a Cloud Service, but are dependent on adequate logging in the deployed AEM application. AEM as a Cloud Service provides the last week's (7 days) logs for each environment.
feature: 
topics: development
version: cloud-service
doc-type: tutorial
activity: develop
audience: developer
kt: 5432
---

# Debugging AEM as a Cloud Service using logs

Logs act as the frontline for debugging AEM applications in AEM as a Cloud Service, but are dependent on adequate logging in the deployed AEM application. AEM as a Cloud Service provides the last week's (7 days) logs for each environment.

Logs for all pods per environment's service (Author or Publish) are consolidated into single log files. This means all log activity for an environment's service is consolidated into a single log file, even if different pods within that environment's service are generate the log statements.

Pod Ids are provided in each log statement, and allowing filtering or collating of log statements. Pod Id's are in the format of: 
  + `cm-p<PROGRAM ID>-e<ENVIRONMENT ID>-aem-<author|publish>-<POD NAME>`
  + Example: `cm-p12345-e56789-aem-author-abcdefabde-98765`

## AEM Author and Publish service logs

Both AEM Author and Publish services provide the same AEM runtime server logs:

+ `aemerror` is the Java error log (found at `/crx-quickstart/error.log` on the AEM SDK local quickstart). The following are the [recommended log levels](#log-levels) per environment type:
   + Development: `DEBUG`
   + Stage: `WARN`
   + Production: `ERROR`
+ `aemaccess` lists HTTP requests to the AEM service with details.
+ `aemrequest` lists HTTP requests made to AEM service and their corresponding HTTP responses.

## AEM Publish Dispatcher logs

Only AEM Publish Dispatcher provides Apache web server and Dispatcher logs, as these aspects only exists in the AEM Publish tier.

+ `httpdaccess` lists HTTP requests made to the AEM service's Apache web server/Dispatcher.
+ `httperror`  lists log messages from the Apache web server, and help with debugging supported Apache modules such as mod_rewrite.
  + Development: `DEBUG`
  + Stage: `WARN`
  + Production: `ERROR`
+ `aemdispatcher` lists log messages from the Dispatcher modules, including filtering and serving from cache messages.
  + Development: `DEBUG`
  + Stage: `WARN`
  + Production: `ERROR`
        
## Cloud Manager

Adobe Cloud Manager's web UI allows for the download of logs, by day, via the Download Logs action, associated with each AEM as a Cloud Service environment.

![Cloud Manager - Download Logs](./assets/logs/download-logs.png)

These logs can be downloaded and inspected via any log analysis tools. 

## Adobe I/O CLI with Cloud Manager plugin

Adobe Cloud Manager supports accessing AEM as a Cloud Service logs via the [Adobe I/O CLI](https://github.com/adobe/aio-cli) with the [Cloud Manager plugin for the Adobe I/O CLI](https://github.com/adobe/aio-cli-plugin-cloudmanager).

First, [set up the Adobe I/O with Cloud Manager plugin](../../local-development-environment/development-tools.md#aio-cli).

[Ensure the desired Program Id and Environment Id are in employed, and use [list-available-log-options](https://github.com/adobe/aio-cli-plugin-cloudmanager#aio-cloudmanagerlist-available-log-options-environmentid) to list the log options that are used to [tail](#aio-cli-tail-logs) or [download](#aio-cli-download-logs) logs.

```
$ aio cloudmanager:list-programs
Program Id Name      Enabled 
14304      Program 1 true    
11454      Program 2 true 
11502      Program 3 true    

$ aio config:set cloudmanager_programid <PROGRAM ID>

$ aio cloudmanager:list-environments        
Environment Id Name            Type  Description 
22295          program-3-dev   dev               
22310          program-3-prod  prod              
22294          program-3-stage stage   

$ aio cloudmanager:list-available-log-options <ENVIRONMENT ID>
Environment Id Service    Name          
22295          author     aemaccess     
22295          author     aemerror      
22295          author     aemrequest    
22295          publish    aemaccess     
22295          publish    aemerror      
22295          publish    aemrequest    
22295          dispatcher httpdaccess   
22295          dispatcher httpderror    
22295          dispatcher aemdispatcher 
```

### Tailing logs{#aio-cli-tail-logs}

Adobe I/O CLI provides the ability to [tail logs in real-time from AEM as a Cloud Service](https://github.com/adobe/aio-cli-plugin-cloudmanager#aio-cloudmanagertail-log-environmentid-service-name) using the `tail-logs` command. Tailing can be useful to watching real-time log activity as actions are performed on the AEM as a Cloud Service environment.

```
$ aio config:set cloudmanager_programid <PROGRAM ID>
$ aio cloudmanager:tail-logs <ENVIRONMENT ID> <SERVICE> <NAME>
```

Other command line tools, such as `grep` can be used to help isolate log statements of interest, for example:

```
$ aio cloudmanager:tail-logs 12345 author | grep com.example.MySlingModel
```

### Downloading logs{#aio-cli-download-logs}

Adobe I/O CLI provides the ability to [download logs from AEM as a Cloud Service](https://github.com/adobe/aio-cli-plugin-cloudmanager#aio-cloudmanagerdownload-logs-environmentid-service-name-days) using the `download-logs` command. This provides the same end result as downloading the logs from the Cloud Manager web UI, with the difference being this consolidates logs across days, based on the how many days worth of logs are requested.

```
$ aio config:set cloudmanager_programid <PROGRAM ID>
$ aio cloudmanager:download-logs <ENVIRONMENT> <SERVICE> <NAME>
```

## Recommended log levels{#log-levels}

Adobe's general guidance on log levels per AEM as a Cloud Service environment are:

+ Local Development (AEM SDK): `DEBUG`
+ Development: `DEBUG`
+ Stage: `WARN` 
+ Production: `ERROR`

Setting the most appropriate log level for each environment type is with AEM as a Cloud Service, log levels are maintained in code

+ Java log configurations is maintained in OSGi configurations
+ Apache web server and Dispatcher log levels in the the dispatcher project

...and thus, require a deployment to change.


### Environment specific variables to set Java log levels

An alternative to setting static, well known Java log levels for each environment, is to use AEM as Cloud Service's [environment specific variables](https://docs.adobe.com/content/help/en/experience-manager-cloud-service/implementing/deploying/configuring-osgi.html#environment-specific-configuration-values) to parameterize the log level, allowing the values to be changed dynamically via the [Adobe I/O CLI with Cloud Manager plugin](#aio-cli).

This requires updating the Logging OSGi configurations to use the environment specific variable placeholders. The Adobe recommended log levels should still be set as the [default value](https://docs.adobe.com/content/help/en/experience-manager-cloud-service/implementing/deploying/configuring-osgi.html#default-values) for the respective environments. For example:

`/apps/example/config/org.apache.sling.commons.log.LogManager.factory.config-example.cfg.json`

```
{
    "org.apache.sling.commons.log.names": ["com.example"],
    "org.apache.sling.commons.log.level": "$[env:LOG_LEVEL;default=DEBUG]"
}
```

This approach has several downsides that must be taken into account:

+ [A limited number of environment variables are allowed](https://docs.adobe.com/content/help/en/experience-manager-cloud-service/implementing/deploying/configuring-osgi.html#number-of-variables), and creating a variable to manage the log level will use one.
+ Environment variables are managed programmatically via [Adobe I/O CLI](https://github.com/adobe/aio-cli-plugin-cloudmanager#aio-cloudmanagerset-environment-variables-environmentid) or [Cloud Manager HTTP APIs](https://docs.adobe.com/content/help/en/experience-manager-cloud-service/implementing/deploying/configuring-osgi.html#cloud-manager-api-format-for-setting-properties).
+ Changes to environment variables must be manually reset. Forgetting to reset a high traffic environment such as Production to a less verbose log level may flood the logs and impact AEM's performance.

_Environment specific variables do not work for Apache web server or Dispatcher log configurations as these are not configured via OSGi configuration._