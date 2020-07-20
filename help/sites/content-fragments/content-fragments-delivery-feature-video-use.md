---
title: Delivering Content Fragments in AEM
seo-title: Delivering Content Fragments in Adobe Experience Manager
description: Content Fragments, independent of layout, can be used directly in AEM Sites with Core Components or can be delivered in a headless manner to downstream channels.
seo-description: Content Fragments, independent of layout, can be used directly in AEM Sites with Core Components or can be delivered in a headless manner to downstream channels.
sub-product: content-services
feature: content-fragments
topics: authoring, content-architecture
audience: all
doc-type: feature video
activity: use
version: 6.3, 6.4, 6.5
uuid: 045473d2-5abe-4414-b91c-d369f3069ead
discoiquuid: 912e0c41-83cf-49f7-b515-09519b6718c1
---

# Delivering Content Fragments {#delivering-content-fragments}

Adobe Experience Manager (AEM) Content Fragments are text-based editorial content that may include some structured data elements associated but considered pure content without design or layout information. Content Fragments are typically created as channel-agnostic content, that is intended to be used and re-used across channels, which in turn wrap the content in a context-specific experience.

Content Fragments, independent of layout, can be used directly in AEM Sites with Core Components or can be delivered in a headless manner to downstream channels.

This video series covers the delivery options for using Content Fragments. Details about defining and [authoring Content Fragments can be found here](content-fragments-feature-video-use.md).

1. Using Content Fragments on web pages
2. Exposing Content Fragments as JSON using AEM Content Services
3. Using the Assets HTTP API

## Using Content Fragments in Web pages {#using-content-fragments-in-web-pages}

>[!VIDEO](https://video.tv.adobe.com/v/22449/?quality=12&learn=on)

Content Fragments can be used on AEM Sites pages, or in a similar fashion, Experience Fragments, using the AEM WCM Core Components' [Content Fragment component](https://docs.adobe.com/content/help/en/experience-manager-core-components/using/components/content-fragment-component.html).

Content Fragment components can be styled using AEM's Style System to display the content as needed.

## Exposing Content Fragments as JSON {#exposing-content-fragments-as-json}

>[!VIDEO](https://video.tv.adobe.com/v/22448/?quality=12&learn=on)

AEM Content Services facilitates the creation of AEM Page-based HTTP end-points that rendition content into a normalized JSON format.

The above video uses the [Content Fragment Component](https://docs.adobe.com/content/help/en/experience-manager-core-components/using/components/content-fragment-component.html) to expose individual Content Fragments. The [Content Fragment List Component](https://docs.adobe.com/content/help/en/experience-manager-core-components/using/components/content-fragment-list.html) is a new component that allows an author to define a query that will dynamically populate the page with a list of Content Fragments. The Content Fragment List component is preferred when multiple Content Fragments need to be exposed.

*Example Content Services end-point JSON payload:*  
**[athletes.json](assets/athletes.json)**

## Using the Assets HTTP API

>[!VIDEO](https://video.tv.adobe.com/v/26390/?quality=12&learn=on)

First introduced in AEM 6.5, is enhanced support for Content Fragments with the Assets HTTP API. This provides an easy way for developers to perform Create, Read, Update, and Delete (CRUD) operations against Content Fragments.

*Example POSTMAN Requests:*
**[CRUD-CFM-API-We.Retail.postman_collection.json](assets/CRUD-CFM-API-We.Retail.postman_collection.json)**

## Which delivery method to use

### Web Channel

The approach to delivering a Content Fragment via a web channel is straightforward by using the Content Fragment component with AEM Sites.

### Headless

There are two options for exposing Content Fragment as JSON to support a 3rd party channel in a headless use case:

1. Use AEM Content Services and Proxy API pages (Video #2) when the primary use case is deliver Content Fragments for consumption (Read-only) by a 3rd party channel. The Content Services framework provides more flexibility and options as to what data gets exposed. Developers can also extend the Content Services framework to augment and/or enrich the data.

2. Use the Assets HTTP API (Video #3) when the 3rd party channel needs to modify and/or update Content Fragments. A typical use case is ingesting 3rd party content on an AEM author environment.

## Additional Resources {#additional-resources}

* [Authoring Content Fragments](content-fragments-feature-video-use.md)
* [AEM WCM Core Components](https://docs.adobe.com/content/help/en/experience-manager-core-components/using/introduction.html)
* [AEM WCM Core Content Fragment Component](https://docs.adobe.com/content/help/en/experience-manager-core-components/using/components/content-fragment-component.html)

To download and install the package below on an AEM 6.4+ instance for the final state from the video series:  
**[aem_demo_fluid-experiencescontent-fragments-100.zip](assets/aem_demo_fluid-experiencescontent-fragments-100.zip)**
