---
title: Understanding Adobe IMS authentication with AEM on Adobe Managed Services
description: Adobe Experience Manager introduces Admin Console support for AEM instances and Adobe IMS (Identity Management System) based authentication for AEM on Managed Services.   This integration allows AEM Managed Services customers to manage all Experience Cloud users in a single unified Web console. Users and Groups can be assigned to product profiles associated with AEM instances, granting centrally managed access to the specific AEM instances.
version: 6.4, 6.5
feature: authentication
topics: authentication, security
activity: understand
audience: administrator, architect, developer, implementer
doc-type: technical video
kt: 781
---

# Understanding Adobe IMS authentication with AEM on Adobe Managed Services{#understanding-adobe-ims-authentication-with-aem-on-adobe-managed-services}

Adobe Experience Manager introduces Admin Console support for AEM instances and Adobe IMS (Identity Management System) based authentication for AEM on Managed Services.   This integration allows AEM Managed Services customers to manage all Experience Cloud users in a single unified Web console. Users and groups can be assigned to product profiles associated with AEM instances, granting centrally managed access to the specific AEM instances.

>[!VIDEO](https://video.tv.adobe.com/v/26170?quality=12&learn=on)

* Adobe Experience Manager IMS authentication support is only for "internal" users (authors, reviewers, administrators, developers, etc.), and not external end-users such as web site visitors.
* [Admin Console](https://adminconsole.adobe.com/) will represent AEM Managed Services customers as IMS Orgs and the AEM instances as Product Contexts. Admin Console System and Product Admins can define and manage.
* AEM Managed Services sync your topology with Admin Console, creating a 1-to-1 mapping between a Product Context and AEM instance.
* Product Profile in Admin Console will determine which AEM instances a user can access.
* Authentication support includes customer SAML2 compliant IDPs for SSO.
* Only Enterprise or Federated IDs (for customer SSO) will be supported (Personal Adobe IDs are not supported).

*&#42; This feature is supported for AEM 6.4 SP3 and later for Adobe Managed Services customers.*

## Best practices {#best-practices}

### Applying permissions in Admin Console

Applying permissions and access at the user level should be avoided in both Admin Console and in Adobe Experience Manager.

In Admin Console users should be granted access via User Groups at the Product Context level. User groups are typically best expressed by logical role within the organization to promote the groups' re-usability across Adobe Experience Cloud products.

>[!NOTE]
>
> If using AEM as a Cloud Service, assign Admin Console users directly to Product Profiles. Transitive permissions between Admin Console users to Product Profiles via Admin Console user groups is not supported for AEM as a Cloud Service.

### Applying permissions in Adobe Experience Manager

In Adobe Experience Manager, user groups synced from Adobe IMS should be in term added to [AEM-provided user groups](https://helpx.adobe.com/experience-manager/6-4/sites/administering/using/security.html), which come preconfigured with the appropriate permissions to execute specific sets of tasks in AEM. Users synced from Adobe IMS should not be directly added to [AEM-provided user groups](https://helpx.adobe.com/experience-manager/6-4/sites/administering/using/security.html). 
