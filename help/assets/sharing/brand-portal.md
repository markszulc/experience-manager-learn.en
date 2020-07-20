---
title: Using Brand Portal
seo-title: Using Brand Portal with AEM Assets
description: Video walk-throughs of the AEM Author and AEM Assets Brand Portal integration.
seo-description: Video walk-throughs of the AEM Author and AEM Assets Brand Portal integration.
feature: brand-portal
topics: authoring, sharing, collaboration, search, integrations, publishing, metadata, images, renditions, administration
audience: all
doc-type: feature video
activity: use
version: 6.3, 6.4, 6.5
team: tm
---

# Using Brand Portal with AEM Assets{#using-brand-portal-with-aem-assets}

Video guides of Adobe Experience Manager (AEM) Assets Brand Portal integration.

## Brand Portal September 2019 Feature and Enhancements

Brand Portal's September 2019 most notably introduces Asset Sourcing, which increases content velocity and allows for easy and quick exchange of assets between Experience Manager authors and third-party creatives and contributors.

### Brand Portal Asset Sourcing{#asset-sourcing}

Brand Portal's Asset Sourcing is used to collect assets from third-party agencies and teams, seamlessly syncing them back to Experience Manager Author for review and use.

>[!VIDEO](https://video.tv.adobe.com/v/29365/?quality=12&learn=on)

*Experience Manager Author 6.5 SP2 (6.5.2) or greater is required to use Asset Sourcing*

Review [Enable Experience Manager Author for Asset Sourcing](https://docs.adobe.com/content/help/en/experience-manager-brand-portal/using/asset-sourcing-in-brand-portal/configure-asset-sourcing-in-aem/brand-portal-enable-asset-sourcing.html) for instructions on how to configure and set up Asset Sourcing on Experience Manager Author.

## Brand Portal February 2019 Feature and Enhancements{#brand-portal-features-and-enhancements-644}

>[!VIDEO](https://video.tv.adobe.com/v/26354/?quality=9&learn=on)

Brand Portal's February 2019 release focuses on enhancements to text search and top customer requests.

### Search enhancements

Brand Portal enhances search with partial text search on property predicate in filtering pane. To allow partial text search you need to enable Partial Search in Property Predicate in the search form.

Read on to know more about partial text search and wildcard search.

#### Partial phrase search

You can now search for assets by specifying only a part—that is a word or two—of the searched phrase in filtering pane.

**Use case** : Partial phrase search is helpful when you are unsure of the exact combination of words occurring in the searched phrase.

For example, if your search form in Brand Portal uses Property Predicate for partial search on assets title, then specifying the term camp returns all the assets with the word camp in their title phrase.

#### Wildcard search

The Brand Portal allows using the asterisk (*) in search query along with a part of the word in your searched phrase.

**Use case** :If you are not sure of the exact words occurring in the searched phrase, you can use a wildcard search to fill the gaps in your search query.

For example, specifying climb* returns all the assets having words beginning with the characters climb in their title phrase if search form in Brand Portal uses Property Predicate for partial search on assets title.

Similarly, specifying:

* \*climb returns all the assets having words ending with characters climb in their title phrase.
* \*climb\* returns all the assets having words comprising the characters climb in their title phrase.

#### Enable Folder Hierarchy

Administrators can now configure how the folders are shown to non-admin users (Editors, Viewers, and Guest Users) on login. 
[Enable Folder Hierarchy](https://helpx.adobe.com/experience-manager/brand-portal/using/brand-portal-general-configuration.html) configuration is added in General Settings, in the admin tools panel. If the configuration is:

* Enabled, the folder tree starting from the root folder is visible to non-admin users. Thus, granting them a navigation experience similar to administrators.
* Disabled, only the shared folders are displayed on the landing page.

[Enable Folder Hierarchy](https://helpx.adobe.com/experience-manager/brand-portal/using/brand-portal-general-configuration.html) functionality (when enabled) helps you differentiate the folders with the same names shared from different hierarchies. On logging in, non-admin users now see the virtual parent (and ancestor) folders of the shared folders.

The shared folders are organized within the respective directories in virtual folders. You can recognize these virtual folders with a lock icon.

Note that the default thumbnail of the virtual folders is the thumbnail image of the first shared folder.

### Dynamic Media video renditions support

Users whose AEM Author instance is on Dynamic Media hybrid mode can preview and download the dynamic media renditions, in addition to the original video files.

To allow preview and download of dynamic media renditions on specific tenant accounts, administrators need to specify Dynamic Media Configuration (video service URL (DM-Gateway URL) and registration ID to fetch the dynamic video) in Video configuration from admin tools panel.

Dynamic Media videos can be previewed on:

* Asset details page
* Asset's card view
* Link share preview page

Dynamic Media Video encodes can be downloaded from:

* Brand Portal
* Shared link

### Scheduled publish to Brand Portal

Assets (and folders) publish workflow from [AEM (6.4.2.0)](https://helpx.adobe.com/experience-manager/6-5/release-notes/sp-release-notes.html#main-pars_header_9658011) Author instance to Brand Portal can be scheduled for a later date, time.

Similarly, published assets can be removed from the portal at a later date (time), by scheduling the Unpublish from Brand Portal workflow.

### Configurable tenant alias in URL

Organizations can get their portal URL customized, by having an alternate prefix in the URL. To get an alias for tenant name in their existing portal URL, organizations need to contact Adobe support.

Note that only the prefix of the Brand Portal URL can be customized and not the entire URL.
For example, an organization with existing domain `wknd.brand-portal.adobe.com` can get `wkndinc.brand-portal.adobe.com` created on request.

However, AEM Author instance can be [configured](https://helpx.adobe.com/experience-manager/6-5/assets/using/brand-portal-configuring-integration.html) only with the tenant id URL and not with tenant alias (alternate) URL.

**Use case** : Organizations can meet their branding needs by getting the portal URL customized, instead of sticking to the URL provided by Adobe.

## Brand Portal December 2018 Feature and Enhancements{#brand-portal-features-and-enhancements-642}

>[!VIDEO](https://video.tv.adobe.com/v/23707/?quality=9&learn=on)

### Guest Access

AEM Brand portal allows guest access to the portal. A guest user doesn't require credentials to enter the portal and can access and download all the public folders and collections. Guest users can add assets to their light-box (private collection) and download the same. They can also view smart tag search and search predicates set by administrators. The guest session does not allow users to create collections and saved searches or share them further, access folder and collections settings, and share assets as links.

### Accelerated Download

Brand Portal users can leverage Aspera based fast downloads to get speeds up to 25x faster and enjoy a seamless download experience irrespective of their location across the globe. To download the assets faster from Brand Portal or shared link, users need to select Enable Download Acceleration option in download dialog, provided download acceleration is enabled on their organization.

* [Guide to accelerate downloads from Brand Portal](https://helpx.adobe.com/experience-manager/brand-portal/using/accelerated-download.html#main-pars_header)
* [Aspera Connect Test Server](https://test-connect.asperasoft.com/)

### User Login Report

A new report, to track user logins, has been introduced. The User Logins report can be instrumental in enabling organizations to audit and keep a check on the delegated administrators and other users of Brand Portal.

The report logs display names, email IDs, personas (admin, viewer, editor, guest), groups, last login, activity status, and login count of each user.

### Access to Original Renditions

 Administrators can restrict user access to original image files (jpeg, tiff, png, bmp, gif, pjpeg, x-portable-anymap, x-portable-bitmap, x-portable-graymap, x-portable-pixmap, x-rgb, x-xbitmap, x-xpixmap, x-icon, image/photoshop, image/x-photoshop, psd, image/vnd.adobe.photoshop) and give access to low-resolution renditions which they download from Brand Portal or shared link. This access can be controlled at user group level from Groups tab of User Roles page in admin tools panel.

### New Configurations

Six new configurations are added for administrators to enable/disable following functionalities on specific tenants:

* Allow Guest Access
* Allow users to request access to Brand Portal
* Allow administrators to delete assets from Brand Portal
* Allow creation of public collections
* Allow creation of public smart collections
* Allow Download Acceleration

### Other enhancements

* *Folder hierarchy path on card and list views* — enables users to know the location of the folders stored within a Brand Portal instance. Helps users to differentiate folders having same name within different folder hierarchy. 
* *Overview option* — provides non-admin users metadata about the asset/folder by selecting the asset/folder and then selecting the overview option from the toolbar. Currently, displays title, date created and path

### Adobe I/O Hosts UI to configure oAuth Integrations

Brand Portal uses Adobe I/O [https://legacy-oauth.cloud.adobe.io/](https://legacy-oauth.cloud.adobe.io/) interface to create JWT application, which enables configuring oAuth integrations to allow AEM Assets integration with Brand Portal. Previously, the UI for configuring OAuth integrations was hosted in `https://marketing.adobe.com/developer/`. To know more about integrating AEM Assets with Brand Portal for publishing assets and collections to Brand Portal refer [Configure AEM Assets integration with Brand Portal](https://helpx.adobe.com/experience-manager/6-4/assets/using/brand-portal-configuring-integration.html).

## Brand Portal February 2018 Feature and Enhancements{#brand-portal-features-and-enhancements-632}

New features enhanced functionality oriented toward aligning Brand Portal with AEM.

>[!VIDEO](https://video.tv.adobe.com/v/26354/?quality=9&learn=on)

### Navigational Improvements

* Upgraded User Interface that aligns with the AEM and uses Coral3 UI.
* Quick and easy access to administrative tools through the new Adobe logo.
* Product navigation through an overlay
* Quick Navigation to parent folders from a child folder.
* Omnisearch option to navigate to administrative tools and content.
* Card View, List view, and Column View help you to easily browse through nested folders.
* Asset sorting in List View is no longer restricted to the number of assets being displayed on the screen. All assets in a folder are sorted.

### Search Improvements

* Omnisearch capability lets you perform a quick search for assets and files within Brand Portal.
* Omnisearch also provides an option to search for assets within a specific folder or location
* Automatic keyword suggestions to make search easier
* Improve your Omnisearch with additional filters. Option to save the search result into a Smart Collection for you to re-visit your search at a later time.
* Supports smart tagged asset search
* AEM Smart tagged assets can be shared from AEM to Brand Portal and use smart tags for asset search within Brand Portal.

### File Sharing Improvements

* The user can share an asset using the link share option. 
* While sharing assets, the user gets to set an expiry date for each asset. Provides users more control over the assets shared. 
* An external user with Asset share link can download the image and view its properties.
* The original nested folder hierarchy is preserved for downloaded asset folders.

### Reporting and Administrative Capabilities

* Metadata schema from AEM Assets can now be published from AEM to Brand Portal.
* Administrators can create and manage three types of reports—assets downloaded, expired, and published
* Ability to configure the column that needs to be included in the report.
* Create Image Presets for assets within Brand Portal.
* Ability to modify Admin Search Rail Form or Search Forms to include additional filtering options.
* Update and preview custom wallpaper for your brand
* Usage report to know about the number of users, storage space used and total assets.

## Additional Resources{#additional-resources}

* [What's new in in Brand Portal](https://helpx.adobe.com/experience-manager/brand-portal/using/whats-new.html)
* [AEM Author replication agents](https://helpx.adobe.com/experience-manager/6-5/assets/using/brand-portal-configuring-integration.html)
* [Guide to Accelerated Download](https://helpx.adobe.com/experience-manager/brand-portal/using/accelerated-download.html#main-pars_header)
* [AEM Assets Brand Portal Adobe Docs](https://helpx.adobe.com/experience-manager/brand-portal/using/brand-portal.html)
* [AEM Assets Dynamic Media Adobe Docs](https://docs.adobe.com/docs/en/aem/6-3/author/assets/dynamic-media.html)
* [Download Aspera Connect](https://downloads.asperasoft.com/connect2/)
* [Aspera Connect Test Server](https://test-connect.asperasoft.com/)