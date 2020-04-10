---
title: Set up Social Posting with AEM Experience Fragments
description: Experience Fragments allow marketers to post experiences created in AEM to social media platforms. The video below details the setup and configuration necessary to publish Experience Fragments to Facebook and Pinterest.
sub-product: sites, content-services
feature: experience-fragments
topics: integrations, content-delivery
audience: administrator, implementer, developer
doc-type: setup
activity: use
version: 6.3, 6.4, 6.5
---

# Setup Social Posting with Experience Fragments {#set-up-social-posting-with-experience-fragments}

Experience Fragments allow marketers to post experiences created in AEM to social media platforms. The video below details the setup and configuration necessary to publish Experience Fragments to Facebook and Pinterest.

>[!VIDEO](https://video.tv.adobe.com/v/20592/?quality=9)
*[Experience Fragments] - Setup and configuration to social post to Facebook and Pinterest*

## Checklist for configuring Experience Fragments to post to Facebook and Pinterest

1. AEM Author Instance is running on HTTPS
2. Facebook Account + Facebook Developer App
3. Pinterest Account + Pinterest Developer App
4. [!UICONTROL AEM Cloud Services] Configuration - Facebook
5. [!UICONTROL AEM Cloud Services] Configuration - Pinterest
6. AEM Experience Fragment with Cloud Services for Facebook + Pinterest
7. Experience Fragment Variation using Facebook Template
8. Experience Fragment Variation using Pinterest Template

## Experience Fragment Redirect URI

This URI is used for Facebook and Pinterest apps as part of the Oauth flow.

```plain
 /* replace localhost:8443 with your aem host info */

 https://localhost:8443/libs/cq/experience-fragments/components/redirect
```

