# Github Actions

## Folders structure

- .github
  - workflows
  - actions

### [Workflows](https://docs.github.com/en/actions/reference/workflow-syntax-for-github-actions#defaultsrun)

- First define the event that your workflow will listen to.
- Then define the jobs to execute.
- On each job you can specify the steps tu run.
  - To set up the workflow to access to your own actions, first you have to use the `checkout`
    <details>
        <summary>Example</summary>

      ```yml
      # workflows/main.yml (Workflow)
        steps:
        - uses: actions/checkout@v1
        - name: Run my action
          uses: ./.github/actions/<your-action-folder>
        - name: Run some other command
          run: ...
      ```
      </details>
  - To pass environment variables to your action use the `with` param. You can add your `secrets` on github, going to settings and secrets. To access on your action use first `INPUT` and the `_SOME_SECRET`. Example: `INPUT_SOME_SECRET`.
    <details>
        <summary>Example</summary>

      ```yml 
      # workflows/main.yml (Workflow)
        - name: Run my action
          uses: ./.github/actions/<your-action>
          with:
            some_secret: '${{ secrets.SOME_SECRET }}
      ```
      </details>

<details>
  <summary>Workflow Example</summary>

```yml
# workflows/main.yml (Workflow)
on:
  pull_request:
    types: [closed]
    branches: [ master ]

jobs:
merge_job:
  runs-on: ubuntu-latest
  if: github.event.pull_request.merged
  name: My first workflow
  steps:
  - uses: actions/checkout@v1
  - name: My first action
    uses: ./.github/actions/<action-forlder>
  - name: Run some other code
    run: do something with "${{secrets.MY_SECRET}}"
    ...
```
</details>
  
### [Actions](https://docs.github.com/en/actions/creating-actions)

- Inside of your action folder, you have to have an `action.yml`file.
- You can specify if your action has eny input data to work with. You can set if it's required or not, the default value...
- Then set the how do want to run your action (javascript, docker) and the file to execute (inside the same folder that your `action.yml` file)


<details>
  <summary>Action example</summary>

  ```yml
  # actions/my-action/action.yml
  name: 'My action'
  description: 'Do something'
  branding:
    icon: upload-cloud
    color: green
  inputs:
    directory:
      description: 'Directory to change to before pushing.'
      required: false
      default: '.'
  runs:
    using: 'node12'
    main: 'merge.js'
  ```
</details>

<details>
<summary>JS Code example to run a bash script</summary>

```js
  // actions/my-action/index.js
  const { spawn } = require('child_process');
  const path = require("path");

  const exec = (cmd, args=[]) => new Promise((resolve, reject) => {
      console.log(`Started: ${cmd} ${args.join(" ")}`)
      const app = spawn(cmd, args, { stdio: 'inherit' });
      app.on('close', code => {
          if(code !== 0){
              err = new Error(`Invalid status code: ${code}`);
              err.code = code;
              return reject(err);
          };
          return resolve(code);
      });
      app.on('error', reject);
  });

  const main = async () => {
      await exec('bash', [path.join(__dirname, './bash-script.sh')]);
  };

  main().catch(err => {
      console.error(err);
      console.error(err.stack);
      process.exit(err.code || -1);
  });
```
</details>