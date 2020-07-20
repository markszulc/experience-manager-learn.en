---
title: Using Dynamic Media Viewers with Adobe Analytics and Adobe Launch
seo-title: Using Dynamic Media Viewers with Adobe Analytics and Adobe Launch
description: The Dynamic Media Viewers extension for Adobe Launch, along with the release of Dynamic Media Viewers 5.13, lets customers of Dynamic Media, Adobe Analytics, and Adobe Launch use events and data specific for the Dynamic Media Viewers in their Adobe Launch configuration.
seo-description: The Dynamic Media Viewers extension for Adobe Launch, along with the release of Dynamic Media Viewers 5.13, lets customers of Dynamic Media, Adobe Analytics, and Adobe Launch use events and data specific for the Dynamic Media Viewers in their Adobe Launch configuration. 
sub-product: dynamic-media, analytics
feature: asset-insights, media-player
topics: images, videos, renditions, authoring, integrations, publishing 
doc-type: feature video
audience : all
activity: use
version: 6.3, 6.4, 6.5
---

# Using Dynamic Media Viewers with Adobe Analytics and Adobe Launch{#using-dynamic-media-viewers-adobe-analytics-launch}

For customers with Dynamic Media and Adobe Analytics, you can now track usage of Dynamic Media Viewers on your website using the Dynamic Media Viewer Extension.

>[!VIDEO](https://video.tv.adobe.com/v/29308/?quality=12&learn=on)

>[!NOTE]
>
> Run Adobe Experience Manager in Dynamic Media Scene7 mode for this functionality. You also need to [integrate Adobe Experience Platform Launch with your AEM instance](https://docs.adobe.com/content/help/en/experience-manager-learn/sites/integrations/adobe-launch-integration-tutorial-understand.html).

With the introduction of the Dynamic Media Viewer extension, Adobe Experience Manager now offers advanced analytics support for assets delivered with Dynamic Media viewers (5.13), providing more granular control over event tracking when a Dynamic Media Viewer is used on a Sites page.

If you already have AEM Assets and Sites, you can integrate your Launch property with your AEM author instance. Once your launch integration is associated with your website, you can add a dynamic media components to your page with event tracking for viewers enabled.

For AEM Assets-only customers or Dynamic Media Classic customers, user can get embed code for a viewer and add it to the page. Launch Script libraries can then be manually added to the page for viewer event tracking.

The following table lists Dynamic Media Viewer events and their supported arguments:

<table>
   <tbody>
      <tr>
         <td>Viewer event name</td>
         <td>Argument reference</td>
      </tr>
      <tr>
         <td> COMMON </td>
         <td> %event.detail.dm.objID% </td>
      </tr>
      <tr>
         <td>&nbsp;</td>
         <td> %event.detail.dm.compClass% </td>
      </tr>
      <tr>
         <td>&nbsp;</td>
         <td> %event.detail.dm.instName% </td>
      </tr>
      <tr>
         <td>&nbsp;</td>
         <td> %event.detail.dm.timeStamp% </td>
      </tr>
      <tr>
         <td> BANNER <br></td>
         <td> %event.detail.dm.BANNER.asset% </td>
      </tr>
      <tr>
         <td>&nbsp;</td>
         <td> %event.detail.dm.BANNER.frame% </td>
      </tr>
      <tr>
         <td>&nbsp;</td>
         <td> %event.detail.dm.BANNER.label% </td>
      </tr>
      <tr>
         <td> HREF </td>
         <td> %event.detail.dm.HREF.rollover% </td>
      </tr>
      <tr>
         <td> ITEM </td>
         <td> %event.detail.dm.ITEM.rollover% </td>
      </tr>
      <tr>
         <td> LOAD </td>
         <td> %event.detail.dm.LOAD.applicationname% </td>
      </tr>
      <tr>
         <td><strong>&nbsp;</strong></td>
         <td> %event.detail.dm.LOAD.asset% </td>
      </tr>
      <tr>
         <td><strong>&nbsp;</strong></td>
         <td> %event.detail.dm.LOAD.company% </td>
      </tr>
      <tr>
         <td><strong>&nbsp;</strong></td>
         <td> %event.detail.dm.LOAD.sdkversion% </td>
      </tr>
      <tr>
         <td><strong>&nbsp;</strong></td>
         <td> %event.detail.dm.LOAD.viewertype% </td>
      </tr>
      <tr>
         <td><strong>&nbsp;</strong></td>
         <td> %event.detail.dm.LOAD.viewerversion% </td>
      </tr>
      <tr>
         <td> METADATA </td>
         <td> %event.detail.dm.METADATA.length% </td>
      </tr>
      <tr>
         <td>&nbsp;</td>
         <td> %event.detail.dm.METADATA.type% </td>
      </tr>
      <tr>
         <td> MILESTONE </td>
         <td> %event.detail.dm.MILESTONE.milestone% </td>
      </tr>
      <tr>
         <td> PAGE </td>
         <td> %event.detail.dm.PAGE.frame% </td>
      </tr>
      <tr>
         <td>&nbsp;</td>
         <td> %event.detail.dm.PAGE.label% </td>
      </tr>
      <tr>
         <td> PAUSE </td>
         <td> %event.detail.dm.PAUSE.timestamp% </td>
      </tr>
      <tr>
         <td> PLAY </td>
         <td> %event.detail.dm.PLAY.timestamp% </td>
      </tr>
      <tr>
         <td> SPIN </td>
         <td> %event.detail.dm.SPIN.framenumber% </td>
      </tr>
      <tr>
         <td> STOP </td>
         <td> %event.detail.dm.STOP.timestamp% </td>
      </tr>
      <tr>
         <td> SWAP </td>
         <td> %event.detail.dm.SWAP.asset% </td>
      </tr>
      <tr>
         <td> SWATCH </td>
         <td> %event.detail.dm.SWATCH.frame% </td>
      </tr>
      <tr>
         <td>&nbsp;</td>
         <td> %event.detail.dm.SWATCH.label% </td>
      </tr>
      <tr>
         <td> TARG </td>
         <td> %event.detail.dm.TARG.frame% </td>
      </tr>
      <tr>
         <td>&nbsp;</td>
         <td> %event.detail.dm.TARG.label% </td>
      </tr>
      <tr>
         <td> ZOOM </td>
         <td> %event.detail.dm.ZOOM.scale% </td>
      </tr>
   </tbody>
</table>

## Additional Resources{#additional-resources}

* [Integrating Adobe Experience Manager with Adobe Launch](https://docs.adobe.com/content/help/en/experience-manager-learn/sites/integrations/adobe-launch-integration-tutorial-understand.html)
* [Running Adobe Experience Manager on Dynamic Media Scene7 mode](https://helpx.adobe.com/experience-manager/6-5/assets/using/config-dms7.html)
* [Integrating Dynamic Media Viewers with Adobe Analytics and Adobe Launch](https://helpx.adobe.com/experience-manager/6-5/assets/using/launch.html)
