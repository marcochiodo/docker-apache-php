#!/usr/bin/bash

docker buildx build -t sigblue/apache-php:83-light --build-arg VERSION=8.3-apache-bullseye --target light --no-cache .
docker buildx build -t sigblue/apache-php:83-standard --build-arg VERSION=8.3-apache-bullseye --target standard .
docker buildx build -t sigblue/apache-php:83-full --build-arg VERSION=8.3-apache-bullseye --target full .
