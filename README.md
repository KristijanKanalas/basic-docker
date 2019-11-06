# Basic docker [![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/kristijank/basic-docker.svg)](https://hub.docker.com/r/kristijank/basic-docker/builds) ![MicroBadger Size](https://img.shields.io/microbadger/image-size/kristijank/basic-docker.svg) ![Docker Pulls](https://img.shields.io/docker/pulls/kristijank/basic-docker.svg) [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
Basic PHP + NGINX + SUPERVISOR docker development setup

Contains:
- NGINX
- PHP-7.2-fpm
- Supervisor

## Usage

You can build your image or pull the image from official DockerHub repository

```
docker pull kristijank/basic-docker
```

After the image is pulled you can run the `docker run` command
```
docker run -d -p 8000:80 --name $docker-container-name kristijank/basic-docker -v $path-to-project:/var/www
```

- Port `8000` might be in use on your host so feel free to change it
- `$docker-container-name` is the name of the container you are about to create
- `$path-to-project` is the absolute path to the project you want to be mounted inside your container so you can start development right away

**Note**: `composer.json` is empty and exists only for the build to pass, you can override it. 
## Author
- Kristijan Kanalaš (kanalaskristijan@gmail.com)

## Support
If you would like to support me

[![](https://cdn.buymeacoffee.com/buttons/default-blue.png)](https://www.buymeacoffee.com/wSd4q6U)
