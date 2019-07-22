# Basic docker [![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/kristijank/basic-docker.svg)](https://hub.docker.com/r/kristijank/basic-docker/builds) ![MicroBadger Size](https://img.shields.io/microbadger/image-size/kristijank/basic-docker.svg) [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
Basic PHP + NGINX docker development setup

Contains:
- NGINX
- PHP-7.2-fpm

## Installation

To install run 
```
git@github.com:KristijanKanalas/basic-docker.git
```
or
```
https://github.com/KristijanKanalas/basic-docker.git
```

## Usage

After cloning the repository, add your project to the folder and run
the `docker build` command in your terminal of choice

```
docker build -t $docker-image-name . 
```

This will build the image and copy the code from the folder into `/var/www`.
Now all you have to do is to run the `docker run` command

```
docker run -d -p 8000:80 --name $docker-container-name $docker-image-name
```

If the port `8000` on your host isn't available you can change the command to use the different port.

**Note**: `composer.json` is there only for the build to pass, you can override it. 

## Author
- Kristijan Kanalaš (kanalaskristijan@gmail.com)
