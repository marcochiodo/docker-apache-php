#!/usr/bin/bash

docker buildx build -t sigblue/apache-php:81-light --build-arg VERSION=8.1-apache-bullseye --target light --no-cache .
docker buildx build -t sigblue/apache-php:81-standard --build-arg VERSION=8.1-apache-bullseye --target standard .
docker buildx build -t sigblue/apache-php:81-full --build-arg VERSION=8.1-apache-bullseye --target full .
