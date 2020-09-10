---
title: Creating Document Fragment
description: This is part 5 of a multi-step tutorial for creating your first interactive communications document. In this part, we will create document fragment to hold the recipient name and address. 
seo-description: This is part 5 of a multi-step tutorial for creating your first interactive communications document. In this part, we will create document fragment to hold the recipient name and address. 
uuid: 7fd8a0f2-a921-4e70-91c9-908dae9aeab2
feature: interactive-communication
topics: development
audience: developer
doc-type: tutorial
activity: implement
version: 6.4,6.5
discoiquuid: 47d3aa97-0bff-48e0-8a65-55e5332f811b
kt: 5958
thumbnail: 22350.jpg
---

# Creating Document Fragment

In this part, we will create document fragment to hold the recipient name and address.

>[!VIDEO](https://video.tv.adobe.com/v/22350/?quality=9&learn=on)

Document fragments hold the text content of interactive communication documents. This text content can be static text or inserted from the underlying data model elements values. For example **Dear _{name}_**, where Dear is static text and name is the form data model element name. At runtime, this will resolve to **Dear Gloria Rios** or **Dear John Jacobs** depending on the value of the name element.

Rich text editor is intuitive enough for a business user to author text and inserts form data elements. The document fragment editor has the ability to format text, specify font types and styles, ability to insert special characters and create hyperlinks.

Document fragment editor also has the ability to insert inline conditions in your text as demonstrated in this [video](https://helpx.adobe.com/experience-manager/kt/forms/using/editing-improvements-correspondence-mgmt-feature-video-use.html)

>[!NOTE]
>
>Make sure the Form Data Model elements you insert into a document fragments are descendants of the root element. For example in this use case make sure the User object's elements that you select is the child of the balances object

