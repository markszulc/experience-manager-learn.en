---
title: Getting started with SPA Editor and Remote SPA  - Overview
description: Welcome to the multi-part tutorial for developers looking to augment an existing Remote SPAs with editable AEM content using AEM SPA Editor.
topic: Headless, SPA, Development
feature: SPA Editor, Core Components, APIs, Developing
role: Developer, Architect
level: Beginner
kt: 7630
thumbnail: kt-7630.jpg
---

# Overview

Welcome to the multi-part tutorial for developers looking to augment an existing React-based (or Next.js) Remote SPAs with editable AEM content using AEM SPA Editor.

This tutorial builds upon the [WKND GraphQL App](https://experienceleague.adobe.com/docs/experience-manager-learn/getting-started-with-aem-headless/graphql/overview.html), a React app that consumes AEM Content Fragment content over AEM's GraphQL APIs, however does not  provide any in-context authoring of SPA content.

## About the tutorial

The tutorial intended to illustrate how a Remote SPA, or a SPA running outside the context of AEM, can be updated to consume and deliver content authored in AEM.

Most activities in the tutorial focus on JavaScript development, however critical aspects are covered that revolve around AEM. These aspects include defining where the content is  authored and stored in AEM and mapping SPA routes to AEM Pages.

The tutorial is designed to work with **AEM as a Cloud Service** and is composed of two projects:

1. The __AEM Project__ contains configuration and content that must be deployed to AEM.
1. __WKND App__ project is the SPA to be integrated with AEM's SPA Editor

## Latest code

+ This tutorial's code can be found on [GitHub](https://github.com/adobe/aem-guides-wknd-graphql) on the `feature/spa-editor` branch. 

## Prerequisites

This tutorial requires the following:

+ [AEM as a Cloud Service SDK](https://experienceleague.adobe.com/docs/experience-manager-learn/cloud-service/local-development-environment-set-up/aem-runtime.html?lang=en)
+ [Node.js v14+](https://nodejs.org/en/)
+ [npm v7+](https://www.npmjs.com/)
+ [Java™ 11](https://downloads.experiencecloud.adobe.com/content/software-distribution/en/general.html)
+ [Maven 3.6+](https://maven.apache.org/)
+ [Git](https://git-scm.com/downloads)
+ [aem-guides-wknd.all.0.3.0.zip or greater](https://github.com/adobe/aem-guides-wknd/releases)
+ [aem-guides-wknd-graphql source code](https://github.com/adobe/aem-guides-wknd-graphql)

This tutorial assumes:

+ [Microsoft® Visual Studio Code](https://visualstudio.microsoft.com/) as the IDE
+ A working directory of `~/Code/wknd-app`
+ Running the AEM SDK as an Author service on `http://localhost:4502`
+ Running the AEM SDK with the local `admin` account with password `admin`
+ Running the SPA on `http://localhost:3000`

>[!NOTE]
>
> **Need help with setting up your local development environment?** Check out the [following guide to setting up a local development environment using the AEM as a Cloud Service SDK](https://experienceleague.adobe.com/docs/experience-manager-learn/cloud-service/local-development-environment-set-up/overview.html).


## Quick setup

Quick Setup gets you up and running with the WKND App SPA and AEM SPA Editor in 15 minutes. This accelerated setup takes you directly to the end-state of the tutorial, allowing you to explore authoring the SPA in AEM SPA Editor.

+ [Learn about quick setup](./quick-setup.md)

## 1. Configure AEM for SPA Editor

 AEM configurations are required to integrate the SPA with AEM SPA Editor. These configurations are managed and deployed via an AEM Project. In this chapter, learn about what configurations are necessary and how to define them.

+ [Learn how to configure AEM for SPA Editor](./aem-configure.md)

## 2. Bootstrap the SPA

For AEM SPA Editor to integrate a SPA into it's authoring context, a few additions must be made to the SPA.

+ [Learn how to bootstrap the SPA for AEM SPA Editor](./spa-bootstrap.md)

## 3. Editable fixed components

First, explore adding an editable "fixed component" to the SPA. This illustrates how a developer can place a specific editable component, in the SPA. While the author can change the component's content, they cannot remove the component or change its placement, positioning, or size.

+ [Learn about editable fixed components](./spa-fixed-component.md)

## 4. Editable container components

Next, explore adding an editable "container component" to the SPA. This illustrates how a developer can place a container component in the SPA. Container components allow authors to place allowed component in it, and adjust the layout of the components.

+ [Learn about editable container components](./spa-container-component.md)

## 5. Dynamic routes and editable components

Lastly, use the concepts explained in previous chapters to dynamic routes; routes that  display different content based on the route's parameter. This illustrates how AEM SPA Editor can be used to author content on routes that are programmatically driven and derived.

+ [Learn about dynamic routes and editable components](./spa-dynamic-routes.md)

## Additional resources

+ [Editing an External SPA within AEM Docs](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/implementing/developing/hybrid/editing-external-spa.html)
+ [AEM WCM Components - React Core implementation](https://www.npmjs.com/package/@adobe/aem-core-components-react-base)
+ [AEM WCM Components - Spa editor - React Core implementation](https://www.npmjs.com/package/@adobe/aem-core-components-react-spa)
