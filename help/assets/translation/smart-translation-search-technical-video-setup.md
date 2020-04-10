---
title: Set up Smart Translation Search with AEM Assets
seo-title: Set up Smart Translation Search with AEM Assets
description: Smart Translation Search allows the use of non-English search terms to resolve to English content. To set up AEM for Smart Translation Search, the Apache Oak Search Machine Translation OSGi bundle must be installed and configured, as well as the pertinent free and open source Apache Joshua language packs that contain the translation rules.
seo-description: Smart Translation Search allows the use of non-English search terms to resolve to English content. To set up AEM for Smart Translation Search, the Apache Oak Search Machine Translation OSGi bundle must be installed and configured, as well as the pertinent free and open source Apache Joshua language packs that contain the translation rules.
uuid: b0e8dab2-6bc4-4158-91a1-4b9811359798
discoiquuid: 4db1b4db-74f4-4646-b5de-cb891612cc90
topics: authoring, search, metadata, localization
audience: administrator, developer
doc-type: technical-video
activity: setup
version: 6.3, 6.4, 6.5
---

# Set up Smart Translation Search with AEM Assets{#set-up-smart-translation-search-with-aem-assets}

Smart Translation Search allows the use of non-English search terms to resolve to English content. To set up AEM for Smart Translation Search, the Apache Oak Search Machine Translation OSGi bundle must be installed and configured, as well as the pertinent free and open source Apache Joshua language packs that contain the translation rules.

>[!VIDEO](https://video.tv.adobe.com/v/21291/?quality=9)

>[!NOTE]
>
>Smart Translation Search must be set up on each AEM instance that requires it.

1. Download and install the Oak Search Machine Translation OSGi bundle
    * [Download the Oak Search Machine Translation OSGi bundle](https://search.maven.org/#search%7Cgav%7C1%7Cg%3A%22org.apache.jackrabbit%22%20AND%20a%3A%22oak-search-mt%22) that corresponds to AEM's Oak version.
    * Install the downloaded Oak Search Machine Translation OSGi bundle into AEM via [ `/system/console/bundles`](http://localhost:4502/system/console/bundles).

2. Download and update the Apache Joshua language packs
    * Download and unzip the desired [Apache Joshua language packs](https://cwiki.apache.org/confluence/display/JOSHUA/Language+Packs).
    * Edit the `joshua.config` file and comment out the 2 lines that begin with:

      ```    
      feature-function = LanguageModel ...
      
      ```

    * Determine and record the size of the language pack's model folder, as this influence how much extra heap space AEM will require.  
    * Move the unzipped Apache Joshua language pack folder (with the `joshua.config` edits) to

      ```    
      .../crx-quickstart/opt/<source_language-target_language>

      ```    
    
      For example:    
    
      ```    
             
       .../crx-quickstart/opt/es-en
      ```

3. Restart AEM with updated heap memory allocation
    * Stop AEM
    * Determine the new required heap size for AEM

        * AEM's pre-language-lack heap size + the size of the model directory rounded up to the nearest 2GB
        * For example: If pre-language packs the AEM installation requires 8GB of heap to run, and the language pack's model folder is 3.8GB uncompressed, the new heap size is:  
  
          The original `8GB` + ( `3.75GB` rounded up to the nearest `2GB`, which is `4GB`) for a total of `12GB`

    * Verify the machine has this amount of extra available memory.
    * Update AEM's start-up scripts to adjust for the new heap size

        * Ex. `java -Xmx12g -jar cq-author-p4502.jar`

    * Restart AEM with the increased heap size.

   >[!NOTE]
   >
   >The required heap space for language packs can grow large, especially when multiple language packs are used.
   >
   >
   >Always make sure **the instance have enough memory** to accommodate the increases in allocated heap space.
   >
   >
   >The **base heap must always be calculated to support acceptable performance without any language packs** installed.

4. Register the language packs via Apache Jackrabbit Oak Machine Translation Full-text Query Terms Provider OSGi configurations

    * For each language pack, [create a new Apache Jackrabbit Oak Machine Translation Full-text Query Terms Provider OSGi configuration](http://localhost:4502/system/console/configMgr/org.apache.jackrabbit.oak.plugins.index.mt.MTFulltextQueryTermsProviderFactory) via the AEM Web Console's Configuration manager.

        * `Joshua Config Path` is the absolute path to the joshua.config file. The AEM process must be able to read all files in the language pack's folder.
        * `Node types` are the candidate node types whose full-text search will engage this language pack for translation.
        * `Minimum score` is the minimum confidence score for a translated term for it to be used.

            * For example, hombre (Spanish for "man") may translate to the english word "man" with a confidence score of `0.9` and also translate to the english word "human" with a confidence score `0.2`. Tuning the minimum score to `0.3`, would keep the "hombre" to "man" translation, but discard the 'hombre' to "human" translation as this translation score of `0.2` is less than the minimum score of `0.3`.

5. Perform a full-text search against assets
    * Becasue dam:Asset is the node type this language pack is registered again, we must search for AEM Assets using full-text search to validate this.
    * Navigate to AEM &gt; Assets and open Omnisearch. Search for a term in the language whose language pack was installed.
    * As needed, tune the Minimum Score in the OSGi configurations to ensure the accuracy of results.

6. Updating language packs
    * Apache Joshua language packs are wholey maintained by the Apache Joshua project, and their updating or correction is as the discretion of the Apache Joshua project.
    * If a language pack is updated, in order install the updates in AEM, the above steps 2 - 4 must be followed, adjusting the heap size up or down as needed.

        * Note that when moving the unzipped language pack to the crx-quickstart/opt folder, move any existing language pack folder before copying in the new.

    * If AEM does not require a restart, then the relevant Apache Jackrabbit Oak Machien Translation Fulltext Query Terms Provider OSGi configuration(s) that pertain to the updated language pack(s) must be re-saved so AEM processes the updated files.

## Updating damAssetLucene Index {#updating-damassetlucene-index}

In order for [AEM Smart Tags](https://helpx.adobe.com/experience-manager/6-3/assets/using/touch-ui-smart-tags.html) to be affected by AEM Smart Translation, AEM's `/oak   :index  /damAssetLucene` index must be updated to mark the predictedTags (the system name for "Smart Tags") to be part of the Asset's aggregate Lucene index.

Under `/oak:index/damAssetLucene/indexRules/dam:Asset/properties/predicatedTags`, ensure the configuration is as follows:

```xml
 <damAssetLucene jcr:primaryType="oak:QueryIndexDefinition">
        <indexRules jcr:primaryType="nt:unstructured">
            <dam:Asset jcr:primaryType="nt:unstructured">
                <properties jcr:primaryType="nt:unstructured">
                    ...
                    <predictedTags
                        jcr:primaryType="nt:unstructured"
                        isRegexp="{Boolean}true"
                        name="jcr:content/metadata/predictedTags/*/name"
                        useInSpellheck="{Boolean}true"
                        useInSuggest="{Boolean}true"
                        analyzed="{Boolean}true"
                        nodeScopeIndex="{Boolean}true"/>
```

## Additional Resources{#additional-resources}

* [Apache Oak Search Machine Translation OSGi bundle](https://search.maven.org/#search%7Cgav%7C1%7Cg%3A%22org.apache.jackrabbit%22%20AND%20a%3A%22oak-search-mt%22)
* [Apache Joshua Language Packs](https://cwiki.apache.org/confluence/display/JOSHUA/Language+Packs)
* [AEM Smart Tags](https://helpx.adobe.com/experience-manager/6-3/assets/using/touch-ui-smart-tags.html)
* [Best Practices for Querying and Indexing](https://helpx.adobe.com/experience-manager/6-5/sites/deploying/using/best-practices-for-queries-and-indexing.html)