#!/bin/bash

BRANCH_NAME=$1
TRAVIS_PULL_REQUEST=$2

if [[ $BRANCH_NAME =~ master ]]; then
	export SYMPHONY_POD_HOST="foundation.symphony.com"
	export SYMPHONY_API_HOST="foundation-api.symphony.com"
    export BOT_NAME="botunfurl-prod"
    export OC_PROJECT_NAME="ssf-prod"

elif [[ $BRANCH_NAME =~ dev ]]; then
	# Reset Openshift env on every build, for testing purposes
	export OC_DELETE_LABEL="app=botunfurl-dev"
	export SYMPHONY_POD_HOST="foundation-dev.symphony.com"
	export SYMPHONY_API_HOST="foundation-dev-api.symphony.com"
    export BOT_NAME="botunfurl-dev"
    export OC_PROJECT_NAME="ssf-dev"
fi

export OC_BINARY_FOLDER="./target/oc"
export OC_ENDPOINT="https://api.pro-us-east-1.openshift.com"
export OC_TEMPLATE_PROCESS_ARGS="BOT_NAME,SYMPHONY_POD_HOST,SYMPHONY_API_HOST"

if [[ "$TRAVIS_PULL_REQUEST" = "false" ]]; then
	curl -s https://raw.githubusercontent.com/symphonyoss/contrib-toolbox/master/scripts/oc-deploy.sh | bash
fi