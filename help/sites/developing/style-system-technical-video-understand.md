---
title: Understanding how to code for the AEM Style System
description: In this video we'll take a look at the anatomy of the CSS (or LESS) and JavaScript used to style Adobe Experience Manage's Core Title Component using the Style System, as well as how these styles are applied to the HTML and DOM.
feature: style-system
topics: development, components, front-end-development
audience: developer, implementer
doc-type: technical video
activity: understand
version: 6.4, 6.5
---

# Understanding how to code for the Style System{#understanding-how-to-code-for-the-aem-style-system}

In this video we'll take a look at the anatomy of the CSS (or [!DNL LESS]) and JavaScript used to style Experience Manage's Core Title Component using the Style System, as well as how these styles are applied to the HTML and DOM.

>[!NOTE]
>
>The AEM Style System was introduced with [AEM 6.3 SP1](https://helpx.adobe.com/experience-manager/6-3/release-notes/sp1-release-notes.html) + [Feature Pack 20593](https://www.adobeaemcloud.com/content/marketplace/marketplaceProxy.html?packagePath=/content/companies/public/adobe/packages/cq630/featurepack/cq-6.3.0-featurepack-20593).
>
>The video assumes the We.Retail Title component has been updated to inherit from [Core Components v2.0.0+](https://github.com/Adobe-Marketing-Cloud/aem-core-wcm-components/releases).

## Understanding how to code for the Style System {#understanding-how-to-code-for-the-style-system}

>[!VIDEO](https://video.tv.adobe.com/v/21538/?quality=9&learn=on)

The provided AEM Package (**technical-review.sites.style-system-1.0.0.zip**) installs the example title style, sample policies for the We.Retail Layout Container and Title components, and a sample page.

[technical-review.sites.style-system-1.0.0.zip](assets/technical-review.sites.style-system-1.0.0.zip)

### The CSS {#the-css}

The following is the [!DNL LESS] definition for the example style found at:

* `/apps/enablement/sites/style-system/clientlib-example/components/titles/styles/example.less`

For those that prefer CSS, below this code snippet is the CSS this [!DNL LESS] compiles into.

```css

/* LESS */
.cmp-title--example {
 .cmp-title {
  text-align: center;

  .cmp-title__text {
   color: #EB212E;
   font-weight: 600;
   font-size: 5rem;
   border-bottom: solid 1px #ddd;
   padding-bottom: 0;
   margin-bottom: .25rem
  }

  // Last Modified At element injected via JS
  .cmp-title__last-modified-at {
   color: #999;
   font-size: 1.5rem;
   font-style: italic;
   font-weight: 200;
  }
 }
}

```

The above [!DNL LESS] is compiled natively by Experience Manager to the following CSS.

```css

/* CSS */
.cmp-title--example .cmp-title {
 text-align: center;
}

.cmp-title--example .cmp-title .cmp-title__text {
 color: #EB212E;
 font-weight: 600;
 font-size: 5rem;
 border-bottom: solid 1px #ddd;
 padding-bottom: 0;
 margin-bottom: 0.25rem;
}

.cmp-title--example .cmp-title .cmp-title__last-modified-at {
 color: #999;
 font-size: 1.5rem;
 font-style: italic;
 font-weight: 200;
}

```

### The JavaScript {#example-javascript}

The following JavaScript collects and injects the current page's last modified date and time beneath the title text when the Example style is applied to the Title component.

The use of jQuery is optional, as well as the naming conventions used.

The following is the [!DNL LESS] definition for the example style found at:

* `/apps/enablement/sites/style-system/clientlib-example/components/titles/styles/js/title.js`

```js

/**
 * JavaScript supporting Styles may be re-used across multi Component Styles.
 *
 * For example:
 * Many styles may require the Components Image (provided via an <img> element) to be set as the background-image.
 * A single JavaScript function may be used to adjust the DOM for all styles that required this effect.
 *
 * JavaScript must react to the DOMNodeInserted event to handle style-switching in the Page Editor Authoring experience.
 * JavaScript must also run on DOM ready to handle the initial page load rendering (AEM Publish).
 * JavaScript must mark and check for elements as processed to avoid cyclic processing (ie. if the JavaScript inserts a DOM node of its own).
 */
jQuery(function ($) {
    "use strict;"

    moment.locale("en");

    /**
     * Method that injects p element, containing the current pages last modified date/time, under the title text.
     *
     * Similar to the CSS Style application, component HTML elements should be targeted via the BEM class names (as they define the stable API)
     * and targeting "raw" elements (ex. "li", "a") should be avoided.
     */
    function applyComponentStyles() {

        $(".cmp-title--example").not("[data-styles-title-last-modified-processed]").each(function () {
            var title = $(this).attr("data-styles-title-last-modified-processed", true),
                url = Granite.HTTP.getPath() + ".model.json";

            $.getJSON(url, function(data) {
                var dateObject = moment(data['lastModifiedDate']),
                    titleText = title.find('.cmp-title__text');

                titleText.after($("<p>").addClass("cmp-title__last-modified-at").text("Last modified " + dateObject.fromNow()));
            });
        });
    }

    // Handle DOM Ready event
    applyComponentStyles();

    // Apply Styles when a component is inserted into the DOM (ie. during Authoring)
    $(".responsivegrid").bind("DOMNodeInserted", applyComponentStyles);
});

```

## Development best practices {#development-best-practices}

### HTML best practices {#html-best-practices}

* HTML (generated via HTL) should be as structurally semantic as possible; avoiding unnecessary grouping/nesting of elements.
* HTML elements should be addressable via BEM-style CSS classes.

**Good** - All elements in the component are addressable via BEM notation:

```html
<!-- Good practice -->
<div class="cmp-list">
    <ul class="cmp-list__item-group">
        <li class="cmp-list__item">...</li>
    </ul>
</div>
```

**Bad** - The list and list elements are only addressable by element name:

```html
<!-- Bad practice -->
<div class="cmp-list">
    <ul>
        <li>...</li>
    </ul>
</div>
```

* It is better to expose more data and hide it than to expose too little data requiring future back-end development to expose it.

  * Implementing author-able content toggles can aid in keeping this HTML lean, whereby authors are able to select which content elements are written to the HTML. The can be especially important when writing images to the HTML that may not be used for all styles.
  * The exception to this rule is when expensive resources, for example, images, are exposed by default, as event images hidden by CSS will be, in this case, unnecessarily fetched.

    * Modern image components often will use JavaScript to select and load the most appropriate image for the use case (viewport).

### CSS best practices {#css-best-practices}

>[!NOTE]
>
>The Style System makes a small technical divergence from [BEM](https://en.bem.info/), in that the `BLOCK` and `BLOCK--MODIFIER` are not applied to the same element, as specified by [BEM](https://en.bem.info/).
>
>Instead, due to product constraints, the `BLOCK--MODIFIER` is applied to the parent of the `BLOCK` element. 
>
>All other tenants of [BEM](https://en.bem.info/) should be aligned with.

* Use preprocessors such as [LESS](https://lesscss.org/) (supported by AEM natively) or [SCSS](https://sass-lang.com/) (requires custom build system) to allow for clear CSS definition, and re-usability.

* Keep selector weight/specificity uniform; This helps to avoid and resolve difficult-to-identify CSS cascade conflicts.
* Organize each style into a discrete file.
  * These files can be combined using LESS/SCSS `@imports` or if raw CSS is required, via HTML Client Library file inclusion, or custom front-end asset build systems.
* Avoid mixing many complex styles.
  * The more styles that can be applied at a single time to a component, the greater the variety of permutations. This can become difficult to maintain/QA/ensure brand alignment.
* Always use CSS classes (following BEM notation) to define CSS rules.
  * If selecting elements without CSS classes (i.e. bare elements) is absolutely necessary, move them higher in the CSS definition to make it clear that they have lower specificity than any collisions with elements of that type that do have selectable CSS classes.
* Avoid styling the `BLOCK--MODIFIER` directly as this is attached to the Responsive Grid. Changing the display of this element may affect the rendering and functionality of the Responsive Grid, so only style at this level when the intent is to change the Responsive Grid's behavior.
* Apply style scope using `BLOCK--MODIFIER`. The `BLOCK__ELEMENT--MODIFIERS` can be used in the Component, but since the `BLOCK` represents the Component, and the Component is what is styled, the Style is "defined" and scoped via `BLOCK--MODIFIER`.

Example CSS selector structure should be as follows:

<table> 
 <tbody> 
  <tr> 
   <td valign="bottom"><p>1st level selector</p> <p>BLOCK--MODIFIER</p> </td> 
   <td valign="bottom"><p>2nd level selector</p> <p>BLOCK</p> </td> 
   <td valign="bottom"><p>3rd level selector</p> <p>BLOCK__ELEMENT</p> </td> 
   <td> </td> 
   <td valign="middle">Effective CSS selector</td> 
  </tr> 
  <tr> 
   <td valign="middle"><span class="code">.cmp-list--dark</span></td> 
   <td valign="middle"><span class="code">.cmp-list</span></td> 
   <td valign="middle"><span class="code">.cmp-list__item</span></td> 
   <td valign="middle">→</td> 
   <td><p><span class="code">.cmp-list--dark</span></p> <p><span class="code"> .cmp-list</span></p> <p><span class="code"> </span><strong><span class="code"> .cmp-list__item { </span></strong></p> <p><strong> color: blue;</strong></p> <p><strong> }</strong></p> </td> 
  </tr> 
  <tr> 
   <td valign="middle"><span class="code">.cmp-image--hero</span></td> 
   <td valign="middle"><span class="code">.cmp-image</span></td> 
   <td valign="middle"><span class="code">.cmp-image__caption</span></td> 
   <td valign="middle">→</td> 
   <td valign="middle"><p><span class="code">.cmp-image--hero</span></p> <p><span class="code"> .cmp-image</span></p> <p><span class="code"> .cmp-image__caption {</span></p> <p><span class="code"> color: red;</span></p> <p><span class="code"> }</span></p> </td> 
  </tr> 
 </tbody> 
</table>

In the case of nested components, the CSS selector depth for these nested Component elements will exceed the 3rd level selector. Repeat the same pattern for the nested component, but scoped by the parent Component's `BLOCK`. Or in other words, start the nested component's `BLOCK` at the 3rd level, and the nested Component's `ELEMENT` will be at the 4th selector level.

### JavaScript best practices {#javascript-best-practices}

The best practices defined in this section pertain to "style-JavaScript", or JavaScript specifically intended to manipulate the Component for stylistic, rather than functional purposes.

* Style-JavaScript should be used judiciously and is a minority use case.
* Style-JavaScript should be primarily used for manipulating the component's DOM to support styling by CSS.
* Re-evaluate use of Javascript if components will appear many times on a page, and understand the computational/and re-draw cost.
* Re-evaluate use of Javascript if it pulls in new data/content asynchronously (via AJAX) when the component may appear many times on a page.
* Handle both Publish and Authoring experiences.
* Re-use style-Javascript when possible.
  * For example, if multiple styles of a Component require it's image to be moved to a background image, the style-JavaScript can be implemented once and attached to multiple `BLOCK--MODIFIERs`.
* Separate style-JavaScript from functional JavaScript when possible.
* Evaluate the cost of JavaScript vs. manifesting these DOM changes in the HTML directly via HTL.
  * When a component that uses style-JavaScript requires server-side modification, evaluate if the JavaScript manipulation can be brought in at this time, and what the effects/ramifications are to performance and supportability of the component.

#### Performance considerations {#performance-considerations}

* Style-JavaScript should be kept light and lean.
* To avoid flickering and unnecessary re-draws, initially hide the component via `BLOCK--MODIFIER BLOCK`, and show it when all DOM manipulations in the JavaScript are complete.
* The performance of the style-JavaScript manipulations is akin to basic jQuery plug-ins that attach to and modify elements on DOMReady.
* Ensure requests are gzipped, and CSS and JavaScript are minified.

## Additional Resources {#additional-resources}

* [Style System Documentation](https://helpx.adobe.com/experience-manager/6-5/sites/authoring/using/style-system.html)
* [Creating AEM Client libraries](https://helpx.adobe.com/experience-manager/6-5/sites/developing/using/clientlibs.html)
* [BEM (Block Element Modifier) documentation website](https://getbem.com/)
* [LESS Documentation website](https://lesscss.org/)
* [jQuery website](https://jquery.com/)
