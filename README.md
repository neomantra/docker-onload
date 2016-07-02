# docker-onload

`docker-onload` provides a Dockerfile which installs Solarflare's [OpenOnload](http://www.openonload.org/ "OpenOnload") into various OS flavors. Find it on the Docker Hub: https://hub.docker.com/r/neomantra/onload/

## Supported tags and respective `Dockerfile` links

- [`centos`, `201509-u1-centos`, (*centos/Dockerfile*)](https://github.com/neomantra/docker-onload/blob/master/centos/Dockerfile)
- [`precise`, `201509-u1-precise`, (*precise/Dockerfile*)](https://github.com/neomantra/docker-onload/blob/master/precise/Dockerfile)
- [`trusty`, `201509-u1-trusty`, (*trusty/Dockerfile*)](https://github.com/neomantra/docker-onload/blob/master/trusty/Dockerfile)
- [`xenial`, `201509-u1-xenial`, (*xenial/Dockerfile*)](https://github.com/neomantra/docker-onload/blob/master/xenial/Dockerfile)

[![](https://imagelayers.io/badge/neomantra/onload:trusty.svg)](https://imagelayers.io/?images=neomantra/onload:trusty 'Get your own badge on imagelayers.io')

### Launching Onload-enabled container

To expose the host and onload to this container, run like this:
```
docker run --net=host --device=/dev/onload --device=/dev/onload_epoll -it ONLOAD_ENABLED_IMAGE_ID [COMMAND] [ARG...]
```

**NOTE:** The host's `onload` version must be the same as the container's.

### Customizing

Dockerfiles are provided for the following base systems, selecting the Dockerfile path with `-f`:

 * [CentOS 7](https://github.com/neomantra/docker-onload/centos/Dockerfile) (`centos/Dockerfile`)
 * [Ubuntu Precise](https://github.com/neomantra/docker-onload/precise/Dockerfile) (`precise/Dockerfile`)
 * [Ubuntu Trusty](https://github.com/neomantra/docker-onload/trusty/Dockerfile) (`trusty/Dockerfile`)
 * [Ubuntu Xenial](https://github.com/neomantra/docker-onload/xenial/Dockerfile) (`xenial/Dockerfile`)

The following are the available build-time options. They can be set using the `--build-arg` CLI argument, like so:

```
docker build --build-arg ONLOAD_VERSION="201509" --build-arg ONLOAD_MD5SUM="b093ea9f3a534c9c9fe9da6c2b6ccb7a" -f trusty/Dockerfile .
```

The Dockerfile downloads specific versions from [openonload.org](http://openonload.org "openonload.org") using the following `ARG` settings:

| Key  | Default | Description |
:----- | :-----: |:----------- |
|ONLOAD_VERSION | "201509-u1" | The version of OpenOnload to download. |
|ONLOAD_MD5SUM | "01192799b6e932a043fdf27f5c28e6be" | The MD5 checksum of the download. |

If you change the `ONLOAD_VERSION`, you must also change `ONLOAD_MD5SUM` to match. Note that Docker is only supported by OpenOnload since version 201502.

### License

Copyright (c) 2016 neomantra BV

Released under the MIT License, see LICENSE.txt
