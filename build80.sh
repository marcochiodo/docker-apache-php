#!/usr/bin/bash

docker build -t sigblue/apache-php:80-light --build-arg VERSION=8.0 --target light --no-cache .
docker build -t sigblue/apache-php:80-standard --build-arg VERSION=8.0 --target standard .
docker build -t sigblue/apache-php:80-full --build-arg VERSION=8.0 --target full .
