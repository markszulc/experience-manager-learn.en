---
title: Using Cascading Metadata in AEM Assets
seo-title: Using Cascading Metadata in AEM Assets
description: Advanced metadata management allows users to create cascading field rules to form contextual relationships between metadata in AEM Assets. The video below demonstrates new dynamic rules for field requirement, visibility, and contextual choices. The video also details the steps needed for an administrator to apply these rules to a custom metadata schema.
seo-description: Advanced metadata management allows users to create cascading field rules to form contextual relationships between metadata in AEM Assets. The video below demonstrates new dynamic rules for field requirement, visibility, and contextual choices. The video also details the steps needed for an administrator to apply these rules to a custom metadata schema.
uuid: 470c1b1a-f888-4c90-87d7-acfa9a5fa6b1
discoiquuid: ccd1acb1-bb7f-48c2-91e0-cccbeedad831
topics: metadata 
audience: all
doc-type: feature video
activity: use
version: 6.3, 6.4, 6.5
---

# Using Cascading Metadata in AEM Assets{#using-cascading-metadata-in-aem-assets}

Advanced metadata management allows users to create cascading field rules to form contextual relationships between metadata in AEM Assets. The video below demonstrates new dynamic rules for field requirement, visibility, and contextual choices. The video also details the steps needed for an administrator to apply these rules to a custom metadata schema.

>[!VIDEO](https://video.tv.adobe.com/v/20702/?quality=9&learn=on)

There are three dynamic rule sets that can be enabled for a given metadata field:

1. **Requirement** : a field can dynamically be marked as required to be based on the value of another dropdown field.

2. **Visibility** : fields can always be visible or only visible based on the value of another dropdown field.

3. **Choices** : (only applicable to dropdown fields) filter the choices shown to the user based on the currently selected value of another dropdown field.

>[!NOTE]
>
>Cascading rules can ONLY be created based on the value(s) of a dropdown field. It is possible to apply all three rule sets to the same metadata field but as a best practice it is recommended to make each rule set dependent on the same metadata dropdown.

Download [Custom Metadata package](assets/cascade-metadata-values-001.zip)

## Additional Resources{#additional-resources}

Custom Metadata Schema created at: `/conf/global/settings/dam/adminui-extension/metadataschema/custom`. The below AEM package will apply custom schema to the folder: `/content/dam/we-retail/en/activities`:

