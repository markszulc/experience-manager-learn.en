---
title: Develop Sling Model Exporters in AEM
description: This technical walk through walks through setting up AEM for use with Sling Model Exporter, enhancing an existing Sling Model using the Exporter framework to rendition as JSON, and how to use Exporter options and Jackson annotations to further customize the output.
version: 6.3, 6.4, 6.5
sub-product: foundation, content-services
feature: sling-models, sling-model-exporter
topics: content-delivery, development, headless
activity: develop
audience: developer
doc-type: technical-video
---

# Develop Sling Model Exporters

This technical walk through walks through setting up AEM for use with Sling Model Exporter, enhancing an existing Sling Model using the Exporter framework to rendition as JSON, and how to use Exporter options and Jackson annotations to further customize the output.

Sling Model Exporter was introduced in Sling Models v1.3.0. This new feature allows new annotations to be added to Sling Models that define how the Model an can be exported as a different Java object, or more commonly, serialized into a different format such as JSON.

Apache Sling provides a Jackson JSON exporter to cover the most common case of exporting Sling Models as JSON objects for consumption by programmatic web consumers such as other web services and JavaScript applications.

## Configuring AEM for Sling Model Exporter

>[!VIDEO](https://video.tv.adobe.com/v/16862/?quality=12)

[!DNL Sling Model Exporter] is a feature of the [!DNL Apache Sling] project and not directly bound to the AEM product release cycle. [!DNL Sling Model Exporter] is compatible with AEM 6.3 and later.

## The use-case for [!DNL Sling Model Exporter]

>[!VIDEO](https://video.tv.adobe.com/v/16863/?quality=12)

[!DNL Sling Model Exporter] is perfect for leveraging Sling Models that already contain business logic that support HTML renditions via HTL (or formerly JSP), and expose the same business representation as JSON for consumption by programmatic Web services or JavaScript applications.

## Creating a Sling Model Exporter

>[!VIDEO](https://video.tv.adobe.com/v/16864/?quality=12)

Enabling [!DNL Exporter] support on a [!DNL Sling Model] is as easy as adding the `@Exporter` annotation to the Java class.

## Applying Sling Model Exporter options

>[!VIDEO](https://video.tv.adobe.com/v/16865/?quality=12)

[!DNL Sling Model Exporter] supports passing per-model Exporter options to the Exporter implementation to drive how the [!DNL Sling Model] is finally exported. These options generally apply "globally" to how the [!DNL Sling Model] is exported, versus per data point which can be done via inline annotations described below.

[!DNL Jackson Exporter] options include:

* [Mapper Feature options](https://static.javadoc.io/com.fasterxml.jackson.core/jackson-databind/2.8.5/com/fasterxml/jackson/databind/MapperFeature.html)
* [Serialization Feature options](https://static.javadoc.io/com.fasterxml.jackson.core/jackson-databind/2.8.5/com/fasterxml/jackson/databind/SerializationFeature.html)

## Applying [!DNL Jackson] annotations

>[!VIDEO](https://video.tv.adobe.com/v/16866/?quality=12)

Exporters implementations may also support annotations that can be applied inline on the [!DNL Sling Model] class, that can provide a finer level of control how the data is exported.

* [[!DNL Jackson Exporter] annotations](https://github.com/FasterXML/jackson-annotations/wiki/Jackson-Annotations)

## View the code {#view-the-code}

[SampleSlingModelExporter.java](https://github.com/Adobe-Consulting-Services/acs-aem-samples/tree/master/bundle/src/main/java/com/adobe/acs/samples/models/SampleSlingModelExporter.java) 

## Supporting materials {#supporting-materials}

* [[!DNL Jackson Mapper] Feature Javadoc](https://static.javadoc.io/com.fasterxml.jackson.core/jackson-databind/2.8.5/com/fasterxml/jackson/databind/MapperFeature.html)
* [[!DNL Jackson Serialization] Feature Javadoc](https://static.javadoc.io/com.fasterxml.jackson.core/jackson-databind/2.8.5/com/fasterxml/jackson/databind/SerializationFeature.html)  

* [[!DNL Jackson Annotations] Docs](https://github.com/FasterXML/jackson-annotations/wiki/Jackson-Annotations)
