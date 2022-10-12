#!/bin/bash
set -e

if [ -n "$GITHUB_EVENT_PATH" ];
then
    EVENT_PATH=$GITHUB_EVENT_PATH
elif [ -f ./sample_push_event.json ]
then
    EVENT_PATH='./sample_push_event.json'
    LOCAL_TEST=true
else
    echo "No JSON data to process :("
    exit 1
fi

env
jq . < "$EVENT_PATH"

#if keyword is found
if jq '.commits[].message, .head_commit.message' < $EVENT_PATH | grep -i -q "$*";
then
    #do something
    echo found keyword
    VERSION=$(jq '.head_commit.message' < $EVENT_PATH)
    VERSION="${VERSION:5}";
    DATA="$(echo '{"tag_name": '$VERSION)"
    DATA="${DATA} $(echo '"target_commitish":"master",')"
    DATA="${DATA} $(echo '"name": '$VERSION,)"
    DATA="${DATA} $(echo '"body":"Automatic tag created",')"
    DATA="${DATA} $(echo '"draft":false, "prerelease":false}')"

    echo $DATA
    URL="https://api.github.com/repos/${GITHUB_REPOSITORY}/releases?access_token=${GITHUB_TOKEN}"

    if [[ "${LOCAL_TEST}" == *"true"* ]];
    then
        echo "## [TESTING] Keyword was found but no release was created."
    else
        echo $DATA | http POST $URL | jq .
    fi
else
    echo "Nothing to process."
fi