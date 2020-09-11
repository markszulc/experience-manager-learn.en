---
title: Chapter 1 - Tutorial Set up and Downloads
seo-title: Getting Started with AEM Content Services - Chapter 1 -  Tutorial Set up
description: Chapter 1 of the AEM Headless tutorial the baseline setup for the AEM instance for the tutorial.
seo-description: Chapter 1 of the AEM Headless tutorial the baseline setup for the AEM instance for the tutorial.
---

# Tutorial Set up

The latest version of AEM and AEM WCM Core Components is always recommended.

* AEM 6.5 or later
* AEM WCM Core Components 2.4.0 or later
  * Included in the [WKND Mobile AEM Application Content Package below](#wknd-mobile-application-packages)

Prior to starting this tutorial ensure the following AEM instances are [installed and running on your local machine](https://helpx.adobe.com/experience-manager/6-5/sites/deploying/using/deploy.html#Default%20Local%20Install):

* **AEM Author** on **port 4502**
* **AEM Publish** on **port 4503**

## WKND Mobile Application Packages{#wknd-mobile-application-packages}

Install the following AEM Content Packages on **both** AEM Author and AEM Publish, using [!DNL AEM Package Manager].

* [ui.apps: GitHub > Assets > com.adobe.aem.guides.wknd-mobile.ui.apps-x.x.x.zip](https://github.com/adobe/aem-guides-wknd-mobile/releases/latest)
  * [!DNL WKND Mobile Empty Template Type]
  * [!DNL WKND Mobile] Proxy Component for AEM WCM Core Components
  * [!DNL WKND Mobile] AEM Content Services pages' CSS (for minor styling)
* [ui.content: GitHub > com.adobe.aem.guides.wknd-mobile.ui.content-x.x.x.zip](https://github.com/adobe/aem-guides-wknd-mobile/releases/latest)
  * [!DNL WKND Mobile] Site structure
  * [!DNL WKND Mobile] DAM folder structure
  * [!DNL WKND Mobile] image assets

In [Chapter 7](./chapter-7.md) we will run the [!DNL WKND Mobile] Android Mobile App using [Android Studio](https://developer.android.com/studio) and the provided APK (Android Application Package):

* [[!DNL Android Mobile App: GitHub > Assets > wknd-mobile.x.x.x.apk]](https://github.com/adobe/aem-guides-wknd-mobile/releases/latest)

## Chapter AEM Content Packages

This set of content packages creates content and configuration described in the associated chapter, and all preceding chapters. These packages are optional but can expedite content creation.

* [Chapter 2 Content: GitHub > Assets > com.adobe.aem.guides.wknd-mobile.content.chapter-2.zip](https://github.com/adobe/aem-guides-wknd-mobile/releases/latest)
* [Chapter 3 Content: GitHub > Assets > com.adobe.aem.guides.wknd-mobile.content.chapter-3.zip](https://github.com/adobe/aem-guides-wknd-mobile/releases/latest)
* [Chapter 4 Content: GitHub > Assets > com.adobe.aem.guides.wknd-mobile.content.chapter-4.zip](https://github.com/adobe/aem-guides-wknd-mobile/releases/latest)
* [Chapter 5 Content: GitHub > Assets > com.adobe.aem.guides.wknd-mobile.content.chapter-5.zip](https://github.com/adobe/aem-guides-wknd-mobile/releases/latest)

## Source Code

The source code for both the AEM project and the [!DNL Android Mobile App] are available on the [[!DNL AEM Guides - WKND Mobile GitHub Project]](https://github.com/adobe/aem-guides-wknd-mobile). The source code does not need to be built or modified for this tutorial, it is provided to allow for fully transparency in how all aspects of tutorial are built.

If you find an issue with the tutorial or the code, please leave a [GitHub issue](https://github.com/adobe/aem-guides-wknd-mobile/issues).

## Skip to the end

In order to skip to the end of the tutorial, the [com.adobe.aem.guides.wknd-mobile.content.chapter-5.zip](https://github.com/adobe/aem-guides-wknd-mobile/releases/latest) content package can be installed on **both** AEM Author and AEM Publish. Note that content and configuration will not show as published in AEM Author, however due to the manual deployment, all the requisite content and configuration will be available on AEM Publish allowing the [!DNL WKND Mobile App] to access the content.


## Next step

* [Chapter 2 - Defining Event Content Fragment Models](./chapter-2.md)
