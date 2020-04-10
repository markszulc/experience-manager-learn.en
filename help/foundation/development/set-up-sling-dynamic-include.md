---
title: Set up Sling Dynamic Include for AEM
description: A video walk-through of installing and using Apache Sling Dynamic Include with AEM Dispatcher running on Apache HTTP Web Server.
version: 6.3, 6.4, 6.5
sub-product: foundation, sites
feature: core-components, dispatcher
topics: caching
activity: develop
audience: architect, developer
doc-type: technical-video
---

# Set up [!DNL Sling Dynamic Include]

A video walk-through of installing and using [!DNL Apache Sling Dynamic Include] with [AEM Dispatcher](https://docs.adobe.com/content/help/en/experience-manager-dispatcher/using/dispatcher.html) running on [!DNL Apache HTTP Web Server].

>[!VIDEO](https://video.tv.adobe.com/v/17040/?quality=12)

>[!NOTE]
>
> Ensure the latest version of AEM Dispatcher is installed locally.

1. Download and install the [[!DNL Sling Dynamic Include] bundle](https://sling.apache.org/downloads.cgi).
1. Configure [!DNL Sling Dynamic Include] via the [!DNL OSGi Configuration Factory] at **http://&lt;host&gt;:&lt;port&gt;/system/console/configMgr/org.apache.sling.dynamicinclude.Configuration**.

   Or, to add to an AEM code-base, create the appropriate **sling:OsgiConfig** node at:

   ```xml
   <?xml version="1.0" encoding="UTF-8"?>
   <jcr:root xmlns:sling="http://sling.apache.org/jcr/sling/1.0" xmlns:cq="http://www.day.com/jcr/cq/1.0"
       xmlns:jcr="http://www.jcp.org/jcr/1.0" xmlns:nt="http://www.jcp.org/jcr/nt/1.0"
       jcr:primaryType="sling:OsgiConfig"
       include-filter.config.enabled="{Boolean}true"
       include-filter.config.path="/content"
       include-filter.config.resource-types="[my-app/components/content/highly-dynamic]"
       include-filter.config.include-type="SSI" 
       include-filter.config.add_comment="{Boolean}false"
       include-filter.config.selector="nocache"
       include-filter.config.ttl=""
       include-filter.config.required_header="Server-Agent=Communique-Dispatcher"
       include-filter.config.ignoreUrlParams="[]"
       include-filter.config.rewrite="{Boolean}true"
       />
   <!--
   * include-filter.config.include-type="SSI | ESI | JSI"
   * include-filter.config.ttl is # of seconds (requires AEM Dispatcher 4.1.11+)
   -->
   ```

1. (Optional) Repeat the last step to allow for components on [locked (initial) content of editable templates](https://helpx.adobe.com/experience-manager/6-5/sites/developing/using/page-templates-editable.html) to be served via [!DNL SDI] as well. The reason for the additional configuration is that locked content of editable templates is served from `/conf` instead of `/content`.

   ```xml
   <?xml version="1.0" encoding="UTF-8"?>
   <jcr:root xmlns:sling="http://sling.apache.org/jcr/sling/1.0" xmlns:cq="http://www.day.com/jcr/cq/1.0"
       xmlns:jcr="http://www.jcp.org/jcr/1.0" xmlns:nt="http://www.jcp.org/jcr/nt/1.0"
       jcr:primaryType="sling:OsgiConfig"
       include-filter.config.enabled="{Boolean}true"
       include-filter.config.path="/conf"
       include-filter.config.resource-types="[my-app/components/content/highly-dynamic]"
       include-filter.config.include-type="SSI" 
       include-filter.config.add_comment="{Boolean}false"
       include-filter.config.selector="nocache"
       include-filter.config.ttl=""
       include-filter.config.required_header="Server-Agent=Communique-Dispatcher"
       include-filter.config.ignoreUrlParams="[]"
       include-filter.config.rewrite="{Boolean}true"
       />
   <!--
   * include-filter.config.include-type="SSI | ESI | JSI"
   * include-filter.config.ttl is # of seconds (requires AEM Dispatcher 4.1.11+)
   -->
   ```

1. Update [!DNL Apache HTTPD Web server]'s `httpd.conf` file to enable the [!DNL Include] module.

   ```shell
   $ sudo vi .../httpd.conf
   ```

   ```shell
   LoadModule include_module libexec/apache2/mod_include.so
   ```

1. Update the [!DNL vhost] file to respect include directives.

   ```shell
   $ sudo vi .../vhosts/aem-publish.local.conf
   ```

   ```shell
   <VirtualHost *:80>
   ...
      <Directory /Library/WebServer/docroot/publish>
         ...
         # Add Includes to enable SSI Includes used by Sling Dynamic Include
         Options FollowSymLinks Includes

         # Required to have dispatcher-handler process includes
         ModMimeUsePathInfo On

         # Set includes to process .html files
         AddOutputFilter INCLUDES .html
         ...
      </Directory>
   ...
   </VirtualHost>
   ```

1. Update the dispatcher.any configuration file to support (1) `nocache` selectors and (2) enable TTL support.

   ```shell
   $ sudo vi .../conf/dispatcher.any
   ```

   ```shell
   /rules {
     ...
     /0009 {
       /glob "*.nocache.html*"
       /type "deny"
     } 
   }
   ```

   >[!TIP]
   >
   > Leaving the trailing `*` off in the glob `*.nocache.html*` rule above, can result in [issues in requests for sub-resources](https://github.com/AdobeDocs/experience-manager-learn.en/issues/16).

   ```shell
   /cache {
       ...
       /enableTTL "1"
   }
   ```

1. Always restart [!DNL Apache HTTP Web Server] after making changes to its configuration files or the `dispatcher.any`.

   ```shell
   $ sudo apachectl restart
   ```

>[!NOTE]
>
>If you are using [!DNL Sling Dynamic Includes] for serving edge-side includes (ESI), then make sure to cache relevant [response headers in the dispatcher cache](https://docs.adobe.com/content/help/en/experience-manager-dispatcher/using/configuring/dispatcher-configuration.html#CachingHTTPResponseHeaders). Possible headers include the following:
>
>* "Cache-Control"
>* "Content-Disposition"
>* "Content-Type"
>* "Expires"
>* "Last-Modified"
>* "ETag"
>* "X-Content-Type-Options"
>* "Last-Modified"
>

## Supporting materials

* [Download Sling Dynamic Include bundle](https://sling.apache.org/downloads.cgi)
* [Apache Sling Dynamic Include documentation](https://github.com/Cognifide/Sling-Dynamic-Include)
