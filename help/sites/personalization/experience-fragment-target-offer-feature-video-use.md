---
title: Using AEM Experience Fragment Offers within Adobe Target
seo-title: Using AEM Experience Fragment Offers within Adobe Target
description: Adobe Experience Manager 6.4 reimagines the personalization workflow between AEM and Target. Experiences created within AEM can now be delivered directly to Adobe Target as HTML Offers. It allows Marketers to seamlessly test and personalize content across different channels.
seo-description: Adobe Experience Manager 6.4 reimagines the personalization workflow between AEM and Target. Experiences created within AEM can now be delivered directly to Adobe Target as HTML Offers. It allows Marketers to seamlessly test and personalize content across different channels.
sub-product: content-services
feature: experience-fragments
topics: integrations, personalization
audience: all
doc-type: feature video
activity: setup
version: 6.4, 6.5
uuid: 7b91f65d-5a35-419a-8cf7-be850165dd33
discoiquuid: 45fc8d83-73fb-42e5-9c92-ce588c085ed4
---

# Using Experience Fragment Offers within Adobe Target{#using-experience-fragment-offers-within-adobe-target}

Adobe Experience Manager 6.4 reimagines the personalization workflow between AEM and Target. Experiences created within AEM can now be delivered directly to Adobe Target as HTML Offers. It allows Marketers to seamlessly test and personalize content across different channels.

>[!VIDEO](https://video.tv.adobe.com/v/22383/?quality=12&learn=on)

>[!NOTE]
>
>Recommended to use at.js client library and the best practice is to use tag management solutions like Launch By Adobe, Adobe DTM or any 3rd party tag management solution to add target libraries to your site pages

>[!NOTE]
>
>AEM Experience Fragment Offers within Adobe Target is also available as a Feature Pack for AEM 6.3 users. Please see below section for Feature Packs and dependencies.
>

* Adobe Experience Manager's easy-to-use and powerful content creating mechanism along with Adobe Target's Artificial Intelligence(AI) and Machine Learning helps content authors to create and manage content for all channels in a centralized location. With the ability to export Experience Fragments into Adobe Target as HTML offers, marketers now have more flexibility to create a more personalized experience using these offers and can now test and scale each experience they create. 
* The main difference between the HTML offers and Experience Fragment offers is that editing for the later can only be done in AEM and then synchronized with Adobe Target
* Target Cloud service configuration applied to Experience Fragment folder inherits to all Experience Fragments created directly under the parent folder. Child folder doesn't inherit the parent cloud services configuration. 
* To create a personalized offer we can now easily leverage content stored within AEM.
* You can create types of Target activities, including the Sensei-powered activities like Auto-allocate, Auto Target, and Automated Personalization

## AEM 6.3 Feature Packs and Dependencies {#aem-feature-packs-and-dependencies}

| AEM 6.3 Feature Pack                                                                                                                                                                                    | Dependencies                                                                                  |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------- |
| [CQ-6.3.0-FEATUREPACK-18961](https://www.adobeaemcloud.com/content/marketplace/marketplaceProxy.html?packagePath=/content/companies/public/adobe/packages/cq630/featurepack/cq-6.3.0-featurepack-18961) | adobe/cq630/servicepack:aem-service-pkg:6.3.2                                                 |
| [CQ-6.3.0-FEATUREPACK-24442](https://www.adobeaemcloud.com/content/marketplace/marketplaceProxy.html?packagePath=/content/companies/public/adobe/packages/cq630/featurepack/cq-6.3.0-featurepack-24442) | adobe/cq630/servicepack:aem-service-pkg:6.3.2 adobe/cq630/cumulativefixpack:aem-6.3.2-cfp:1.0 |
| [CQ-6.3.0-FEATUREPACK-24640](https://www.adobeaemcloud.com/content/marketplace/marketplaceProxy.html?packagePath=/content/companies/public/adobe/packages/cq630/featurepack/cq-6.3.0-featurepack-24640) | adobe/cq630/servicepack:aem-service-pkg:6.3.2 adobe/cq630/cumulativefixpack:aem-6.3.2-cfp:2.0 |

## Additional Resources {#additional-resources}

* [Fluid Personalization - AEM Experience Fragments in Adobe Target](https://www.youtube.com/watch?v=ohvKDjCb1yM)
* [Experience Fragments Documentation](https://helpx.adobe.com/experience-manager/6-5/sites/authoring/using/experience-fragments.html)
* [Using Experience Fragments](/help/sites/experience-fragments/experience-fragments-feature-video-use.md)
