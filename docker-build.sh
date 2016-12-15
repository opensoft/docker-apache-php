#!/usr/bin/env bash

# Set the project name (in lower-case)
PROJECT=docker-apache-php

# Get the branch
TAG_OR_BRANCH=$(git rev-parse --abbrev-ref HEAD)

read -e -p "Edit tag ID ---> " -i "$TAG_OR_BRANCH" TAG_OR_BRANCH
if [ "$TAG_OR_BRANCH" == "" ]; then
    echo "[ERROR] Tag is required"
    exit 1
fi

echo "Building docker image $PROJECT:$TAG_OR_BRANCH"
docker build -t opensoftdev/$PROJECT:$TAG_OR_BRANCH .