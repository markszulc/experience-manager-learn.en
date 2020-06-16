---
title: Determine Your Folder Structure and File Naming Convention
description: File naming is perhaps the most important decision you'll make when implementing Dynamic Media Classic. Folder structure is likewise important. Learn why it is so important and possible approaches to take for your folder structure and file names.
sub-product: dynamic-media
feature:
doc-type: tutorial
activity: develop
topics: development, authoring, configuring, architecture
audience: all
---

# Determine Your Folder Structure and File Naming Convention {#folder-structure-filenaming}

Before you jump in and start uploading all your content, it's wise to consider the folder structure you'll use and particularly your file naming convention. It'll likely save you time and having to redo tasks later. It's best to coordinate these decisions across all groups.

## Folder Hierarchy and File Naming Convention

File naming is generally the most important decision you make concerning implementation of Dynamic Media Classic. However to understand why it is important, let's first talk about your folder structure.

### Folder Hierarchy

Folder hierarchy is important to you and your company for organizational purposes only — your Dynamic Media Classic URLs only reference the asset name, not the folder or path. Regardless of where you upload a file, the URL will be the same. This is quite different from how most people organize their images and content for the web, but with Dynamic Media Classic it makes no difference.

Another important consideration is the number of assets or folders to store in each folder. If many assets are stored in a folder, performance will degrade when viewing assets in Dynamic Media Classic. Do not store thousands of assets in a folder. Instead, develop an organizational hierarchy with fewer than around 500 assets or folders within a given branch of your hierarchy. This a not a strict requirement, but it will help to maintain acceptable response times when viewing or searching assets. In effect, the recommendation is to create hierarchies that are wide and shallow rather than narrow and deep.

The easiest way to create your folders is to upload your entire folder structure using FTP, and enable the option **Include Subfolders**. This option causes Dynamic Media Classic to recreate the folder structure on the FTP site in Dynamic Media Classic.

We want you to consider your folder structure before you start uploading all your files because it is much easier to organize and manage your files and folders locally on your computer than it is inside Dynamic Media Classic. For instance, you can only drag and drop files, but not entire folders, inside Dynamic Media Classic.

### Folder Strategies

For your folder strategy consider what makes sense to your organization. Here are some common folder naming scenarios:

- Mirror web site or product breakdown. For example, if you sold clothing, you might have folders for Men, Women, and Accessories, and sub folders for Shirts andShoes.
- SKU or Product ID based strategy. For example, with retailers that have thousands of items, it might make sense to use SKU numbers or product IDs as folder names.
- Brand strategy. For example, manufacturers who have multiple brands might choose their brand names as top-level folders.

## File Naming Convention

How you choose to name your files is perhaps the most important early decision you will make regarding Dynamic Media Classic. This is because all assets in Dynamic Media Classic must have unique names, regardless of where they are stored in the account.

All URLs and transactions in Dynamic Media Classic are driven by an Asset ID, which is an asset's unique identifier in the database. When you upload a file, the Asset ID is created by taking the filename and removing the extension. For example, _896649.jpg_ gets Asset _ID 896649_.

Rules regarding Asset IDs:

- No two assets can have the same name within Dynamic Media Classic, regardless of what folder the assets are in.
- Names are case-sensitive. For example, Chair.jpg, chair.jpg, and CHAIR.jpg would create three different Asset IDs.
- As a best practice, Asset IDs should not contain blank spaces or symbols. Use of spaces and symbols make implementation more difficult because you will have to URL encode these characters. For example, a space " " becomes"%20."

Your naming convention is essentially how you integrate with Dynamic Media Classic. You do not typically integrate your back-office systems into Dynamic Media Classic because it is a closed system. It is a passive partner, waiting for instructions in the form of URLs.

Most users base their naming convention around their internal SKU or product IDs so that when a web page is called up with information about that SKU, the page can automatically look for an image that has a similar name. If there is no connection between the file name and the SKU or ID, then your back-office system will need to manually keep track of each file name, and a person will have to maintain those associations — in short, a lot of work for both the IT and content teams.

### File Naming Strategies

Your naming strategy should be flexible for future expansion, so you can avoid having to rename after you have launched. Here are some typical naming strategies:

**No alternate images.** In this scenario, you only have one image per product and no alternate or colored views. You would strictly name each image according to its unique SKU or product ID number. When the page loads, the page template calls to the Asset ID with the same SKU number.

| SKU/PID | Filename   | Asset ID |
| ------- | ---------- | -------- |
| 896649  | 896649.jpg | 896649   |
| SKU123  | SKU123.png | SKU123   |

This is a very simple system, and good if you have modest needs. However it is not very flexible. Just because you have no alternate images today does not mean you won't have those images tomorrow. The next scenario offers more flexibility.

**Using the image, alternate** **views,** **colored versions, swatches.** This strategy allows for alternate views and/ or colored views, if you have them. Rather than name the image after only the SKU, you add a modifier such as "\_1" and "\_2" for alternate views, and a color code of "\_RED" or "\_BLU" for colored views. If you have both colored images and alternate views for the same product, perhaps you would add "\_RED_1" and "\_RED_2" for the first and second red-colored view. Swatches would be named with the SKU, color code, and an "\_SW"extension.

| SKU/PID | Category                | Filename                                    | Asset ID                        |
| ------- | ----------------------- | ------------------------------------------- | ------------------------------- |
| AA123   | Alt views               | AA123_1.tif AA123_2.tif AA123_3.tif         | AA123_1 AA123_2 AA123_3         |
|         | Colored views           | AA123_BLU.tif AA123_RED.tif AA123_BROWN.tif | AA123_BLU AA123_RED AA123_BROWN |
|         | Swatches                | AA123_BLU_SW.tif                            | AA123_BLU_SW                    |
|         | Image Set or Swatch Set |                                             | AA123 or AA123_SET              | -- |

When dealing with set collections, such as Image Sets and Swatch Sets, the set itself must also have a unique name. So in this case, the set could be given the base SKU as its name, or the SKU with a "\_SET"extension.

### Naming Convention and Automation

One last word on the importance of naming convention. If you would like to use sets (such as Image Sets or Swatch Sets), a predictable naming convention will allow you to automate their creation. Any scripted method, such as a Batch Set Preset, which you'll learn about in a separate chapter, can be driven off a naming convention.

The alternate method is to manually create your sets. While manually creating image sets for 200 images may not be a big job, imagine if you have more than 100,000 images. This is when set creation automation becomes crucial.
