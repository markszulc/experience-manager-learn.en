---
title: Use oak-run.jar to Manage Indexes
description: oak-run.jar's index command consolidates a number of features to manage Oak indexes in AEM, from gathering index statistics, running index consistency checks, and re/indexing indexes themselves.
version: 6.4, 6.5
feature: oak
topics: search
activity: use
audience: architect, developer, implementer
doc-type: technical-video
---

# Use oak-run.jar to Manage Indexes

[!DNL oak-run.jar]'s index command consolidates a number of features to manage [!DNL Oak]200 indexes in AEM, from gathering index statistics, running index consistency checks, and re/indexing indexes themselves.

>[!NOTE]
>
>Within this article and videos the terms indexing and re-indexing are used interchangeably and considered the same operation.

## ![DNL oak-run.jar] index Command Basics

>[!VIDEO](https://video.tv.adobe.com/v/21475/?quality=9)

* The version of [[!DNL oak-run.jar]](https://repository.apache.org/service/local/artifact/maven/redirect?r=releases&g=org.apache.jackrabbit&a=oak-run&v=1.8.0) used must match the version of Oak used on the AEM instance.
* Managing indexes using ![DNL oak-run.jar] leverages the **[!DNL index]** command with various flags to support different operations.

    * `java -jar oak-run*.jar index ...`

## Index Statistics

>[!VIDEO](https://video.tv.adobe.com/v/21477/?quality=12)

* `oak-run.jar` dumps all index definitions, important index stats and index contents for offline analysis.
* The index statistics gathering is safe to execute on in-use AEM instances.

## Index Consistency Check

>[!VIDEO](https://video.tv.adobe.com/v/21476/?quality=12)

* `oak-run.jar` quickly determines if lucene Oak indexes are corrupt.
* The consistency check is safe to run on in-use AEM instance for consistency check levels 1 and 2.

## TarMK Online indexing with [!DNL oak-run.jar] {#tarmkonlineindexingwithoakrunjar}

>[!VIDEO](https://video.tv.adobe.com/v/21479/?quality=12)

* Online indexing of [!DNL TarMK] using [!DNL oak-run.jar] is faster than setting `reindex=true` on the `oak:queryIndexDefinition` node. Despite this performance increase, online indexing using [!DNL oak-run.jar] still requires a maintenance window to perform the indexing.

* Online indexing of [!DNL TarMK] using [!DNL oak-run.jar] should **not** be executed against AEM instances outside of the AEM's instances maintenance window.

## TarMK Offline indexing with oak-run.jar

>[!VIDEO](https://video.tv.adobe.com/v/21478/?quality=12)

* Offline indexing of [!DNL TarMK] using [!DNL oak-run.jar] is the simplest [!DNL oak-run.jar] based indexing approach for [!DNL TarMK] as it requires a single [!DNL oak-run.jar] command, however it requires the AEM instance to be shutdown.

## TarMK Out-of-band indexing with oak-run.jar

>[!VIDEO](https://video.tv.adobe.com/v/21480/?quality=12)

* Out-of-band indexing on [!DNL TarMK] using [!DNL oak-run.jar] minimizes the impact of indexing on in-use AEM instances.
* Out-of-band indexing is the recommended indexing approach for AEM installations where the time to re/index exceeds the available maintenance windows.

## MongoMK Online indexing with oak-run.jar

* Online index with [!DNL oak-run.jar] on [!DNL MongoMK] and [!DNL RDBMK] is the recommended method for re/indexing [!DNL MongoMK] (and [!DNL RDBMK]) AEM installations. **No other method should be used for [!DNL MongoMK] or [!DNL RDBMK].**
* This indexing needs to be executed only against a single AEM instance in the cluster.
* Online indexing of [!DNL MongoMK] is safe to execute against a running AEM cluster, as the repository traversal will occur on only a single [!DNL MongoDB] node, allowing the others to continue serving requests without significant performance impact.

The [!DNL oak-run.jar] index command to perform an online indexing of [!DNL MongoMK] is the [same as the [!DNL TarMK] Online indexing with [!DNL oak-run.jar]](#tarmkonlineindexingwithoakrunjar) with the difference that the segment store parameter points to the [!DNL MongoDB] instance that contains the Node store.

```
java -jar oak-run*.jar index
 --reindex
 --index-paths=/oak:index/lucene
 --read-write
 --fds-path=/path/to/datastore mongodb://server:port/aem
```

## Supporting materials

* [Download [!DNL oak-run.jar]](https://repository.apache.org/#nexus-search;gav~org.apache.jackrabbit~oak-run~~~~kw,versionexpand)
    * *Ensure the downloaded version matches the version of Oak installed on AEM as described above*
* [Apache Jackrabbit Oak oak-run.jar Index Command Documentation](https://jackrabbit.apache.org/oak/docs/query/oak-run-indexing.html)
