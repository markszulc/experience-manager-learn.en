---
title: Using Reports in AEM Assets
description: AEM Assets provides an enterprise level reporting framework that scales for large repositories through an intuitive user experience. 
feature: reports
topics: authoring, operations, performance, metadata
audience: all
doc-type: feature video
activity: use
version: 6.3, 6.4, 6.5
kt: 648
---

# Using Reports in AEM Assets{#using-reports-in-aem-assets}

AEM Assets provides an enterprise level reporting framework that scales for large repositories through an intuitive user experience.

>[!VIDEO](https://video.tv.adobe.com/v/22140/?quality=12&learn=on)

## Microsoft Excel Formulas {#excel-formulas}

The following formulas are used in the video to generate the Assets by Size chart in Microsoft Excel.

### Asset size normalization to bytes {#asset-size-normalization-to-bytes}

```
=IF(RIGHT(D2,2)="KB",
      LEFT(D2,(LEN(D2)-2))*1024,
  IF(RIGHT(D2,2)="MB",
      LEFT(D2,(LEN(D2)-2))*1024*1024,
  IF(RIGHT(D2,2)="GB",
      LEFT(D2,(LEN(D2)-2))*1024*1024*1024,
  IF(RIGHT(D2,2)="TB",
      LEFT(D2,(LEN(D2)-2))*1024*1024*1024*1024, 0))))
```

### Asset count by size {#asset-count-by-size}

#### Less than 200 KB {#less-than-kb}

```
=COUNTIFS(E2:E1000,"< 200000")

```

#### 200 KB to 500 KB {#kb-to-kb}

```
=COUNTIFS(E2:E1000,">= 200000", E2:E1000,"<= 500000")
```

#### Greater than 500 KB {#greater-than-kb}

```
=COUNTIFS(E2:E1000,"> 500000")
```

## Additional Resources{#additional-resources}

Download [All Assets Excel File with Chart](./assets/asset-reports/all-assets.xlsx)
