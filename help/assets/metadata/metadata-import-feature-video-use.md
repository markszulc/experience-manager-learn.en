---
title: Using Metadata Import and Export in AEM Assets
seo-title: Using Metadata Import and Export in AEM Assets
description: AEM Assets metadata import and export capabilities allow content authors to easily move asset metadata in and out of AEM and leverage the power of Microsoft Excel to manipulate metadata at scale, facilitating the bulk update metadata for existing assets in AEM.
seo-description: AEM Assets metadata import and export capabilities allow content authors to easily move asset metadata in and out of AEM and leverage the power of Microsoft Excel to manipulate metadata at scale, facilitating the bulk update metadata for existing assets in AEM.
uuid: db7e57a4-b0c1-4a48-906d-802c19964313
discoiquuid: 72dd9230-73e1-454e-a3e0-9281e621d901
topics: metadata 
audience: all
doc-type: feature video
activity: use
version: 6.3, 6.4, 6.5
---

# Using Metadata Import and Export in AEM Assets{#using-metadata-import-and-export-in-aem-assets}

AEM Assets metadata import and export capabilities allow content authors to easily move asset metadata in and out of AEM and leverage the power of Microsoft Excel to manipulate metadata at scale, facilitating the bulk update metadata for existing assets in AEM.

## Metadata Export {#metadata-export}

>[!VIDEO](https://video.tv.adobe.com/v/22132/?quality=9&learn=on)

## Metadata Import {#metadata-import}

>[!VIDEO](https://video.tv.adobe.com/v/21374/?quality=9&learn=on)

Download [WeRetail sports folder](assets/we-retail-sports.zip)

Download [Asset metadata package](assets/we-retail-sports-asset-metadata.zip)

## Metadata File Format {#metadata-file-format}

### CSV File Format

#### First Row

* The first row of the CSV file defines the metadata schema. 
* The First column defaults to `assetPath`, which holds the absolute JCR Path for an asset.

* Subsequent columns in the first-row point to other metadata properties of an asset.

    * For example : `dc:title, dc:description, jcr:title`

* Single Value Property format

    * `<metadata property name> {{<property type}}`
    * If property type is not specified it defaults to String. 
    * For example: `dc:title {{String}}`

* Property Name is case sensitive
    * Correct : `dc:title {{String}}`
    * Incorrect: `Dc:Ttle {{String}}`

* Property Type is case insensitive
* All valid [JCR Property types](https://docs.adobe.com/docs/en/spec/jsr170/javadocs/jcr-2.0/javax/jcr/PropertyType.html) are supported  

* Multi Value Property format - `<metadata property name> {{<property type : MULTI }}`

#### Second Row to N rows

* The first column holds the absolute JCR path for an asset. For example: /content/dam/asset1.jpg
* Metadata property for an asset could have missing values in the CSV file. Missing metadata property for that particular asset will not be updated.