---
title: Chapter 5 - Authoring Content Services Pages
description: Chapter 5 of the AEM Headless tutorial covers creating the Pages from the Templates defined in Chapter 4. These pages will act as the JSON HTTP end-points.
---

# Chapter 5 - Authoring Content Services Pages

Chapter 5 of the AEM Headless tutorial covers creating the Page from the Templates defined in Chapter 4. The page create in this chapter will act as the JSON HTTP end-point for the Mobile App.

>[!NOTE]
>
> The page content architecture of `/content/wknd-mobile/en/api` has been pre-built. The base pages of `en` and `api` serve a architectural and organizational purpose, but are not strictly required. If API content may be localized, it is best practice to follow the usual Language Copy and Multi-site Manager page organization best-practices, since API page can be localized like any of AEM Sites page.

## Creating the Event API Page

1. Navigate to **[!UICONTROL AEM] > [!UICONTROL Sites] > [!DNL WKND Mobile] > [!DNL English] > [!DNL API]**.
1. **Tap the label the API page**, then tap the **Create** button in the top action bar and create a new Events API page under the API page.
    1. Tap **Create** in the top action bar
    1. Select **Events API** template
    1. In the **Name** field enter **events**
    1. In the **Title** field enter **Events API**
    1. Tap **Create** in the top action bar to create the page
    1. Tap **Done** to return to the AEM Sites admin

>[!VIDEO](https://video.tv.adobe.com/v/28340/?quality=12&learn=on)

## Authoring the Events API Page

>[!NOTE]
>
> The project provides CSS in order to provide some basic styles for the author experience.

1. Edit the **Events API** page by navigating to **AEM > Sites > WKND Mobile > English > API**, selecting the **Events API** page, and tapping **Edit** in the top action bar.
1. Add a **logo image** to display in the app by drag-and-dropping it from the Asset Finder onto the Image component placeholder.
    * Use the provided logo found at `/content/dam/wknd-mobile/images/wknd-logo.png`.

1. Add **tag line** to display above the events.
    1. Edit the **Text** component
    1. Enter the text:
        * `The WKND is here.`

1. Select the **events** to display:
    1. Set the following configuration on the **Properties** tab:
        * Model: **Event**
        * Parent Path: **/content/dam/wknd-mobile/en/events**
        * Tags: **&lt;Leave blank&gt;**
    1. Set the following configuration on the **Elements** tab:
        * Remove any listed elements, to ensure ALL elements of the Event Content Fragments are exposed.

>[!VIDEO](https://video.tv.adobe.com/v/28339/?quality=12&learn=on)

## Review the JSON output of the API page

The JSON output and its format can be reviewed by requesting the Page with the `.model.json` selector.

This JSON structure (or schema) must be well understood by consumers of this API. It is critical API consumers understand which aspects of the structure are fixed (ie. the Event API's Logo (Image) and Tag live (Text) and which are fluid (ie. the events listed under Content Fragment List component).

Breaking this contract on a published API, may result in incorrect behavior in the consuming Apps.

1. In new browser tabs, request the Events API pages using the `.model.json` selector, which invokes AEM Content Services' JSON Exporter, and serializes the Page and Components into a normalized, well defined JSON structure.

   The JSON structure produced by these pages is the structure consuming apps must align to.

1. Request the **Events API** page as **JSON**.

    * [http://localhost:4502/content/wknd-mobile/en/api/events.model.json](http://localhost:4502/content/wknd-mobile/en/api/events.model.tidy.json)

   The result should appear similar to:

![AEM Content Services JSON output](assets/chapter-5/json-output.png)

>[!NOTE]
>
> This JSON can be output in a **tidy** (formatted) fashion for human-readability by using the `.tidy` selector:
> * [http://localhost:4502/content/wknd-mobile/en/api/events.model.tidy.json](http://localhost:4502/content/wknd-mobile/en/api/events.model.tidy.json)

## Next step

Optionally, install the [com.adobe.aem.guides.wknd-mobile.content.chapter-5.zip](https://github.com/adobe/aem-guides-wknd-mobile/releases/latest) content package on AEM Author via [AEM's Package Manager](http://localhost:4502/crx/packmgr/index.jsp). This package contains the configurations and content outlined in this and preceding chapters of the tutorial.

* [Chapter 6 - Exposing the Content on AEM Publish as JSON](./chapter-6.md)
