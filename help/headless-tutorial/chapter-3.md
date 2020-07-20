---
title: Chapter 3 - Authoring Event Content Fragments
seo-title: Getting Started with AEM Content Services - Chapter 3 - Authoring Event Content Fragments
description: Chapter 3 of the AEM Headless tutorial covers creating and authoring Event Content Fragments from the Content Fragment Model created in Chapter 2.
seo-description: Chapter 3 of the AEM Headless tutorial covers creating and authoring Event Content Fragments from the Content Fragment Model created in Chapter 2.
---

# Chapter 3 - Authoring Event Content Fragments

Chapter 3 of the AEM Headless tutorial covers creating and authoring Events Content Fragments from the Content Fragment Model created in [Chapter 2](./chapter-2.md).

## Authoring an Event Content Fragment

With an [!DNL Event] Content Fragment Model created and the AEM Configuration for WKND applied to the `/content/dam/wknd-mobile` Asset folder (via the `cq:conf` property), a [!DNL Event] Content Fragment can be created.

Content Fragments, which are a type of Asset, should be organized and managed in AEM Assets just like other assets.

* Use locale folders in the Assets folder structure if translation is (or may be) required
* Logically organize Content Fragments so they are easy to locate and manage

In this step, well create a new [!DNL Event] for `Punkrock Fest` in the `/content/dam/wknd-mobile/en/events` assets folder.

1. Navigate to **[!UICONTROL AEM] > [!UICONTROL Assets] > [!UICONTROL Files] > [!DNL WKND Mobile] > [!DNL English]** and create Asset folders **[!DNL Events]**.
1. Within **[!UICONTROL Assets] > [!UICONTROL Files] > [!DNL WKND Mobile] > [!DNL English] > [!DNL Events]** create a new Content Fragment of type **[!DNL Event]** with a title of **[!DNL Punkrock Fest]**.
1. Author the newly created [!DNL Event] Content Fragment.

    * [!DNL Event Title] : **[!DNL Punkrock Fest]**
    * [!DNL Event Description] : **&lt;Enter a few lines of description...&gt;**
    * [!DNL Event Date] : **&lt;Select a date in the future&gt;**
    * [!DNL Event Type] : **Music**
    * [!DNL Ticket Price] : **10**
    * [!DNL Event Image] : **/content/dam/wknd-mobile/images/tom-rogerson-574325-unsplash.jpg**
    * [!DNL Venue Name] : **The Reptile House**
    * [!DNL Venue City] : **New York**
  
   Tap **[!UICONTROL Save]** in the top action bar to save changes.

1. Using [AEM's Package Manager](http://localhost:4502/crx/packmgr/index.jsp), install the package below on AEM Author. This package contains a number of Event Content Fragments.

   [Get File: GitHub > Assets > com.adobe.aem.guides.wknd-mobile.content.chapter-3.zip](https://github.com/adobe/aem-guides-wknd-mobile/releases/latest)

>[!VIDEO](https://video.tv.adobe.com/v/28338/?quality=12&learn=on)

## Reviewing the Content Fragment's JCR structure

*This section is informational only and meant to socialize the underlying JCR structure of Content Fragments made from Content Fragment Models.*

1. Open **[CRXDE Lite](http://localhost:4502/crx/de/index.jsp)** on AEM Author.  
1. In CRXDE Lite, on the left-hand hierarchy menu, navigate to [/content/dam/wknd-mobile/en/events/punkrock-fest/jcr:content](http://localhost:4502/crx/de/index.jsp#/content/dam/wknd-mobile/en/events/punkrock-fest/jcr:content) which is the node representing the [!DNL Punkrock Fest] [!DNL Event] Content Fragment in the JCR.
1. Expand the [data](http://localhost:4502/crx/de/index.jsp#/content/dam/wknd-mobile/en/events/punkrock-fest/jcr:content/data/master) node.
Review in the **Properties pane** that it has a property `cq:model` that points to the [!DNL Event] Content Fragment Model definition.
    * **`cq:model` **=** `/conf/settings/wknd-mobile/dam/cfm/models/event`**
1. Beneath the `data` node select the [master](http://localhost:4502/crx/de/index.jsp#/content/dam/wknd-mobile/en/events/punkrock-fest/jcr:content/data/master) node and review the properties. This node contains the content collected during the authoring of an [!DNL Event] Content Fragment Model. The JCR property names correspond to the Content Fragment Model property name's, and the values correspond to the authored values of the "[!DNL Punkrock Fest]" [!DNL Event] Content Fragment.

>[!VIDEO](https://video.tv.adobe.com/v/28356/?quality=12&learn=on)

## Next step

It is recommended, you install the [com.adobe.aem.guides.wknd-mobile.content.chapter-3.zip](https://github.com/adobe/aem-guides-wknd-mobile/releases/latest) content package on AEM Author via [AEM's [!UICONTROL Package Manager]](http://localhost:4502/crx/packmgr/index.jsp). This package contains the configurations and content outlined in this and preceding chapters of the tutorial.

* [Chapter 4 - Defining AEM Content Services Templates](./chapter-4.md)
