---
title: Using Dynamic Media 360 Videos and Custom Video thumbnail with AEM Assets
seo-title: Using Dynamic Media 360 Videos and Custom Video thumbnail with AEM Assets
description: Dynamic Media Viewer enhancements in AEM 6.5 includes the addition of support for 360 video rendering, 360 media viewers (video360Social and video360VR) and the ability to select custom video thumbnails.
seo-description: Dynamic Media Viewer enhancements in AEM 6.5 includes the addition of support for 360 video rendering, 360 media viewers (video360Social and video360VR) and the ability to select custom video thumbnails.
uuid: 44b91c22-635c-48c2-af27-49bdbfb61639
discoiquuid: 67d5e0f2-3fde-4ea7-9e53-4fc0cf8b9f2a
sub-product: dynamic-media
feature: video-profiles, viewer-presets
topics: images, videos, renditions, authoring, integrations, publishing, metadata 
doc-type: feature video
audience : all
activity: use
version: 6.3, 6.4, 6.5
---

# Using Dynamic Media 360 Videos and Custom Video thumbnail with AEM Assets

Dynamic Media Viewer enhancements in AEM 6.5 includes the addition of support for 360 video rendering, 360 media viewers (video360Social and video360VR) and the ability to select custom video thumbnails.

>[!VIDEO](https://video.tv.adobe.com/v/26391?quality=9&learn=on)

>[!NOTE]
>
>Video assumes that your AEM instance is running on Dynamic Media S7 mode.  [Instructions on setting up AEM with Dynamic Media can be found here](https://helpx.adobe.com/experience-manager/6-3/assets/using/config-dynamic-fp-14410.html). When you upload a video, by default, Dynamic Media processes the footage as a 360 video, if it has an aspect ratio of 2:1. i.e., width to height ratio is 2:1.

>[!NOTE]
>
>Dynamic Media 360 Media components support 360 videos only. 

## Dynamic Media 360 Videos

360-degree videos, also known as spherical videos are video recordings where a view in every direction is recorded at the same time, shot using an omnidirectional camera or collection of cameras. During playback on a flat display, the user has control of the viewing direction, and playback on mobile devices typically leverage built-in gyroscope control.  It lets you expand beyond the limits of single photography. Marketers can provide users an engaging experience with the help of 360 videos.  Let's get started. The panoramic image aspect ratio criterion can be modified in the company's DMS7 configuration by specifying the double property s7PanoramicAR at /conf/global/settings/cloudconfigs/dmscene7/jcr:content.

## Dynamic Media 360 Videos

Dynamic Media video now supports the ability to select a custom thumbnail for your video. A user can either select an existing asset from AEM Assets or select a video frame as the thumbnail.

## Dynamic 360 Media Viewers

<table> 
 <tbody>
   <tr>
      <td>&nbsp;</td>
      <td>**Video360Social Viewer**</td>
      <td>**Video360VR Viewer**</td>
   </tr>
   <tr>
      <td>Dynamic Media Run Mode</td>
      <td>Dynamic Media Scene7 Mode only</td>
      <td>Dynamic Media Scene7 Mode only<br>
         <br>
      </td>
   </tr>
   <tr>
      <td>Use Case</td>
      <td>
         <p>For websites and devices that don't support gyroscope</p>
         <p>&nbsp;</p>
      </td>
      <td>
         <p>Provides a Virtual Reality experience for a device&nbsp;that supports&nbsp;gyroscope&nbsp;</p>
      </td>
   </tr>
   <tr>
      <td>Audio - Stereo Mode</td>
      <td>No</td>
      <td>Yes</td>
   </tr>
   <tr>
      <td>Video Playback</td>
      <td>Yes</td>
      <td>Yes</td>
   </tr>
   <tr>
      <td>Point of view navigation</td>
      <td>
         <ul>
            <li>Mouse drag (on desktop systems)</li>
            <li>Swipe (touch devices)</li>
         </ul>
      </td>
      <td>
         <ul>
            <li>Mouse and drag options are disabled</li>
            <li>Uses built-in gyroscope</li>
         </ul>
      </td>
   </tr>
   <tr>
      <td>HTML5 Player</td>
      <td>Yes</td>
      <td>Yes</td>
   </tr>
   <tr>
      <td>Social sharing options</td>
      <td>Yes</td>
      <td>No</td>
   </tr>
</tbody>
</table>

## Additional Resources{#additional-resources}

[Configuring Dynamic Media in Scene7 mode](https://helpx.adobe.com/experience-manager/6-5/assets/using/config-dms7.html)
