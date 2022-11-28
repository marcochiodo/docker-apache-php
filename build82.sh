#!/usr/bin/bash

docker build -t sigblue/apache-php:82-light --build-arg VERSION=8.2-rc --target light --no-cache .
docker build -t sigblue/apache-php:82-standard --build-arg VERSION=8.2-rc --target standard .
docker build -t sigblue/apache-php:82-full --build-arg VERSION=8.2-rc --target full .
