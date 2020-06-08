



# Logs


## Cloud Manager Logs

## Cloud Manager

![Cloud Manager - Download Logs](./assets/logs/cloud-mananger__download-logs.png)


## AIO CLI

```
$ aio cloudmanager:list-programs
$ aio cloudmanager:list-environments --programId=1234               
$ aio cloudmanager:list-available-log-options --programId 1234 5678
```

### Downloading logs

AEM CLI provides the ability to download logs from AEM as a Cloud Service using the `download-logs` command.

```
$ aio cloudmanager:download-logs --programId=1234 5678 <author|publish|dispatcher> DAYS
```


### Tailing logs

AIO CLI provides the ability to tail logs in real-time from AEM as a Cloud Service using the `tail-logs` command.

```
$ aio cloudmanager:tail-logs --programId=1234 5678 <author|publish|dispatcher> DAYS
```