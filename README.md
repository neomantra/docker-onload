# docker-onload

[![Travis Status](https://travis-ci.org/neomantra/docker-onload.svg?branch=master)](https://travis-ci.org/neomantra/docker-onload)  [![](https://images.microbadger.com/badges/image/neomantra/onload.svg)](https://microbadger.com/#/images/neomantra/onload "microbadger.com")

`docker-onload` provides a Dockerfile which installs Solarflare's [OpenOnload](https://www.openonload.org/ "OpenOnload") into various OS flavors. Find it on the Docker Hub: https://hub.docker.com/r/neomantra/onload/

See changes in the [CHANGELOG](https://github.com/neomantra/docker-onload/blob/master/CHANGELOG.md).

## Supported Docker Hub tags for image `neomantra/onload` and respective `Dockerfile` links

- [`centos-nozf` (*centos/Dockerfile*)](https://github.com/neomantra/docker-onload/blob/master/centos/Dockerfile)
- [`precise-nozf` (*precise/Dockerfile*)](https://github.com/neomantra/docker-onload/blob/master/precise/Dockerfile)
- [`stretch-nozf` (*stretch/Dockerfile*)](https://github.com/neomantra/docker-onload/blob/master/stretch/Dockerfile)
- [`trusty-nozf` (*trusty/Dockerfile*)](https://github.com/neomantra/docker-onload/blob/master/trusty/Dockerfile)
- [`xenial-nozf` (*xenial/Dockerfile*)](https://github.com/neomantra/docker-onload/blob/master/xenial/Dockerfile)
- [`bionic-nozf` (*bionic/Dockerfile*)](https://github.com/neomantra/docker-onload/blob/master/bionic/Dockerfile)
- [`cosmic-nozf` (*cosmic/Dockerfile*)](https://github.com/neomantra/docker-onload/blob/master/cosmic/Dockerfile)
- [`disco-nozf` (*disco/Dockerfile*)](https://github.com/neomantra/docker-onload/blob/master/disco/Dockerfile)
- `201811-u1-centos-nozf`
- `201811-u1-precise-nozf`
- `201811-u1-trusty-nozf`
- `201811-u1-stretch-nozf`
- `201811-u1-xenial-nozf`
- `201811-u1-bionic-nozf`
- `201811-u1-cosmic-nozf`
- `201811-u1-disco-nozf`
- `201811-centos-nozf`
- `201811-precise-nozf`
- `201811-trusty-nozf`
- `201811-stretch-nozf`
- `201811-xenial-nozf`
- `201811-bionic-nozf`
- `201811-cosmic-nozf`
- `201805-u1-centos-nozf`
- `201805-u1-precise-nozf`
- `201805-u1-trusty-nozf`
- `201805-u1-stretch-nozf`
- `201805-u1-xenial-nozf`
- `201805-u1-bionic-nozf`
- `201805-u1-cosmic-nozf`
- `201805-centos-nozf`
- `201805-precise-nozf`
- `201805-trusty-nozf`
- `201805-stretch-nozf`
- `201805-xenial-nozf`
- `201805-bionic-nozf`
- `201710-u1.1-centos-nozf`
- `201710-u1.1-precise-nozf`
- `201710-u1.1-trusty-nozf`
- `201710-u1.1-stretch-nozf`
- `201710-u1.1-xenial-nozf`
- `201710-u1.1-bionic-nozf`
- `201710-u1-centos-nozf`
- `201710-u1-precise-nozf`
- `201710-u1-trusty-nozf`
- `201710-u1-stretch-nozf`
- `201710-u1-xenial-nozf`
- `201710-centos-nozf`
- `201710-precise-nozf`
- `201710-trusty-nozf`
- `201710-stretch-nozf`
- `201710-xenial-nozf`
- `201606-u1.3-centos-nozf`
- `201606-u1.3-precise-nozf`
- `201606-u1.3-trusty-nozf`
- `201606-u1.3-xenial-nozf`
- `201606-u1.2-centos-nozf`
- `201606-u1.2-precise-nozf`
- `201606-u1.2-trusty-nozf`
- `201606-u1.2-xenial-nozf`
- `201606-u1.1-centos-nozf`
- `201606-u1.1-precise-nozf`
- `201606-u1.1-trusty-nozf`
- `201606-u1.1-xenial-nozf`
- `201606-u1-centos-nozf`
- `201606-u1-precise-nozf`
- `201606-u1-trusty-nozf`
- `201606-u1-xenial-nozf`
- `201606-centos`
- `201606-precise`
- `201606-trusty`
- `201606-xenial`
- `201509-u1-centos`
- `201509-u1-precise`
- `201509-u1-trusty`
- `201509-u1-xenial`

**NOTE** Since version 201606-u1, Docker Hub hosts images tagged as a `-nozf` variant.  These are built from [Dockerfile](https://github.com/neomantra/docker-onload/blob/master/xenial/Dockerfile) without `ONLOAD_WITHZF` set, thus without support for [TCPDirect](#tcpdirect) (aka ZF).

[![](https://images.microbadger.com/badges/image/neomantra/onload.svg)](https://microbadger.com/images/neomantra/onload "Get your own image badge on microbadger.com")

### Launching Onload-enabled containers

Onload-enabled contaiers require exposing the host network and onload devices, so run like so:
```
docker run --net=host --device=/dev/onload --device=/dev/onload_epoll -it ONLOAD_ENABLED_IMAGE_ID [COMMAND] [ARG...]
```

The OpenOnload `201606` series also requires `--device=/dev/onload_cplane`.  Using `ef_vi` or [TCPDirect](#tcpdirect) requires `--device=/dev/sfc_char`.

Here's a bash one-liner for extracting the OpenOnload version year:
`onload --version | awk 'NR == 1 {print substr($2, 1, 4)}'`

### Cavets

 * Host networking must be used: `--net=host`

 * The following devices must be exported: `--device=/dev/onload --device=/dev/onload_epoll`.

 * The OpenOnload `201606` series also requires `--device=/dev/onload_cplane`.

 * Using `ef_vi` or [TCPDirect](#tcpdirect) requires `--device=/dev/sfc_char`.

 * The host's `onload --version` must be the same as the container's.

 * *Stack Sharing*: If a container and the host must share an Onload stack, both should use `EF_SHARE_WITH=-1` to avoid a current limitation in OpenOnload.  Note this disables the stack sharing security feature.

 * Due to a current limitation with OpenOnload, you should run with `EF_USE_HUGE_PAGES=0` if you share Onload stacks.

 * Some libraries, such as [jemalloc](http://jemalloc.net/) need to invoke syscalls at startup.  This can cause infinite loops because the OpenOnload acceleration also needs malloc (via dlsym); see jemalloc issues [443](https://github.com/jemalloc/jemalloc/issues/443) and [1426](https://github.com/jemalloc/jemalloc/issues/1426).  This can be alleviated by setting `ONLOAD_DISABLE_SYSCALL_HOOK=1`; note you will also need to set `ONLOAD_USERSPACE_ID` to match the unpatched driver version. 

 * These OpenOnload builds default to using `-march` and `-mtune` based on the CPU-type of the build machine.  This might not be optimial or runnable on your runtime platform.  A future release will allow this to be specified as Docker build arguments.


### TCPDirect

In OpenOnload 201606-u1, Solarflare introducted a new kernel-bypass networking API named *TCPDirect*.

To run TCPDirect applications in a container, an addition device must be exported:
`--device=/dev/sfc_char`

TCPDirect is under a different license than OpenOnload; its binaries may not be distributed.
Thus, we have introduced a `-nozf` variant for images hosted on [Docker Hub](https://hub.docker.com/r/neomantra/onload/).

You are free to build and deploy TCPDirect-enabled images yourself with the regular Dockerfiles.
To do so, set the build argument `ONLOAD_WITHZF` to a non-empty string (the Dockerfile checks `[ -z ${ONLOAD_WITHZF} ]`).
For example:

```
git clone https://github.com/neomantra/docker-onload.git
cd docker-onload
docker build --build-arg ONLOAD_WITHZF=1 -f xenial/Dockerfile -t neomantra/onload:201606-u1-xenial .
```

### Customizing

Dockerfiles are provided for the following base systems, selecting the Dockerfile path with `-f`:

 * [CentOS 7](https://github.com/neomantra/docker-onload/centos/Dockerfile) (`centos/Dockerfile`)
 * [Debian Stretch](https://github.com/neomantra/docker-onload/stretch/Dockerfile) (`stretch/Dockerfile`)
 * [Ubuntu Precise](https://github.com/neomantra/docker-onload/precise/Dockerfile) (`precise/Dockerfile`)
 * [Ubuntu Trusty](https://github.com/neomantra/docker-onload/trusty/Dockerfile) (`trusty/Dockerfile`)
 * [Ubuntu Xenial](https://github.com/neomantra/docker-onload/xenial/Dockerfile) (`xenial/Dockerfile`)
 * [Ubuntu Bionic](https://github.com/neomantra/docker-onload/bionic/Dockerfile) (`bionic/Dockerfile`)
 * [Ubuntu Cosmic](https://github.com/neomantra/docker-onload/cosmic/Dockerfile) (`cosmic/Dockerfile`)
 * [Ubuntu Disco](https://github.com/neomantra/docker-onload/disco/Dockerfile) (`disco/Dockerfile`)

Each system folder has a `Dockerfile`.
 
The following are the available build-time options. They can be set using the `--build-arg` CLI argument, like so:

```
docker build --build-arg ONLOAD_VERSION="201509" --build-arg ONLOAD_MD5SUM="b093ea9f3a534c9c9fe9da6c2b6ccb7a" -f trusty/Dockerfile .
```

The Dockerfile downloads specific versions from [openonload.org](https://openonload.org "openonload.org") using the following `ARG` settings:

| Key  | Default | Description |
:----- | :-----: |:----------- |
|ONLOAD_VERSION | "201811-u1" |The version of OpenOnload to download. |
|ONLOAD_MD5SUM | "357e64862aa4145e49d218fd04e63407" |The MD5 checksum of the download. |
|ONLOAD_WITHZF | |Set to non-empty to include TCPDirect. |
|ONLOAD_DISABLE_SYSCALL_HOOK | |Set to non-empty to disables hooking the syscall function from libc. |
|ONLOAD_USERSPACE_ID | |Set to non-empty to specify the userspace build md5sum ID. |

If you change the `ONLOAD_VERSION`, you must also change `ONLOAD_MD5SUM` to match. Note that Docker is only supported by OpenOnload since version 201502.

If you patch OpenOnload, you must specify `ONLOAD_USERSPACE_ID` to match the ID of the driver.  The following are driver interfae IDs we have recorded:

| OpenOnload Version | Driver Interface ID |
:----------- |:------------------- |
| 201811     | 357bb6508f1e324ea32da88f948efafa |
| 201811-u1  | 2d850c0cd0616655dc3e31c7937acaf7 |

### License

Copyright (c) 2015-2019 Neomantra BV

Released under the MIT License, see LICENSE.txt
