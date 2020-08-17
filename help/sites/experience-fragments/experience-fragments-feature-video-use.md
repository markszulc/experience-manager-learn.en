---
title: Using AEM Experience Fragments
description: Experience Fragments allows content authors to reuse content across channels including Sites pages and 3rd party systems.
sub-product: sites, content-services
feature: experience-fragments
topics: authoring, content-architecture
audience: all
doc-type: feature video
activity: use
version: 6.3, 6.4, 6.5
kt: 971
---

# Using Experience Fragments{#using-aem-experience-fragments}

Experience Fragments are a feature of Adobe Experience Manager (AEM), first introduced in AEM 6.3. Experience Fragments allows content authors to reuse content across channels including Sites pages and 3rd party systems.

## Experience Fragments Overview

>[!VIDEO](https://video.tv.adobe.com/v/17028/?quality=9&learn=on)

An Experience Fragment is a set of content that grouped forms an experience that should make sense on its own.

With Experience Fragments marketers can:

* Reuse an experience across channels (both owned channels and 3rd party touch-points)
* Create variations of an experience for specific use-cases
* Keep variations in sync with the use of Live  Copy
* Social Post experiences to Facebook and Pinterest out of the box

## Building Blocks with Experience Fragments

Building blocks is a new enhancement added to Experience Fragment in AEM 6.4+. It lets content authors create a building block consisting of components that could be re-used to create content across different variations and across different templates.

>[!VIDEO](https://video.tv.adobe.com/v/21289/?quality=9&learn=on)

>[!NOTE]
>
> Editable templates used for creating experience fragments should have the building block component added to its policies.

* Creating a building block makes it easy for content authors to re-use the content across different variations.
* Changing the master copy building block should automatically roll out changes to its references without cancelling inheritance or any layout changes.
* Content authors can easily rename an existing building block or delete it.
* Deleting a building block from an Experience Fragment doesn't delete its references.

## Experience Fragments Full-Text Search

AEM 6.5, now supports full-text search capabilities for Experience Fragments.

>[!VIDEO](https://video.tv.adobe.com/v/27720/?quality=9&learn=on)

* **Content Authors** (Internal search) can now search for a text part within an Experience Fragment and the result would include the experience fragments containing the text as well as the page that references the experience fragment.
* **Site Users** (External search) can now perform a full-text search using the search component, and the result would include site pages that reference the experience fragment containing the search keyword.
