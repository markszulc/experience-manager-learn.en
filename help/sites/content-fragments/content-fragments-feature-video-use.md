---
title: Authoring Content Fragments in AEM
description: Content Fragments are a content abstraction in AEM that allows text-based content to be authored and managed independently of the channels it supports. 
sub-product: content-services
feature: content-fragments
topics: authoring, content-architecture
audience: all
doc-type: feature video
activity: use
version: 6.3, 6.4, 6.5
---

# Authoring Content Fragments {#authoring-content-fragments}

Content Fragments are a content abstraction in AEM that allows text-based content to be authored and managed independently of the channels it supports.

>[!NOTE]
>
>The AEM Content Fragment functionality covered in these videos was first introduced in [AEM 6.3 + FP 19008 and FP19614](https://helpx.adobe.com/experience-manager/6-3/release-notes/content-services-fragments-featurepack.html).
>

AEM Content Fragments are text-based editorial content that may include some structured data elements associated but considered pure content without design or layout information. Content Fragments are typically created as channel-agnostic content, that is intended to be used and re-used across channels, which in turn wrap the content in a context-specific experience.

This video series covers the authoring life-cycle of Content Fragments in AEM. Details about [delivering Content Fragments can be found here](content-fragments-delivery-feature-video-use.md).

1. Enabling and defining Content Fragment Models
2. Authoring Content Fragments
3. Downloading Content Fragments
4. Editorial capabilities

## Defining Content Fragment Models {#defining-content-fragment-models}

>[!VIDEO](https://video.tv.adobe.com/v/22452/?quality=12&learn=on)

AEM Content Fragments Models, the data schemas of Content Fragments, must be enabled via AEM's [!UICONTROL Configuration Browser], which allows Content Fragment Models to be defined on a per configuration basis.

## Creating Content Fragments {#creating-content-fragments}

>[!VIDEO](https://video.tv.adobe.com/v/22451/?quality=12&learn=on)

AEM configurations are applied to AEM Assets folder hierarchies to allow their Content Fragment Models to be created as Content Fragments. Content Fragments support a rich form-based authoring experience allowing content to be modeled as a collection of elements.

Content Fragments can have multiple variants, each variant addressing a different use-case (thought, not necessarily channel) for the content.

*Example athlete biography for import:*  
**[sandra-sprient-bio.txt](assets/sandra-sprient-bio.txt)**

## Downloading Content Fragments {#downloading-content-fragments}

>[!VIDEO](https://video.tv.adobe.com/v/22450/?quality=12&learn=on)

AEM Content Fragments can be downloaded from AEM Author as a Zip file containing Variants, Elements, and Metadata.

*Example Content Fragment download Zip file:*  
**[daniel_schreder.zip](assets/daniel_schreder.zip)**

## Content Fragment editorial capabilities {#editorial-capabilities}

>[!VIDEO](https://video.tv.adobe.com/v/25891/?quality=12&learn=on)

>[!NOTE]
>
> Annotation and version compare for Content Fragments were introduced in [AEM 6.4 Service Pack 2](https://helpx.adobe.com/experience-manager/aem-releases-updates.html) and [AEM 6.3 Service Pack 3](https://helpx.adobe.com/experience-manager/6-3/release-notes/sp3-release-notes.html).

## Next Steps

Learn about [delivering Content Fragments](content-fragments-delivery-feature-video-use.md).

## Additional Resources {#additional-resources}

* [Delivering Content Fragments](content-fragments-delivery-feature-video-use.md)
* [AEM WCM Core Components](https://docs.adobe.com/content/help/en/experience-manager-core-components/using/introduction.html)
* [AEM WCM Core Content Fragment Component](https://docs.adobe.com/content/help/en/experience-manager-core-components/using/components/content-fragment-component.html)

To download and install the package below on an AEM 6.4+ instance for the final state from the video series:

**[aem_demo_fluid-experiencescontent-fragments-100.zip](assets/aem_demo_fluid-experiencescontent-fragments-100.zip)**
