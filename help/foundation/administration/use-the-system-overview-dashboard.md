---
title: Use the System Overview Dashboard in AEM
description: In previous versions of AEM administrators needed to look at several locations in order to get a full picture of the AEM instance. The System Overview aims to solve this by providing a high level view of the configuration, hardware, and health of the AEM instance all from a single dashboard.
version: 6.4, 6.5
feature: 
topics: administration, operations, monitoring
activity: use
audience: administrator, architect, developer, implementer
doc-type: technical video
contentOwner: dgordon
---

# Use the System Overview Dashboard

Adobe Experience Manager's (AEM) [!UICONTROL System Overview] provides a high level view of the configuration, hardware, and health of the AEM instance all from a single dashboard.

>[!VIDEO](https://video.tv.adobe.com/v/21340?quality=12&learn=on)

1. The System Overview can be accessed from: **AEM Start** &gt; **[!UICONTROL Tools]** &gt; **[!UICONTROL Operations]** &gt; **[!UICONTROL System Overview]**

   Directly at **[!DNL &lt;server-host&gt;/libs/granite/operations/content/systemoverview.html]**

1. The information from the [!UICONTROL System Overview] can be exported by clicking the [!UICONTROL Download] button. The information is also exposed via the following [!DNL REST] endpoint:
1. Below is a sample output of the JSON that is exported from the [!UICONTROL System Overview]:

   ```json
   {
       "Health Checks": {
           "1 Critical": "System Maintenance",
           "3 Warn": "Replication Queue, Log Errors, Sling/Granite Content Access Check"
       },
       "Instance": {
           "Adobe Experience Manager": "6.4.0",
           "Run Modes": "s7connect, crx3, non-composite, author, samplecontent, crx3tar",
           "Instance Up Since": "2018-01-22 10:50:37"
       },
       "Repository": {
           "Apache Jackrabbit Oak": "1.8.0",
           "Node Store": "Segment Tar",
           "Repository Size": "0.26 GB",
           "File Data Store": "crx-quickstart/repository/datastore"
       },
       "Maintenance Tasks": {
           "Failed": "AuditLog Maintenance Task, Project Purge, Workflow Purge",
           "Succeeded": "Data Store Garbage Collection, Lucene Binaries Cleanup, Revision Clean Up, Version Purge, Purge of ad-hoc tasks"
       },
       "System Information": {
           "Mac OS X": "10.12.6",
           "System Load Average": "2.29",
           "Usable Disk Space": "89.44 GB",
           "Maximum Heap": "0.97 GB"
       },
       "Estimated Node Counts": {
           "Total": "232448",
           "Tags": "62",
           "Assets": "267",
           "Authorizables": "210",
           "Pages": "1592"
       },
       "Replication Agents": {
           "Blocked": "publish, publish2",
           "Idle": "offloading_b3deb296-9b28-4f60-8587-c06afa2e632c, offloading_outbox, offloading_reverse_b3deb296-9b28-4f60-8587-c06afa2e632c, publish_reverse, scene7, screens, screens2, test_and_target"
       },
       "Distribution Agents": {
           "Blocked": "publish"
       },
       "Workflows": {
           "Running Workflows": "15",
           "Failed Workflows": "15",
           "Failed Jobs": "150"
       },
       "Sling Jobs": {
           "Failed": "305"
       }
   }
   ```
