#!/usr/bin/env bash

docker run --rm \
-p 8080:80 \
-p 4433:443 \
230359645324.dkr.ecr.us-east-1.amazonaws.com/opensoft/docker-apache-php:1.0.0