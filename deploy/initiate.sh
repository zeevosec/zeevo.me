#!/bin/bash
set -e

### Configuration ###

USER=ubuntu
SERVER=$USER@ec2-18-188-147-55.us-east-2.compute.amazonaws.com
REMOTE_SCRIPT_PATH=/tmp/deploy.sh
APP_DIR=~/shaneoneill.io
GIT_URL=~/shaneoneill.io.git
IDENTITY_FILE=zeevome.pem
BRANCH_NAME=$(git symbolic-ref --short HEAD)

### Library ###

function run()
{
  echo "Running: $@"
  "$@"
}


### Automation steps ###

run scp -i deploy/$IDENTITY_FILE deploy/work.sh $SERVER:$REMOTE_SCRIPT_PATH
echo
echo "---- Running deployment script on remote server ----"
echo "---- Branch : $BRANCH_NAME ----"
run ssh -i deploy/$IDENTITY_FILE $SERVER "bash $REMOTE_SCRIPT_PATH $BRANCH_NAME"
