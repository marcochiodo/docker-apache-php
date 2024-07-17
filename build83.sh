#!/usr/bin/bash

docker build -t sigblue/apache-php:83-light --build-arg VERSION=8.3-apache-bullseye --target light --no-cache .
docker build -t sigblue/apache-php:83-standard --build-arg VERSION=8.3-apache-bullseye --target standard .
docker build -t sigblue/apache-php:83-full --build-arg VERSION=8.3-apache-bullseye --target full .
