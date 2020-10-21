---
title:  Personalization of full web page Experience
description: Learn how to create an activity to redirect your site pages that are hosted on AEM to a new page using Adobe Target.
feature: targeting
topics: integrations, authoring, personalization, activity, offers
audience: all
doc-type: feature video
activity: use
version: cloud-service
kt: 6353
thumbnail: 6353-personalization-web-page.jpg
---

# Personalization of full web page Experience {#personalization-fpe}

Learn how to create an activity to redirect your site pages that are hosted on AEM to a new page using Adobe Target.

Before creating an Activity in Target, you need to do setup:

1. [Integrate Experience Platform Launch and AEM](https://docs.adobe.com/content/help/en/experience-manager-learn/sites/integrations/experience-platform-launch/overview.html)

## Scenario Overview

WKND site redesigned their home page and would like to redirect their current home page visitors to the new home page. At the same time, also understand how the redesigned home page helps to improve user engagement and revenue. As a marketer, you have been assigned the task to create an activity to redirect the visitors to the new home page. Let us explore the WKND site home page and learn how to create an activity using Adobe Target.

## Steps to create an A/B test using Visual Experience Composer (VEC)

1. Login to Adobe Target and navigate to the Activities tab
1. Click **Create Activity** button and then choose **A/B Test** activity

    ![A/B Activity](assets/ab-target-activity.png)

1. Select the **Visual Experience Composer** option,  provide the Activity URL, and then click **Next**

    ![Activity URL](assets/ab-test-url.png)

1. The Visual Experience Composer displays two tabs on the left side after you create a new activity: *Experience A* and *Experience B*. Select an experience from the list. You can add new experiences to the list, by using the **Add Experience** button.

    ![Experience Options](assets/experience-options.png)

1. View options available for Experience A and then select the **Redirect to URL** option and provide a URL for the new WKND Site home page.

    ![Redirect URL](assets/redirect-url.png)

1. Rename *Experience A* to *New WKND Home Page* and *Experience B* to *WKND Home Page*

    ![Adventures](assets/new-experiences.png)

1. Click **Next** to move to Targeting and keep a Manual traffic allocation of 50-50 between the two experiences. 

    ![Targeting](assets/targeting.png)

1. For Goals and settings, choose the Reporting source as Adobe Target and select the Goal metric as Conversion with a page view action.

    ![Goals](assets/goals.png)

1. Provide a name for your activity and Save.
1. Activate your saved activity to push your changes live.

    ![Goals](assets/activate.png)

1. Open your site page (Activity URL from step 3) in a new tab and you should be able to view either of the experiences (WKND Home Page or New WKND Home Page) from our A/B test activity. `us/en.html` redirects to `us/home.html`.

    ![Goals](assets/redirect-test.png)

## Summary

As a marketer you were able to create an activity to redirect your site pages that are hosted on AEM to a new page using Adobe Target.

## Supporting Links

* [Adobe Experience Cloud Debugger - Chrome](https://chrome.google.com/webstore/detail/adobe-experience-cloud-de/ocdmogmohccmeicdhlhhgepeaijenapj) 
* [Adobe Experience Cloud Debugger - Firefox](https://addons.mozilla.org/en-US/firefox/addon/adobe-experience-platform-dbg/)

