---
title: Watermarks in AEM Assets
description: AEM as a Cloud Service's watermarking capabilities allows custom image renditions to be watermarked using any PNG image.
feature: watermark
topics: images
audience: all
doc-type: feature video
activity: use
version: cloud-service
kt: 6357
thumbnail: 41536.jpg
---

# Watermarks

AEM as a Cloud Service's watermarking capabilities allows custom image renditions to be watermarked using any PNG image.

>[!VIDEO](https://video.tv.adobe.com/v/41536/?quality=12&learn=on)

## OSGi configuration

The following OSGi configuration stub can be updated and added to your AEM project's `ui.config` sub-project. 

`/apps/example/osgiconfig/config.author/com.adobe.cq.assetcompute.impl.profile.WatermarkingProfileServiceImpl.cfg.json`

```json
{
    "watermark": "/content/dam/path/to/watermark.png",
     "scale": 1.0
}
```