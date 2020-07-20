---
title: Understanding Color Management with AEM Dynamic Media
seo-title: Understanding Color Management with AEM Dynamic Media
description: In this video we explore Dynamic Media Color Management, and how it can be used to provide color correction preview capabilities in for AEM Assets.
seo-description: In this video we explore Dynamic Media Color Management, and how it can be used to provide color correction preview capabilities in for AEM Assets.
uuid: dc14d067-11a2-4662-acfd-f9f6f1d738ee
discoiquuid: b2b9ccc9-96b5-4bea-9995-2e6b353c469d
sub-product: dynamic-media
feature: image-profiles, video-profiles
topics: images, videos, renditions, authoring, integrations, publishing, metadata
audience : developer, architect, administrator
doc-type: technical video
audience : administrator, developer
activity: setup
version: 6.3, 6.4, 6.5
---

# Understanding Color Management with AEM Dynamic Media{#understanding-color-management-with-aem-dynamic-media}

In this video we explore Dynamic Media Color Management, and how it can be used to provide color correction preview capabilities in for AEM Assets.

>[!VIDEO](https://video.tv.adobe.com/v/16792/?quality=9&learn=on)

>[!NOTE]
>
>[Enable Dynamic Media](https://docs.adobe.com/docs/en/aem/6-0/administer/integration/dynamic-media/enabling-dynamic-media.html) in AEM to use this feature.

This feature is available for AEM 6.1 and 6.2 versions as a Feature Pack.

## XML template for the Color Management configuration node {#xml-template-for-the-color-management-configuration-node}

The following is the XML template for the Color Management configuration node. This XML template can be copied into the AEM development project and configured with the project-appropriate configurations.

```xml
<?xml version="1.0" encoding="UTF-8"?>

<!--
    XML Node definition for: /etc/dam/imageserver/configuration/jcr:content/settings

 Adobe Docs

 * Image Server Configuration: https://docs.adobe.com/docs/en/aem/6-2/administer/content/dynamic-media/config-dynamic.html#Configuring%20Dynamic%20Media%20Image%20Settings

* Default Color Profile Configuration: https://docs.adobe.com/docs/en/aem/6-1/administer/content/dynamic-media/config-dynamic.html#Configuring%20the%20default%20color%20profiles

    iccprofileXXX values:
        Node name of color profile found at: /etc/dam/imageserver/profiles

    iccblackpointcompensation values:
        true | false

    iccdither values:
        true | false

    iccrenderintent values:
        0 for perceptual
        1 for relative colorimetric
        2 for saturation
        3 for absolute colorimetric

-->

<jcr:root xmlns:sling="http://sling.apache.org/jcr/sling/1.0" xmlns:cq="http://www.day.com/jcr/cq/1.0"
    xmlns:jcr="http://www.jcp.org/jcr/1.0" xmlns:nt="http://www.jcp.org/jcr/nt/1.0"
    jcr:primaryType="nt:unstructured"

        bkgcolor="FFFFFF"
        defaultpix="300,300"
        defaultthumbpix="100,100"
        expiration="{Long}36000000"
        jpegquality="80"
        maxpix="2000,2000"
        resmode="SHARP2"
        resolution="72"
        thumbnailtime="[1%,11%,21%,31%,41%,51%,61%,71%,81%,91%]"
        iccprofilergb=""
        iccprofilecmyk=""
        iccprofilegray=""
        iccprofilesrcrgb=""
        iccprofilesrccmyk=""
        iccprofilesrcgray=""
        iccblackpointcompensation="{Boolean}true"
        iccdither="{Boolean}false"
        iccrenderintent="{Long}0"
/>

```

### List of default Adobe color profiles are listed below {#list-of-default-adobe-color-profiles-are-listed-below}

| Name                | Colorspace | Description                           |
| ------------------- | ---------- | ------------------------------------- |
| AdobeRGB            | RGB        | Adobe RGB (1998)                      |
| AppleRGB            | RGB        | Apple RGB                             |
| CIERGB              | RGB        | CIE RGB                               |
| CoatedFogra27       | CMYK       | Coated FOGRA27 (ISO 12647-2:2004)     |
| CoatedFogra39       | CMYK       | Coated FOGRA39 (ISO 12647-2:2004)     |
| CoatedGraCol        | CMYK       | Coated GRACoL 2006 (ISO 12647-2:2004) |
| ColorMatchRGB       | RGB        | ColorMatch RGB                        |
| EuropeISOCoated     | CMYK       | Europe ISO Coated FOGRA27             |
| EuroscaleCoated     | CMYK       | Euroscale Coated v2                   |
| EuroscaleUncoated   | CMYK       | Euroscale Uncoated v2                 |
| JapanColorCoated    | CMYK       | Japan Color 2001 Coated               |
| JapanColorNewspaper | CMYK       | Japan Color 2002 Newspaper            |
| JapanColorUncoated  | CMYK       | Japan Color 2001 Uncoated             |
| JapanColorWebCoated | CMYK       | Japan Color 2003 Web Coated           |
| JapanWebCoated      | CMYK       | Japan Web Coated (Ad)                 |
| NewsprintSNAP2007   | CMYK       | US Newsprint (SNAP 2007)              |
| NTSC                | RGB        | NTSC (1953)                           |
| PAL                 | RGB        | PAL/SECAM                             |
| ProPhoto            | RGB        | ProPhoto RGB                          |
| PS4Default          | CMYK       | Photoshop 4 Default CMYK              |
| PS5Default          | CMYK       | Photoshop 5 Default CMYK              |
| SheetfedCoated      | CMYK       | U.S. Sheetfed Coated v2               |
| SheetfedUncoated    | CMYK       | U.S. Sheetfed Uncoated v2             |
| SMPTE               | RGB        | SMPTE-C                               |
| sRGB                | RGB sRGB   | IEC61966-2.1                          |
| UncoatedFogra29     | CMYK       | Uncoated FOGRA29 (ISO 12647-2:2004)   |
| WebCoated           | CMYK       | U.S. Web Coated (SWOP) v2             |
| WebCoatedFogra28    | CMYK       | Web Coated FOGRA28 (ISO 12647-2:2004) |
| WebCoatedGrade3     | CMYK       | Web Coated SWOP 2006 Grade 3 Paper    |
| WebCoatedGrade5     | CMYK       | Web Coated SWOP 2006 Grade 5 Paper    |
| WebUncoated         | CMYK       | U.S. Web Uncoated v2                  |
| WideGamutRGB        | RGB        | Wide Gamut RGB                        |

## Additional Resources{#additional-resources}

* [Configuring Dynamic Media Color Management](https://helpx.adobe.com/experience-manager/6-5/assets/using/config-dynamic.html#ConfiguringDynamicMediaColorManagement)
