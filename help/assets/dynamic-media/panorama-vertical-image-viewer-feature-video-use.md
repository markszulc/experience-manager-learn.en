---
title: Using Panorama and Vertical Image Viewer with AEM Assets Dynamic Media
seo-title: Using Panorama and Vertical Image Viewer with AEM Assets Dynamic Media
description: Dynamic Media Viewer enhancements in AEM 6.4 includes the addition of Panoramic Image Viewer, Panoramic Virtual Reality Image Viewer, and Vertical Image Viewer. Panoramic Viewer provides an easy way to deliver an engaging, immersive experience of the room, property, location or landscape without any custom development.
seo-description: Dynamic Media Viewer enhancements in AEM 6.4 includes the addition of Panoramic Image Viewer, Panoramic Virtual Reality Image Viewer, and Vertical Image Viewer. Panoramic Viewer provides an easy way to deliver an engaging, immersive experience of the room, property, location or landscape without any custom development.
uuid : a9f33fe7-cc6e-41d0-943d-387d98abc27f
sub-product: dynamic-media
feature: video-profiles, video-profiles, vr-360
topics: videos, renditions, authoring
doc-type: feature video
audience : all
activity: use
version: 6.4, 6.5
---

# Using Panorama and Vertical Image Viewer with AEM Assets Dynamic Media{#using-panorama-and-vertical-image-viewer-with-aem-assets-dynamic-media}

Dynamic Media Viewer enhancements in AEM 6.4 includes the addition of Panoramic Image Viewer, Panoramic Virtual Reality Image Viewer, and Vertical Image Viewer. Panoramic Viewer provides an easy way to deliver an engaging, immersive experience of the room, property, location or landscape without any custom development.

>[!VIDEO](https://video.tv.adobe.com/v/24156/?quality=9&learn=on)

>[!NOTE]
>
>Video assumes that your AEM instance is running on Dynamic Media S7 mode. [Instructions on setting up AEM with Dynamic Media can be found here.](https://helpx.adobe.com/experience-manager/6-3/assets/using/config-dynamic-fp-14410.html)

## Panoramic and Panoramic VR Viewer

An image is considered panoramic based on its aspect ratio or keywords. By default, an image with aspect ratio of 2 will be considered as a panoramic image. Panoramic Image viewer presets will become available for an image preview if it satisfies the above criteria. The panoramic image aspect ratio criterion can be modified in the company's DMS7 configuration by specifying the double property s7PanoramicAR at /conf/global/settings/cloudconfigs/dmscene7/jcr:content. The keywords are stored in the dc:keyword property of the asset's metadata node. If the keywords contain any of the following combination :

* equirectangular,
* spherical + panoramic,
* spherical + panorama,

it will be considered as a Panoramic Image asset regardless of its aspect ratio.

## Vertical Image Viewer

With horizontal swatches, depending on the consumer’s desktop screen size, sometimes the swatches would not be visible until user scrolls down the page. By using vertical image viewer and placing vertical swatches, it ensures that the swatches are visible no matter what the screen size is. It also maximizes the main image size. With horizontal swatches, it was necessary to reserve space on the page to ensure they have a high likelihood of being visible and would decrease the size of the main image. With a vertical layout, you do not need to worry about allocating this space and therefore can maximize the main image size.

<table> 
 <tbody>
  <tr>
   <td> </td>
   <td>Panoramic and VR Viewer</td>
   <td>Vertical Image Viewer</td>
  </tr>
  <tr>
   <td>Dynamic Media Run Mode</td>
   <td>Dynamic Media Scene7 Mode only</td>
   <td>DMS7 and Dynamic Media</td>
  </tr>
  <tr>
   <td>Use Case</td>
   <td><p>Panoramic viewer and Virtual Reality viewer provide users a more engaging experience. A user can check out a hotel room even before he or she makes a booking, or check out a rental property without having to schedule an appointment. A user can check out a location and many more possibilities. The primary focus here is to provide consumer a better experience when they visit your website and eventually increase your conversion rate.</p> <p> </p> </td> 
   <td><p>Vertical Image viewer helps maximize product imagery viewing experience to give consumers the best representation of the product, thereby driving conversion and minimizing returns.</p> <p> </p> </td>
  </tr>
  <tr>
   <td>Available </td>
   <td>OOTB</td>
   <td>OOTB</td>
  </tr>
 </tbody>
</table>

[Configuring Dynamic Media in Scene7 mode](https://helpx.adobe.com/experience-manager/6-5/assets/using/config-dms7.html)

[Configuring Dynamic Media in Hybrid mode](https://helpx.adobe.com/experience-manager/6-5/assets/using/config-dynamic.html)

>[!NOTE]
>
>Panoramic viewers work with panoramic images and are not meant to be used with normal images.
