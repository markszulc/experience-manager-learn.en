# Debug Asset Compute worker



## Logging

The most basic form of debugging Asset Compute workers is to use traditional `console.log(..)` statements in the worker code. The `console` JavaScript object is an implicit, global object so there is no need to import or require it, as it is always present in all contexts. 

These log statements are available for review differently based on how the Asset Compute worker is executed:

+ From `aio app run`, logs print to standard out and the [Dev Tool's](../develop/dev-tool.md) Activation Logs.
+ From `aio app test`, logs print to `/build/test-results/test.log`. The log file only contains the logs for the prior test execution.
+ From `npx adobe-asset-compute devtool`, logs print to the VS Code Debug Console (View > Debug Console), standard out, and the [Dev Tool's](../develop/dev-tool.md) Activation Logs.


### Example code using console.log(..)

```javascript
exports.main = worker(async (source, rendition, params) => {
   ...
   let width = rendition.instructions.width;
   
   console.log(`Parameter 'width' passed in with value: ${width}`);
   
   if (myParam > MAX_VALUE) {
       console.log(`Parameter 'width' value of ${width} execeeds max value, setting to ${MAX_VALUE}`);
       width = MAX_VALUE;
   }

```

## wskdebug

The [wskdebug](https://www.npmjs.com/package/@openwhisk/wskdebug) npm module, provides debugging for Asset Compute workers, including the ability to set breakpoints in VS Code and step through the code.

1. Ensure [wskdebug](../set-up/development-environment.md#wskdebug) and [ngrok](../set-up/development-environment.md#ngork) npm modules are installed. 
1. Ensure [Docker Desktop](../set-up/development-environment.md#docker) is installed and running.
1. In your VS Code project, open `./vscode/setting.json` and add the settings key/value to the root setting JSON object:
    `"debug.javascript.usePreview": false`
1. Close any active running instances of Dev Tool.
1. Deploy the latest code using `aio app deploy`  and record the deployed action name (name between the `[...]`). This will be used to update the `launch.json` in step 8.
    ```
    ℹ Info: Deploying package [wkndAemAssetCompute-0.0.1]...
    ``` 
1. Start a new instance of Asset Compute Dev Tool using the command `npx adobe-asset-compute devtool`
1. In VS Code, tap the Debug icon in the left navigation
    + If prompted, tap __create a launch.json file > Node.js__ to create a new `launch.json` file.
    + Else, tap the __Gear__ icon to the right of the __Launch Program__ dropdown to open the existing `launch.json` in the editor.
1. Add the following JSON object configuration to the `configurations` array:
```json
{
    "type": "node",
    "request": "launch",
    "name": "wskdebug worker", // Optionally provide a more meaningful name
    "runtimeExecutable": "wskdebug",
    "args": [
        "wkndAemAssetCompute-0.0.1/__secured_worker",  // Version must match your Asset Compute application's version
        "${workspaceFolder}/actions/worker/index.js",  // Points to your worker
        "-l",
        "--ngrok"
    ],
    "localRoot": "${workspaceFolder}",
    "remoteRoot": "/code",
    "outputCapture": "std",
    "timeout": 30000
}
```
1. Select the new __wskdebug worker__ from the dropdown.
1. Tap the green __Run__ button to the left of __wskdebug worker__ dropdown.
1. Open `/actions/worker/index.js` and tab the gutter to the left of the line numbers to add break points to tbe file.
1. Navigate to the Asset Compute Dev Tool web browser window opened in step 6.
1. Tap the __Run__ button to execute the worker.
1. Navigate back to VS Code, to `/actions/worker/index.js` and step through the code.
1. To exit the debuggable Dev Tool, tap `Ctrl-C` in the terminal that ran `npx adobe-asset-compute devtool` command in step 6.
    + If tapping `Ctr-C` does not terminate the process, review the [troublshooting guidance](#troubleshooting__ctrl-c);

## Troubleshooting

### Cannot terminate dev tool process with Ctrl-C{#troubleshooting__ctrl-c}

+ __Error:__ Tapping `Ctrl-C` does not exit the `npx adobe-asset-compute devtool` process, put rather prints `^C` to the terminal
+ __Cause:__ The local Dev Tool process is unable to terminate.
+ __Resolution:__ Kill the Dev Tool process manually.
    + __macOS/Linux:__ From a new terminal window, execute the command:
     ```
     $ pkill -f 'node /usr/local/bin/npx adobe-asset-compute devtool'
     ```
    + __Windows:__ In Task Manager, locate and kill the `node` process with parameters `...adobe-asset-compute devtool`


### Breakpoints not pausing

+ __Error__: When running the Asset Compute worker from the debuggable Dev Tool, VS Code does not pause at breakpoints.

+ __Cause 1:__ The VS Code debugger was stopped/disconnected.
+ __Resolution 1:__ Restart the VS Code debugger, and verify it attaches by watching the VS Code Debug Output console (View > Debug Console)

+ __Cause 2:__ The VS Code debugger did not attach prior to tapping __Run__ in Dev Tool.
+ __Resolution 2:__ Ensure the debugger has attached by reviewing VS Code's Debug Console (View > Debug Console), and then re-run the Asset Compute worker from Dev Tool.