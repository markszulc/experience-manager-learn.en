---
title: Using the Video Player in AEM Dynamic Media
seo-title: Using the Video Player in AEM Dynamic Media
description: AEM Dynamic Media video player used to rely on Flash runtime to support adaptive video streaming on desktop clients and browsers became more aggressive on flash-based content streaming. With the introduction of HLS (Apple's HTTP Live Streaming video delivery protocol), content can now be streamed without relying on flash.
seo-description: AEM Dynamic Media video player used to rely on Flash runtime to support adaptive video streaming on desktop clients and browsers became more aggressive on flash-based content streaming. With the introduction of HLS (Apple's HTTP Live Streaming video delivery protocol), content can now be streamed without relying on flash.
uuid: aac6f471-4bed-4773-890f-0dd2ceee381d
discoiquuid: b01cc46b-ef64-4db9-b3b4-52d3f27bddf5
sub-product: dynamic-media
feature: media-player, video-profiles
topics: videos, renditions, authoring, best-practices
doc-type: feature video
audience : all
activity: use
version: 6.3, 6.4, 6.5
---

# Using the Video Player in AEM Dynamic Media{#using-the-video-player-in-aem-dynamic-media}

AEM Dynamic Media video player used to rely on Flash runtime to support adaptive video streaming on desktop clients and browsers became more aggressive on flash-based content streaming. With the introduction of HLS (Apple's HTTP Live Streaming video delivery protocol), content can now be streamed without relying on flash.

>[!VIDEO](https://video.tv.adobe.com/v/16791/?quality=9&learn=on)

## Quick look into Non Flash Video Player {#quick-look-into-non-flash-video-player}

>[!VIDEO](https://video.tv.adobe.com/v/17429/?quality=9&learn=on)

HLS browser support is as follows, for unsupported browsers we fallback to progressive video delivery

<table> 
 <thead> 
  <tr> 
   <th> <p>Device</p> </th>
   <th> <p>Browser</p> </th>
   <th > <p>Video playback mode</p> </th>
  </tr>
 </thead>
 <tbody>
  <tr> 
   <td> <p>Desktop</p> </td>
   <td> <p>Internet Explorer 9 and 10</p> </td>
   <td> <p>Progressive download</p> </td>
  </tr>
  <tr>
   <td> <p>Desktop</p> </td>
   <td> <p>Internet Explorer 11+</p> </td>
   <td> <p>HLS video streaming</p> </td>
  </tr>
  <tr>
   <td> <p>Desktop</p> </td>
   <td> <p>Firefox 23-44</p> </td>
   <td> <p>Progressive download</p> </td>
  </tr>
  <tr> 
   <td> <p>Desktop</p> </td>
   <td> <p>Firefox 45 or later</p> </td>
   <td> <p>HLS video streaming</p> </td>
  </tr>
  <tr> 
   <td> <p>Desktop</p> </td>
   <td> <p>Chrome</p> </td>
   <td> <p>HLS video streaming</p> </td>
  </tr>
  <tr> 
   <td> <p>Desktop</p> </td>
   <td> <p>Safari (Mac)</p> </td>
   <td> <p>HLS video streaming</p> </td>
  </tr>
  <tr> 
   <td> <p>Mobile</p> </td>
   <td> <p>Chrome (Android 6 or earlier)</p> </td>
   <td> <p>Progressive download</p> </td>
  </tr>
  <tr> 
   <td> <p>Mobile</p> </td>
   <td> <p>Chrome (Android 7 or later)</p> </td>
   <td> <p>HLS video streaming</p> </td>
  </tr>
  <tr> 
   <td> <p>Mobile</p> </td>
   <td> <p>Android (Default browser)</p> </td>
   <td> <p>Progressive download</p> </td>
  </tr>
  <tr> 
   <td> <p>Mobile</p> </td>
   <td> <p>Safari (iOS)</p> </td>
   <td> <p>HLS video streaming</p> </td>
  </tr>
  <tr> 
   <td> <p>Mobile</p> </td>
   <td> <p>Chrome (iOS)</p> </td>
   <td> <p>HLS video streaming</p> </td>
  </tr>
  <tr> 
   <td> <p>Mobile</p> </td>
   <td> <p>Blackberry</p> </td>
   <td> <p>HLS video streaming</p> </td>
  </tr>
 </tbody>
</table>