#!/usr/bin/bash

docker build -t sigblue/apache-php:81-light --build-arg VERSION=8.1-apache-bullseye --target light --no-cache .
docker build -t sigblue/apache-php:81-standard --build-arg VERSION=8.1-apache-bullseye --target standard .
docker build -t sigblue/apache-php:81-full --build-arg VERSION=8.1-apache-bullseye --target full .
