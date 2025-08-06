#!/usr/bin/bash

docker buildx build -t sigblue/apache-php:82-light --build-arg VERSION=8.2-apache-bullseye --target light --no-cache .
docker buildx build -t sigblue/apache-php:82-standard --build-arg VERSION=8.2-apache-bullseye --target standard .
docker buildx build -t sigblue/apache-php:82-full --build-arg VERSION=8.2-apache-bullseye --target full .
