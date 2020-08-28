

# Creating an Asset Compute application project

Custom Asset Compute applications are build as part of Node.js projects that adhere to a certain stucture. A single project can contain one or more Asset Compute workers.

## Generate a project

Use the [Adobe I/O CLI Asset Compute plugin](../set-up/development-environment.md#aio-cli) to generate a new, empty Asset Compute project:

1. `$ aio app init` to begin the interactive project generation CLI.
    + This may open a browser prompting you to authenticate to Adobe I/O. Provide your Adobe credentials. If you are unable to log in, please follow these instructions on how to generate a project 
1. __Select Org__
    + Select the //TODO Adobe Org that has AEM as a Cloud Service and Firefly registered.
1. __Select Project__
    + Locate and select the Project. This is the [Project title](todo.md) created from the Firefly project template.
1. __Select Workspace__
    +  Select the `Development` workspace. // TODO
1. __Which Adobe I/O App features do you want to enable for this project? Select components to include__
    + Select `Actions: Deploy runtime actions`
    + Use the arrows keys to select and space to unselect/select, and Enter to confirm selection.
1. __Select type of actions to generate__
    + Select `Adobe Asset Compute Worker`
    + Use the arrows keys to select and space to unselect/select, and Enter to confirm selection.
1. __How would you like to name this action?__
    + Use the default name `worker`. 
    + If your project will contain multiple workers that perform different asset computations, name them semantically. 

## Review the anatomy of the project

The generated Asset Compute application project is a Node.js project for a specialized Adobe Firefly application, that adheres to the following structure:

+ `/actions` contains sub-folders, and each sub-folder defines an Asset Compute worker. 
    + `/actions/worker/index.js` defines the JavaScript code to be executed to perform the work of this worker. 
        + The folder name `worker` is a default, and can be anything, as long as it is registered in the `manifest.yml`.
        + More than one worker folder can be defined under `/actions` as needed, however they must be registered in the `manifest.yml`.
        + In this tutorial we will create a `wknd-asset-compute` folder and build out worker underneath that.
+ `/dist` is the compiled output directory.
+ `/node_modules` contains all the dependencies required by the application (as defined in `package.json`)
+ `/test/asset-compute` contains the test suites for each worker. Similar to the `/actions` folder, `/test/asset-compute` can contain multiple sub-folders, each corresponding to the worker it will test.
    + `/test/asset-compute/worker`, representing a test suite for a specific worker, contains sub-folders representing a specific test-case, along with the test input, parameters, and expected output.
+ `/.aio` contains configurations used by the aio CLI tool. This file can be configured via the `aio config` command.
+ `/.env` defines environment variables in a `key=value` syntax and often contains secrets that should not be shared. To protect these secrets, this file should NOT be checked into Git and is ignored via the project's default `.gitignore` file. 
+ `/.gitignore` standard Git ignore file, enumerating the files and folders not to include in source control.
+ `/console.json` contains the credentials set up through your Project Firefly project on Adobe I/O.
+ `/manifest.yml` defines what Asset Compute workers, or Adobe I/O Runtime actions, that this project exposes. Each worker implementation that should be deployed must be enumerated in this file.
+ `/package.json` the traditional [npm package.json](https://nodejs.org/en/knowledge/getting-started/npm/what-is-the-file-package-json/) file representing the project.
+ `/package-lock.json` the [npm package-log.json](https://docs.npmjs.com/files/package-lock.json) file for the project.

For more details on project structure review, review the [Anatomy of a Adobe Project Firefly application](https://github.com/AdobeDocs/project-firefly/blob/master/getting_started/first_app.md#5-anatomy-of-a-project-firefly-application).

The bulk of the development works takes place in the `/actions` folder developing worker implementations, and in `/test/asset-compute` writing tests for the custom workers.