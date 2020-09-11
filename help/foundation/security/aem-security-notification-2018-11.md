---
title: AEM Security Notification (November 2018)
seo-title: AEM Security Notification (November 2018)
description: AEM Experience Manager Security Notification Dispatcher
seo-description: AEM Experience Manager Security Notification Dispatcher
version: 6.4
feature: dispatcher
topics: security
activity: understand
audience: all
doc-type: article
uuid: 3ccf7323-4061-49d7-ae95-eb003099fd77
discoiquuid: 9d181b3e-fbd5-476d-9e97-4452176e495c
---

# AEM Security Notification (November 2018)

## Summary

This article addresses a few recent and old vulnerabilities that were recently reported in AEM. Note that most identified vulnerabilities were known issues for the AEM product and mitigation have been previously identified, a new dispatcher version is available for the new vulnerabilities. Adobe also urges customers to complete the [AEM Security Checklist](https://helpx.adobe.com/experience-manager/6-5/sites/administering/using/security-checklist.html) and follow the relevant guidelines.

## Action Required

* AEM deployments should start using the latest Dispatcher version.
* The dispatcher security rules must be applied as per the recommended configuration.
* The [AEM Security Checklist](https://helpx.adobe.com/experience-manager/6-5/sites/administering/using/security-checklist.html) should be completed for AEM deployments.

## Vulnerabilities and Resolutions

| Issue | Resolution | Links |
|-------|------------|-------|
| Bypassing AEM Dispatcher rules | Install latest version of Dispatcher(4.3.1) and follow recommended dispatcher configuration. | See [AEM Dispatcher Release Notes](https://helpx.adobe.com/experience-manager/dispatcher/release-notes.html) and [Configuring Dispatcher](https://helpx.adobe.com/experience-manager/dispatcher/using/dispatcher-configuration.html). |
| URL filter bypass vulnerability that could be used to circumvent dispatcher rules - CVE-2016-0957 | This was fixed in an older version of Dispatcher, but now it is recommended that you install the latest version of Dispatcher (4.3.1) and follow recommended Dispatcher configuration. | See [AEM Dispatcher Release Notes](https://helpx.adobe.com/experience-manager/dispatcher/release-notes.html) and [Configuring Dispatcher](https://helpx.adobe.com/experience-manager/dispatcher/using/dispatcher-configuration.html). |
| XSS vulnerability related to stored SWF files | This has been addressed with security fixes released earlier. | Please see [AEM Security Bulletin APSB18-10](https://helpx.adobe.com/security/products/experience-manager/apsb18-10.html). |
| Password related Exploits | Follow recommendation in Security checklist for stronger passwords. | See [AEM Security Checklist](https://helpx.adobe.com/experience-manager/6-5/sites/administering/using/security-checklist.html) |
| Disk usage exposure for anonymous users | This issue has been resolved for AEM 6.1 and later, for AEM 6.0 the out of the box permissions can be modified to be more restrictive. | See [release notes](https://helpx.adobe.com/experience-manager/aem-previous-versions.html)for AEM 6.1 and older. |
| Exposure of Open Social Proxy for anonymous users | This has been resolved in versions starting from 6.0 SP2. | See [release notes](https://helpx.adobe.com/experience-manager/aem-previous-versions.html) for AEM 6.1 and older. |
| CRX Explorer Access on production instances | Managing CRX Explorer access is already covered in the Security Checklist, CRX Explorer should be removed from production author and publish and the security health check reports it if not removed. | See [AEM Security Checklist](https://helpx.adobe.com/experience-manager/6-4/sites/administering/using/security-checklist.html). |
| BGServlets is exposed | This has been resolved since AEM 6.2. | See [AEM 6.2 Release Notes](https://helpx.adobe.com/experience-manager/6-2/release-notes.html) |

>[!MORELIKETHIS]
>
>* [AEM Dispatcher User Guide](https://helpx.adobe.com/experience-manager/dispatcher/user-guide.html)
>* [AEM Dispatcher Release Notes](https://helpx.adobe.com/experience-manager/dispatcher/release-notes.html)
>* [AEM Security Bulletins](https://helpx.adobe.com/security.html#experience-manager)
