---
title: Map SPA components to AEM components | Getting Started with the AEM SPA Editor and React
description: Learn how to map React components to Adobe Experience Manager (AEM) components with the AEM SPA Editor JS SDK. Component mapping enables users to make dynamic updates to SPA components within the AEM SPA Editor, similar to traditional AEM authoring.
sub-product: sites
feature: maven-archetype, SPA Editor
topics: development
version: cloud-service
activity: develop
audience: developer
kt: 4854
thumbnail: 4854-spa-react.jpg
---

# Map SPA components to AEM components {#map-components}

Learn how to map React components to Adobe Experience Manager (AEM) components with the AEM SPA Editor JS SDK. Component mapping enables users to make dynamic updates to SPA components within the AEM SPA Editor, similar to traditional AEM authoring.

This chapter takes a deeper-dive into the AEM JSON model API and how the JSON content exposed by an AEM component can be automatically injected into a React component as props.

## Objective

1. Learn how to map AEM components to SPA Components.
2. Understand the difference between **Container** components and **Content** components.
3. Create a new React component that maps to an existing AEM component.

## What you will build

This chapter will inspect how the provided `Text` SPA component is mapped to the AEM `Text`component. A new `Image` SPA component will be created that can be used in the SPA and authored in AEM. Out of the box features of the **Layout Container** and **Template Editor** policies will also be used to create a view that is a little more varied in appearance.

![Chapter sample final authoring](./assets/map-components/final-page.png)

## Prerequisites

Review the required tooling and instructions for setting up a [local development environment](overview.md#local-dev-environment).

### Get the code

1. Download the starting point for this tutorial via Git:

    ```shell
    $ git clone git@github.com:adobe/aem-guides-wknd-spa.git
    $ cd aem-guides-wknd-spa
    $ git checkout React/map-components-start
    ```

2. Deploy the code base to a local AEM instance using Maven:

    ```shell
    $ mvn clean install -PautoInstallSinglePackage
    ```

    If using [AEM 6.x](overview.md#compatibility) add the `classic` profile:

    ```shell
    $ mvn clean install -PautoInstallSinglePackage -Pclassic
    ```

You can always view the finished code on [GitHub](https://github.com/adobe/aem-guides-wknd-spa/tree/React/map-components-solution) or check the code out locally by switching to the branch `React/map-components-solution`.

## Mapping Approach

The basic concept is to map a SPA Component to an AEM Component. AEM components, run server-side, export content as part of the JSON model API. The JSON content is consumed by the SPA, running client-side in the browser. A 1:1 mapping between SPA components and an AEM component is created.

![High-level overview of mapping an AEM Component to a React Component](./assets/map-components/high-level-approach.png)

*High-level overview of mapping an AEM Component to a React Component*

## Inspect the Text Component

The [AEM Project Archetype](https://github.com/adobe/aem-project-archetype) provides a `Text` component that is mapped to the AEM [Text component](https://docs.adobe.com/content/help/en/experience-manager-core-components/using/components/text.html). This is an example of a **content** component, in that it renders *content* from AEM.

Let's see how the component works.

### Inspect the JSON model

1. Before jumping into the SPA code, it is important to understand the JSON model that AEM provides. Navigate to the [Core Component Library](https://www.aemcomponents.dev/content/core-components-examples/library/page-authoring/text.html) and view the page for the Text component. The Core Component Library provides examples of all the AEM Core Components.
2. Select the **JSON** tab for one of the examples:

    ![Text JSON model](./assets/map-components/text-json.png)

    You should see three properties: `text`, `richText`, and `:type`.

    `:type` is a reserved property that lists the `sling:resourceType` (or path) of the AEM Component. The value of `:type` is what is used to map the AEM component to the SPA component.

    `text` and `richText` are additional properties that will be exposed to the SPA component.

### Inspect the Text component

1. Open a new terminal and navigate to the `ui.frontend` folder inside the project. Run `npm install` and then `npm start` to start the **webpack-dev-server**:

    ```shell
    $ cd ui.frontend
    $ npm install
    $ npm start
    ```

    The `ui.frontend` module is currently set up to use the [mock JSON model](./integrate-spa.md#mock-json).

2. You should see a new browser window open to [http://localhost:3000/content/wknd-spa-react/us/en/home.html](http://localhost:3000/content/wknd-spa-react/us/en/home.html)

    ![Webpack dev server with mock content](./assets/map-components/initial-start.png)

3. In the IDE of your choice open up the AEM Project for the WKND SPA. Expand the `ui.frontend` module and open the file `Text.js` under `ui.frontend/src/components/Text/Text.js`:

    ![Text.js React Component Source Code](./assets/map-components/vscode-ide-text-js.png)

4. The first area we will inspect is the `class Text` at ~line 40:

    ```js

    class Text extends Component {

        get richTextContent() {
            return (<div
                    id={extractModelId(this.props.cqPath)}
                    data-rte-editelement
                    dangerouslySetInnerHTML={{__html: DOMPurify.sanitize(this.props.text)}} />
                    );
        }

        get textContent() {
            return <div>{this.props.text}</div>;
        }

        render() {
            return this.props.richText ? this.richTextContent : this.textContent;
        }
    }
    ```

    `Text` is a standard React component. The component uses `this.props.richText` to determine whether the content to render is going to be rich text or plain text. The actual "content" used comes from `this.props.text`. To avoid a potential XSS attack, the rich text is escaped via `DOMPurify` before using [dangerouslySetInnerHTML](https://reactjs.org/docs/dom-elements.html#dangerouslysetinnerhtml) to render the content. Recall the `richText` and `text` properties from the JSON model earlier in the exercise.

5. Next take a look at the `TextEditConfig` at ~line 29:

    ```js
    const TextEditConfig = {
    emptyLabel: 'Text',

        isEmpty: function(props) {
            return !props || !props.text || props.text.trim().length < 1;
        }
    };
    ```

    The above code is responsible for determining when to render the placeholder in the AEM author environment. If the `isEmpty` method returns **true** then the placeholder will be rendered.

6. Finally take a look at the `MapTo` call at ~line 62:

    ```js
    export default MapTo('wknd-spa-react/components/text')(Text, TextEditConfig);
    ```

    `MapTo` is provided by the AEM SPA Editor JS SDK (`@adobe/cq-react-editable-components`). The path `wknd-spa-react/components/text` represents the `sling:resourceType` of the AEM component. This path gets matched with the `:type` exposed by the JSON model observed earlier. `MapTo` takes care of parsing the JSON model response and passing the correct values as `props` to the SPA component.

    You can find the AEM `Text` component definition at `ui.apps/src/main/content/jcr_root/apps/wknd-spa-react/components/text`.

7. Experiment by modifying the `mock.model.json` file at `ui.frontend/public/mock-content/mock.model.json`. At ~line 62 update the first `Text` value to use an **`H1`** and **`u`** tags:

    ```json
        "text": {
            "text": "<h1><u>Hello World!</u></h1>",
            "richText": true,
            ":type": "wknd-spa-react/components/text"
        }
    ```

    Navigate to [http://localhost:3000](http://localhost:3000) to see the effects:

    ![Updated Text model](./assets/map-components/updated-text-model.png)

    Try toggling the `richText` property between **true** / **false** to see the render logic in action.

8. Inspect `Text.scss` at `ui.frontend/src/components/Text/Text.scss`.

    This file was added by the starter code base for this chapter and makes use of [Sass](https://sass-lang.com/) feature added in the previous chapter. Note the variables referenced from `ui.frontend/src/styles/_variables.scss`.

## Create the Image Component

Next, create an `Image` React component that is mapped to the AEM [Image component](https://docs.adobe.com/content/help/en/experience-manager-core-components/using/components/image.html). The `Image` component is another example of a **content** component.

### Inspect the JSON

Before jumping into the SPA code, inspect the JSON model provided by AEM.

1. Navigate to the [Image examples in the Core Component library](https://www.aemcomponents.dev/content/core-components-examples/library/page-authoring/image.html).

    ![Image Core Component JSON](./assets/map-components/image-json.png)

    Properties of `src`, `alt`, and `title` will be used to populate the SPA `Image` component.

    >[!NOTE]
    >
    > There are other Image properties exposed (`lazyEnabled`, `widths`) that allow a developer to create an adaptive and lazy-loading component. The component built in this tutorial will be simple and will **not** use these advanced properties.

2. Return to your IDE and open up the `mock.model.json` at `ui.frontend/public/mock-content/mock.model.json`. Since this is a net-new component for our project we need to "mock" the Image JSON.

    At ~line 70 add a JSON entry for the `image` model (don't forget about the trailing comma `,` after the second `text_23828680`) and update the `:itemsOrder` array.

    ```json
    ...
    ":items": {
                ...
                "text_23828680": {
                    "text": "<p>Mock Model JSON!</p>",
                    "richText": true,
                    ":type": "wknd-spa-react/components/text"
                },
                "image": {
                    "alt": "Rock Climber in New Zealand",
                    "title": "Rock Climber in New Zealand",
                    "src": "/mock-content/adobestock-140634652.jpeg",
                    ":type": "wknd-spa-react/components/image"
                }
            },
            ":itemsOrder": [
                "text",
                "text_23828680",
                "image"
            ],
    ```

    The project includes a sample image at `/mock-content/adobestock-140634652.jpeg` that will be used with the **webpack-dev-server**.

    You can view the full [mock.model.json here](https://github.com/adobe/aem-guides-wknd-spa/blob/React/map-components-solution/ui.frontend/public/mock-content/mock.model.json).

### Implement the Image component

1. Next, create a new folder named `Image` under `ui.frontend/src/components`.
2. Beneath the `Image` folder create a new file named `Image.js`.

    ![Image.js file](./assets/map-components/image-js-file.png)

3. Add the following `import` statements to `Image.js`:

    ```js
    import React, {Component} from 'react';
    import {MapTo} from '@adobe/cq-react-editable-components';
    ```

4. Then add the `ImageEditConfig` to determine when to show the placeholder in AEM:

    ```js
    export const ImageEditConfig = {

        emptyLabel: 'Image',

        isEmpty: function(props) {
            return !props || !props.src || props.src.trim().length < 1;
        }
    };
    ```

    The placeholder will show if the `src` property is not set.

5. Next implement the `Image` class:

    ```js
     export default class Image extends Component {

        get content() {
            return <img     className="Image-src"
                            src={this.props.src}
                            alt={this.props.alt}
                            title={this.props.title ? this.props.title : this.props.alt} />;
        }

        render() {
            if(ImageEditConfig.isEmpty(this.props)) {
                return null;
            }

            return (
                    <div className="Image">
                        {this.content}
                    </div>
            );
        }
    }
    ```

    The above code will render an `<img>` based on the props `src`, `alt`, and `title` passed in by the JSON model.

6. Add the `MapTo` code to map the React component to the AEM component:

    ```js
    MapTo('wknd-spa-react/components/image')(Image, ImageEditConfig);
    ```

    Note the string `wknd-spa-react/components/image` corresponds to the location of the AEM component in `ui.apps` at: `ui.apps/src/main/content/jcr_root/apps/wknd-spa-react/components/image`.

7. Create a new file named `Image.scss` in the same directory and add the following:

    ```scss
    .Image-src {
        margin: 1rem 0;
        width: 100%;
        border: 0;
    }
    ```

8. In `Image.js` add a reference to the file at the top beneath the `import` statements:

    ```js
    import React, {Component} from 'react';
    import {MapTo} from '@adobe/cq-react-editable-components';

    require('./Image.scss');
    ```

    You can view the completed [Image.js here](https://github.com/adobe/aem-guides-wknd-spa/blob/React/map-components-solution/ui.frontend/src/components/Image/Image.js).

9. Open the file `ui.frontend/src/components/import-components.js` and add a reference to the new `Image` component:

    ```js
    import './Page/Page';
    import './Text/Text';
    import './Image/Image'; //add reference to Image component
    ```

10. If not already started, start the **webpack-dev-server**. Navigate to [http://localhost:3000](http://localhost:3000) and you should see the image render:

    ![Image added to the mock](./assets/map-components/image-added-mock.png)

    >[!NOTE]
    >
    > **Bonus challenge**: Implement a new method in `Image.js` to display the value of `this.props.title` as a caption beneath the image.

## Update Policies in AEM

The `Image` component is only visible in the **webpack-dev-server**. Next, deploy the updated SPA to AEM and update the template policies.

1. Stop the **webpack-dev-server** and from the root of the project, deploy the changes to AEM using your Maven skills:

    ```shell
    $ cd aem-guides-wknd-spa
    $ mvn clean install -PautoInstallSinglePackage
    ```

2. From the AEM Start screen navigate to **Tools** &gt; **Templates** &gt; **[WKND SPA React](http://localhost:4502/libs/wcm/core/content/sites/templates.html/conf/wknd-spa-react)**.

    Select and edit the **SPA Page**:

    ![Edit SPA Page Template](./assets/map-components/edit-spa-page-template.png)

3. Select the **Layout Container** and click it's **policy** icon to edit the policy:

    ![Layout Container Policy](./assets/map-components/layout-container-policy.png)

4. Under **Allowed Components** &gt; **WKND SPA React - Content** &gt; check the **Image** component:

    ![Image Component selected](./assets/map-components/check-image-component.png)

    Under **Default Components** &gt; **Add mapping** and choose the **Image - WKND SPA React - Content** component:

    ![Set default components](./assets/map-components/default-components.png)

    Enter a **mime type** of `image/*`.

    Click **Done** to save the policy updates.

5. In the **Layout Container** click the **policy** icon for the **Text** component:

    ![Text component policy icon](./assets/map-components/edit-text-policy.png)

    Create a new policy named **WKND SPA Text**. Under **Plugins** &gt; **Formatting** &gt; check all the boxes to enable additional formatting options:

    ![Enable RTE Formatting](assets/map-components/enable-formatting-rte.png)

    Under **Plugins** &gt; **Paragraph Styles** &gt; check the box to **Enable paragraph styles**:

    ![Enable paragraph styles](./assets/map-components/text-policy-enable-paragraphstyles.png)

    Click **Done** to save the policy update.

6. Navigate to the **Homepage** [http://localhost:4502/editor.html/content/wknd-spa-react/us/en/home.html](http://localhost:4502/editor.html/content/wknd-spa-react/us/en/home.html).

    You should also be able to edit the `Text` component and add additional paragraph styles in **full-screen** mode.

    ![Full Screen Rich Text Editing](assets/map-components/full-screen-rte.png)

7. You should also be able to drag+drop an image from the **Asset finder**:

    ![Drag and Drop image](./assets/map-components/drag-drop-image.gif)

8. Add your own images via [AEM Assets](http://localhost:4502/assets.html/content/dam) or install the finished code base for the standard [WKND reference site](https://github.com/adobe/aem-guides-wknd/releases/latest). The [WKND reference site](https://github.com/adobe/aem-guides-wknd/releases/latest) includes many images that can be re-used on the WKND SPA. The package can be installed using [AEM's Package Manager](http://localhost:4502/crx/packmgr/index.jsp).

    ![Package Manager install wknd.all](./assets/map-components/package-manager-wknd-all.png)

## Inspect the Layout Container

Support for the **Layout Container** is automatically provided by the AEM SPA Editor SDK. The **Layout Container**, as indicated by the name, is a **container** component. Container components are components that accept JSON structures which represent *other* components and dynamically instantiate them.

Let's inspect the Layout Container further.

1. In a browser navigate to [http://localhost:4502/content/wknd-spa-react/us/en.model.json](http://localhost:4502/content/wknd-spa-react/us/en.model.json)

    ![JSON model API - Responsive Grid](./assets/map-components/responsive-grid-modeljson.png)

    The **Layout Container** component has a `sling:resourceType` of `wcm/foundation/components/responsivegrid` and is recognized by the SPA Editor using the `:type` property, just like the `Text` and `Image` components.

    The same capabilities of re-sizing a component using [Layout Mode](https://docs.adobe.com/content/help/en/experience-manager-65/authoring/siteandpage/responsive-layout.html#defining-layouts-layout-mode) are available with the SPA Editor.

2. Return to [http://localhost:4502/editor.html/content/wknd-spa-react/us/en/home.html](http://localhost:4502/editor.html/content/wknd-spa-react/us/en/home.html). Add additional **Image** components and try re-sizing them using the **Layout** option:

    ![Re-size image using Layout mode](./assets/map-components/responsive-grid-layout-change.gif)

3. Re-open the JSON model [http://localhost:4502/content/wknd-spa-react/us/en.model.json](http://localhost:4502/content/wknd-spa-react/us/en.model.json) and observe the `columnClassNames` as part of the JSON:

    ![Cloumn Class names](./assets/map-components/responsive-grid-classnames.png)

    The class name `aem-GridColumn--default--4` indicates the component should be 4 columns wide based on a 12 column grid. More details about the [responsive grid can be found here](https://adobe-marketing-cloud.github.io/aem-responsivegrid/).

4. Return to the IDE and in the `ui.apps` module there is a client-side library defined at `ui.apps/src/main/content/jcr_root/apps/wknd-spa-react/clientlibs/clientlib-grid`. Open the file `less/grid.less`.

    This file determines the breakpoints (`default`, `tablet`, and `phone`) used by the **Layout Container**. This file is intended to be customized per project specifications. Currently the breakpoints are set to `1200px` and `650px`.

5. You should be able to use the responsive capabilities and the updated rich text policies of the `Text` component to author a view like the following:

    ![Chapter sample final authoring](./assets/map-components/final-page.png)

## Congratulations! {#congratulations}

Congratulations, you learned how to map SPA components to AEM Components and you implemented a new `Image` component. You also got a chance to explore the responsive capabilities of the **Layout Container**.

You can always view the finished code on [GitHub](https://github.com/adobe/aem-guides-wknd-spa/tree/React/map-components-solution) or check the code out locally by switching to the branch `React/map-components-solution`.

### Next Steps {#next-steps}

[Navigation and Routing](navigation-routing.md) - Learn how multiple views in the SPA can be supported by mapping to AEM Pages with the SPA Editor SDK. Dynamic navigation is implemented using React Router and added to an existing Header component.

## Bonus - Persist configurations to source control {#bonus}

In many cases, especially at the beginning of an AEM project it is valuable to persist configurations, like templates and related content policies, to source control. This ensures that all developers are working against the same set of content and configurations and can ensure additional consistency between environments. Once a project reaches a certain level of maturity, the practice of managing templates can be turned over to a special group of power users.

The next few steps will take place using the Visual Studio Code IDE and [VSCode AEM Sync](https://marketplace.visualstudio.com/items?itemName=yamato-ltd.vscode-aem-sync) but could be doing using any tool and any IDE that you have configured to **pull** or **import** content from a local instance of AEM.

1. In the Visual Studio Code IDE, ensure that you have **VSCode AEM Sync** installed via the Marketplace extension:

   ![VSCode AEM Sync](./assets/map-components/vscode-aem-sync.png)

2. Expand the **ui.content** module in the Project explorer and navigate to `/conf/wknd-spa-react/settings/wcm/templates`.

3. **Right+Click** the `templates` folder and select **Import from AEM Server**:

   ![VSCode import template](./assets/map-components/import-aem-servervscode.png)

4. Repeat the steps to import content but select the **policies** folder located at `/conf/wknd-spa-react/settings/wcm/templates/policies`.

5. Inspect the `filter.xml` file located at `ui.content/src/main/content/META-INF/vault/filter.xml`.

   ```xml
   <!--ui.content filter.xml-->
   <?xml version="1.0" encoding="UTF-8"?>
    <workspaceFilter version="1.0">
        <filter root="/conf/wknd-spa-react" mode="merge"/>
        <filter root="/content/wknd-spa-react" mode="merge"/>
        <filter root="/content/dam/wknd-spa-react" mode="merge"/>
        <filter root="/content/experience-fragments/wknd-spa-react" mode="merge"/>
    </workspaceFilter>
   ```

   The `filter.xml` file is responsible for identifying the paths of nodes that will be installed with the package. Notice the `mode="merge"` on each of the filters which indicates that existing content will not be modified, only new content is added. Since content authors may be updating these paths, it is important that a code deployment does **not** overwrite content. See the [FileVault documentation](https://jackrabbit.apache.org/filevault/filter.html) for more details on working with filter elements.

   Compare `ui.content/src/main/content/META-INF/vault/filter.xml` and `ui.apps/src/main/content/META-INF/vault/filter.xml` to understand the different nodes managed by each module.
