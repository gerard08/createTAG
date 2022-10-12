# GitHub Action to Create automatic Tags based on a Keyword
The keyword "TAG: " will create a tag with the message added in the commit after the keyword.

## Arguments
There are no arguments required for this action a part of the Environment Variables

## Environment Variables
**GITHUB_TOKEN** - Allows the action to authenticate with the GitHub API to create the TAG.


## Examples
Here is an example workflow that uses the Keyword Releaser action. The workflow is triggered by a PUSH event.

```
name: keyword-releaser

on: push

jobs:
    build:
        runs-on: ubuntu-latest
        steps:
            - uses: actions/checkout@v1
            - uses: gerard08/createTAG@master
                env:
                    GITHUB_TOKEN: ${{ secrets.GITHUB_TOEN }}