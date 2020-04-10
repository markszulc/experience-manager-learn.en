---
title: Getting Started with AEM Sites - WKND Tutorial
description: Getting Started with AEM Sites - WKND Tutorial. The WKND tutorial is a multi-part tutorial designed for developers new to Adobe Experience Manager. The tutorial walks through the implementation of an AEM site for a fictitious lifestyle brand, the WKND. The tutorial covers fundamental topics like project setup, maven archetypes, Core Components, Editable Templates, client libraries, and component development.
sub-product: sites
topics: development
version: cloud-service
doc-type: tutorial
activity: develop
audience: developer
KT: 4132
mini-toc-levels: 1
index: y
---

# Getting Started with AEM Sites - WKND Tutorial {#introduction}

Welcome to a multi-part tutorial designed for developers new to Adobe Experience Manager (AEM). This tutorial walks through the implementation of an AEM site for a fictitious lifestyle brand the WKND. The tutorial covers fundamental topics like project setup, Core Components, Editable Templates, Client-side libraries, and component development with Adobe Experience Manager Sites.

## Overview {#wknd-tutorial-overview}

The goal for this multi-part tutorial is to teach a developer how to implement a website using the latest standards and technologies in Adobe Experience Manager (AEM). After completing this tutorial a developer should understand the basic foundation of the platform and with knowledge of common design patterns in AEM.

>[!VIDEO](https://video.tv.adobe.com/v/30476?quality=12)

The tutorial is designed to work with **AEM as a Cloud Service** and is backwards compatible with **AEM 6.5+** and **AEM 6.4.2+**. The site is implemented using:

* [Maven AEM Project Archetype](https://docs.adobe.com/content/help/en/experience-manager-core-components/using/developing/archetype/overview.html)
* [Core Components](https://docs.adobe.com/content/help/en/experience-manager-core-components/using/introduction.html)
* [HTL](https://docs.adobe.com/content/help/en/experience-manager-htl/using/getting-started/getting-started.html)
* Sling Models
* [Editable Templates](https://docs.adobe.com/content/help/en/experience-manager-learn/sites/page-authoring/template-editor-feature-video-use.html)
* [Style System](https://docs.adobe.com/content/help/en/experience-manager-learn/sites/page-authoring/style-system-feature-video-use.html)

*Estimate 1-2 hours to get through each part of the tutorial.*

## About the tutorial {#about-tutorial}

The WKND is a fictional online magazine and blog that focuses on nightlife, activities, and events in several international cities.

### Adobe XD UI Kit

To make this tutorial closer to a real-world scenario Adobe's talented UX designers created the mockups for the site using [Adobe XD](https://www.adobe.com/products/xd.html). Over the course of the tutorial various pieces of the designs are implemented into a fully author-able AEM site. Special thanks to **Lorenzo Buosi** and **Kilian Amendola** who created the beautiful design for the WKND site.

Download the XD UI kits:

* [AEM Core Component UI Kit](assets/overview/AEM-CoreComponents-UI-Kit.xd)
* [WKND UI Kit](assets/overview/AEM_UI-kit_WKND.xd)

The name WKND is fitting because we expect a developer to take the better part of a ***weekend*** to complete the tutorial.

### Github {#github}

All of the code for the project can be found on Github in the AEM Guide repo:

**[GitHub: WKND Sites Project](https://github.com/adobe/aem-guides-wknd)**

In addition, each part of the tutorial has its own branch in GitHub. A user can begin the tutorial at any point by simply checking out the branch that corresponds to the previous part.

>[!NOTE]
>
> If you were working with the previous version of this tutorial, you can still find the [solution packages](https://github.com/adobe/aem-guides-wknd/releases/tag/archetype-18.1) and [code](https://github.com/adobe/aem-guides-wknd/tree/archetype-18.1) on GitHub.

## Local Development Environment {#local-dev-environment}

A local development environment is necessary to complete this tutorial. Screenshots and video are captured using the AEM as a Cloud Service SDK running on a Mac OS environment. Commands and code should be independent of the local operating system, unless otherwise noted.

**New to AEM as a Cloud Service?** Check out the [following guide to setting up a local development environment using the AEM as a Cloud Service SDK](https://docs.adobe.com/content/help/en/experience-manager-learn/cloud-service/local-development-environment-set-up/overview.html).

**New to AEM 6.5?** Check out the [following guide to setting up a local development environment](https://docs.adobe.com/content/help/en/experience-manager-learn/foundation/development/set-up-a-local-aem-development-environment.html).

### Required software

The following should be installed locally:

* [AEM as a Cloud Service SDK](https://docs.adobe.com/content/help/en/experience-manager-learn/cloud-service/local-development-environment-set-up/aem-runtime.html#download-the-aem-as-a-cloud-service-sdk) or [AEM 6.5](https://helpx.adobe.com/experience-manager/6-5/sites/deploying/using/technical-requirements.html) or [AEM 6.4 + SP2](https://helpx.adobe.com/experience-manager/6-4/release-notes/sp-release-notes.html)
* [Java 11](https://downloads.experiencecloud.adobe.com/content/software-distribution/en/general.html) (AEM 6.5+ only)
* [Apache Maven](https://maven.apache.org/) (3.3.9 or newer)
* [Node.js v10+](https://nodejs.org/en/)
* [npm 6+](https://www.npmjs.com/)
* [Git](https://git-scm.com/)

### Integrated Development Environment (IDE)

This tutorial uses [Eclipse](https://www.eclipse.org/) with the [AEM Developer Tool Plugin](https://eclipse.adobe.com/aem/dev-tools/) as the IDE, however any IDE that has support for Java and Maven projects can be used. The reliance on specific IDE features in this tutorial is minimal.

For detailed steps for using Eclipse or other IDEs like [Visual Studio Code](https://code.visualstudio.com/) or [IntelliJ](https://www.jetbrains.com/idea/), [check out the following guide](https://docs.adobe.com/content/help/en/experience-manager-learn/foundation/development/set-up-a-local-aem-development-environment.html).

## Reference Site {#reference-site}

A finished version of the WKND Site is also available as a reference: [https://wknd.site/](https://wknd.site/)

The tutorial covers the major development skills needed for an AEM developer but will *not* build the entire site end-to-end. The finished reference site is another great resource to explore and see more of AEM's out of the box capabilities.

To test the latest code before jumping into the tutorial, download and install the **[latest release from GitHub](https://github.com/adobe/aem-guides-wknd/releases/latest)**.

### Powered by Adobe Stock

Many of the images in the WKND Reference website are from [Adobe Stock](https://stock.adobe.com/) and are Third Party Material as defined in the Demo Asset Additional Terms at [https://www.adobe.com/legal/terms.html](https://www.adobe.com/legal/terms.html). If you want to use an Adobe Stock image for other purposes beyond viewing this demo website, such as featuring it on a website, or in marketing materials, you can purchase a license on Adobe Stock.

With Adobe Stock, you have access to more than 140 million high-quality, royalty-free images including photos, graphics, videos and templates to jumpstart your creative projects.

## Next Steps {#next-steps}

What are you waiting for?! Start the tutorial by navigating to the [Project Setup](project-setup.md) chapter and learn how to generate a new Adobe Experience Manager project using the AEM Project Archetype.
