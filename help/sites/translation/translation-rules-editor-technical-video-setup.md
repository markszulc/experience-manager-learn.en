---
title: Set up Translation Rules in AEM
description: The Translation Configuration UI allows a user to manage rules for translating content in AEM Sites. This video details the creation of a new translation rule for a custom component.
feature: language-copy
topics: localization, content-architecture
audience: developer, administrator
doc-type: technical-video
activity: setup
version: 6.4, 6.5
---

# Setup Translation Rules {#set-up-translation-rules-in-aem}

The Translation Configuration UI allows a user to manage rules for translating content in AEM Sites. This video details the creation of a new translation rule for a custom component.

>[!NOTE]
>
> The video below was recorded on AEM 6.3. AEM 6.4+ introduces a new repository structure for storing the translation rules XML file. When using the Translation Configuration UI in AEM 6.4+ the rules are saved to the location `/conf/global/settings/translation/rules/translation_rules.xml`. See [Identifying Content to Translate](https://helpx.adobe.com/experience-manager/6-5/sites/administering/using/tc-rules.html) for more details.

>[!VIDEO](https://video.tv.adobe.com/v/18135/?quality=9)

Translation rules identify content in AEM to be extracted for translation. Out of the box translation rules cover common use cases such as Text components and alt text for Image components. Depending on a projects translation requirements additional rules may be need. In general translation rules allow users to specify:

1. Properties that should be translated based on path and/or resource type
2. Filters for properties that should NOT be translated
3. Referenced content that should be translated (i.e Images or Content Fragments)

The translation rules editor that will update the translation xml file. The Translation Configuration UI makes it easier to manage various translation rules and guards against typos when editing XML directly.

Access the Translation Configuration UI:

* **[!UICONTROL AEM Start Menu] &gt; [!UICONTROL Tools] &gt; [!UICONTROL General] &gt; [[!UICONTROL Translation Configuration]](http://localhost:4502/libs/cq/translation/translationrules/contexts.html)**

## Prior to AEM 6.3 {#prior-to-aem}

In prior AEM version translation rules were manually updated by editing an XML file located under the Translation workflow: `/etc/workflow/models/translation/translation_rules.xml`.

## Additional Resources {#additional-resources}

* [Identifying Content to Translate](https://helpx.adobe.com/experience-manager/6-5/sites/administering/using/tc-rules.html)
* [Translating Content for Multilingual Sites](https://helpx.adobe.com/experience-manager/6-5/sites/administering/using/translation.html)
* [https://helpx.adobe.com/experience-manager/6-5/sites/administering/using/tc-manage.html](https://helpx.adobe.com/experience-manager/6-5/sites/administering/using/tc-manage.html)
* [Translation Best Practices](https://helpx.adobe.com/experience-manager/6-5/sites/administering/using/tc-bp.html)
