#!/usr/bin/env bash

# Set the project name (in lower-case)
PROJECT=docker-apache-php

# Get the branch
TAG_OR_BRANCH=$(git rev-parse --abbrev-ref HEAD)

# Set the URL for OpenSoft Registry on AWS ECR with proper namespace
REPO=230359645324.dkr.ecr.us-east-1.amazonaws.com/opensoft

read -e -p "Edit tag ID ---> " -i "$TAG_OR_BRANCH" TAG_OR_BRANCH
if [ "$TAG_OR_BRANCH" == "" ]; then
    echo "[ERROR] Tag is required"
    exit 1
fi

echo "Building docker image $PROJECT:$TAG_OR_BRANCH"
docker build -t $REPO/$PROJECT:$TAG_OR_BRANCH .