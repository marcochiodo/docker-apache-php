#!/usr/bin/bash

docker buildx build -t sigblue/apache-php:84-light --build-arg VERSION=8.4-rc-apache-bookworm --target light --no-cache .
docker buildx build -t sigblue/apache-php:84-standard --build-arg VERSION=8.4-rc-apache-bookworm --target standard .
docker buildx build -t sigblue/apache-php:84-full --build-arg VERSION=8.4-rc-apache-bookworm --target full .
