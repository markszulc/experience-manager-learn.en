# Debug Asset Compute worker



## Console.log

The most basic form of debugging Asset Compute workers is to use traditional `console.log(..)` statements in the worker code. These will print to the standard out of the `aio app run` command or [Dev Tool's](../develop/dev-tool.md) Activation Logs.

## wskdebug

1. Ensure [wskdebug](../set-up/development-environment.md#wskdebug) and [ngrok](../set-up/development-environment.md#ngork) npm modules are installed. 
1. Ensure [Docker Desktop](../set-up/development-environment.md#docker) is installed and running.
1. In your VS Code project, open `./vscode/setting.json` and add the settings key/value to the root setting JSON object:
    `"debug.javascript.usePreview": false`
1. Close any active running instances of Dev Tool.
1. Deploy the latest code using `aio app deploy`  and record the deployed action name (name between the `[...]`). This will be used to update the `launch.json` in step 8.
    `ℹ Info: Deploying package [wkndAemAssetCompute-0.0.1]...` 
1. Start a new instance of Asset Compute Dev Tool using the command `npx adobe-asset-compute devtool`
1. In VS Code, tap the Debug icon in the left navigation
    + If prompted, tap __create a launch.json file > Node.js__ to create a new `launch.json` file.
    + Else, tap the __Gear__ icon to the right of the __Launch Program__ dropdown to open the existing `launch.json` in the editor.
1. Add the following JSON object configuration to the `configurations` array:
    ```json
{
    "type": "node",
    "request": "launch",
    "name": "wskdebug worker",
    "runtimeExecutable": "wskdebug",
    "args": [
        "wkndAemAssetCompute-0.0.1/__secured_worker",    
        "${workspaceFolder}/actions/worker/index.js",   
        "-l",
        "--ngrok"
    ],
    "localRoot": "${workspaceFolder}",
    "remoteRoot": "/code",
    "outputCapture": "std",
    "timeout": 30000
}```
1. Select the new __wskdebug worker__ from the dropdown.
1. Tap the green __Run__ button to the left of __wskdebug worker__ dropdown.
1. Open `/actions/worker/index.js` and tab the gutter to the left of the line numbers to add break points to tbe file.
1. Navigate to the Asset Compute Dev Tool web browser window opened in step 6.
1. Tap the __Run__ button to execute the worker.
1. Navigate back to VS Code, to `/actions/worker/index.js` and step through the code.
1. When finished kill the `npx 