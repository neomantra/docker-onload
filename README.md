# docker-onload

[![Travis Status](https://travis-ci.com/neomantra/docker-onload.svg?branch=master)](https://travis-ci.com/neomantra/docker-onload)  [![](https://images.microbadger.com/badges/image/neomantra/onload.svg)](https://microbadger.com/#/images/neomantra/onload "microbadger.com")

`docker-onload` provides a Dockerfile which installs Solarflare's [OpenOnload](https://www.openonload.org/ "OpenOnload") into various OS flavors. Find it on the Docker Hub: https://hub.docker.com/r/neomantra/onload/

See changes in the [CHANGELOG](https://github.com/neomantra/docker-onload/blob/master/CHANGELOG.md).

The `onload` image is built with `ONLOAD_WITHZF` set, thus without support for [TCPDirect](#tcpdirect) (aka ZF).  This is due to licensing restrictions.

----

## Supported Docker Hub tags for image `neomantra/onload` and respective `Dockerfile` links

These unversioned image tags currently map to `7.1.1.75`:

- [`centos7` (*centos7/Dockerfile*)](https://github.com/neomantra/docker-onload/blob/master/centos7/Dockerfile)
- [`centos8` (*centos8/Dockerfile*)](https://github.com/neomantra/docker-onload/blob/master/centos8/Dockerfile)
- [`stretch` (*stretch/Dockerfile*)](https://github.com/neomantra/docker-onload/blob/master/stretch/Dockerfile)
- [`buster` (*buster/Dockerfile*)](https://github.com/neomantra/docker-onload/blob/master/buster/Dockerfile)
- [`trusty` (*trusty/Dockerfile*)](https://github.com/neomantra/docker-onload/blob/master/trusty/Dockerfile)
- [`xenial` (*xenial/Dockerfile*)](https://github.com/neomantra/docker-onload/blob/master/xenial/Dockerfile)
- [`bionic` (*bionic/Dockerfile*)](https://github.com/neomantra/docker-onload/blob/master/bionic/Dockerfile)
- [`focal` (*focal/Dockerfile*)](https://github.com/neomantra/docker-onload/blob/master/focal/Dockerfile)

The following versioned tags are available:

- `7.1.1.75-centos7-nozf`
- `7.1.1.75-centos8-nozf`
- `7.1.1.75-stretch-nozf`
- `7.1.1.75-buster-nozf`
- `7.1.1.75-trusty-nozf`
- `7.1.1.75-xenial-nozf`
- `7.1.1.75-bionic-nozf`
- `7.1.1.75-focal-nozf`

<details>
  <summary>Older Tags</summary>

- `7.1.0.265-centos7-nozf`
- `7.1.0.265-centos8-nozf`
- `7.1.0.265-precise-nozf`
- `7.1.0.265-trusty-nozf`
- `7.1.0.265-stretch-nozf`
- `7.1.0.265-xenial-nozf`
- `7.1.0.265-bionic-nozf`
- `7.1.0.265-cosmic-nozf`
- `7.1.0.265-disco-nozf`
- `7.1.0.265-focal-nozf`
- `7.1.0.265-buster-nozf`
- `7.0.0.176-centos-nozf`
- `7.0.0.176-precise-nozf`
- `7.0.0.176-trusty-nozf`
- `7.0.0.176-stretch-nozf`
- `7.0.0.176-xenial-nozf`
- `7.0.0.176-bionic-nozf`
- `7.0.0.176-cosmic-nozf`
- `7.0.0.176-disco-nozf`
- `7.0.0.176-focal-nozf`
- `7.0.0.176-buster-nozf`
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

</details>
<br>

----

## Launching Onload-enabled containers

Onload-enabled contaiers require exposing the host network and onload devices, so run like so:
```
docker run --net=host --device=/dev/onload --device=/dev/onload_epoll -it ONLOAD_ENABLED_IMAGE_ID [COMMAND] [ARG...]
```

The OpenOnload `201606` series also requires `--device=/dev/onload_cplane`.  Using `ef_vi` or [TCPDirect](#tcpdirect) requires `--device=/dev/sfc_char`.

Here's a bash one-liner for extracting the OpenOnload version year:
`onload --version | awk 'NR == 1 {print substr($2, 1, 4)}'`

## Cavets

 * Host networking must be used: `--net=host`

 * The following devices must be exported: `--device=/dev/onload --device=/dev/onload_epoll`.

 * The OpenOnload `201606` series also requires `--device=/dev/onload_cplane`.

 * Using `ef_vi` or [TCPDirect](#tcpdirect) requires `--device=/dev/sfc_char`.

 * The host's `onload --version` must be the same as the container's.

 * *Stack Sharing*: If a container and the host must share an Onload stack, both should use `EF_SHARE_WITH=-1` to avoid a current limitation in OpenOnload.  Note this disables the stack sharing security feature.

 * Due to a current limitation with OpenOnload, you should run with `EF_USE_HUGE_PAGES=0` if you share Onload stacks.

 * Some libraries, such as [jemalloc](http://jemalloc.net/) need to invoke syscalls at startup.  This can cause infinite loops because the OpenOnload acceleration also needs malloc (via dlsym); see jemalloc issues [443](https://github.com/jemalloc/jemalloc/issues/443) and [1426](https://github.com/jemalloc/jemalloc/issues/1426).  This can be alleviated by setting `ONLOAD_DISABLE_SYSCALL_HOOK=1`; note you will also need to set `ONLOAD_USERSPACE_ID` to match the unpatched driver version. **NOTE:** This may have been fixed in `7.0.0.176`: "SF-122792-KI/bug62297: avoid hang at app startup with jemalloc".

 * These OpenOnload builds default to using `-march` and `-mtune` based on the CPU-type of the build machine.  This might not be optimial or runnable on your runtime platform.  A future release will allow this to be specified as Docker build arguments.


## TCPDirect

In OpenOnload 201606-u1, Solarflare introducted a new kernel-bypass networking API named *TCPDirect*.

To run TCPDirect applications in a container, an addition device must be exported:
`--device=/dev/sfc_char`

TCPDirect is under a different license than OpenOnload; its binaries may not be distributed.
Thus, the `onload` public image on [Docker Hub](https://hub.docker.com/r/neomantra/onload/) does not have TCPDirect
support.

You are free to build and deploy TCPDirect-enabled images yourself with the regular Dockerfiles.
To do so, set the build argument `ONLOAD_WITHZF` to a non-empty string (the Dockerfile checks `[ -z ${ONLOAD_WITHZF} ]`).
For example:

```
git clone https://github.com/neomantra/docker-onload.git
cd docker-onload
docker build --build-arg ONLOAD_WITHZF=1 -f xenial/Dockerfile -t neomantra/onload:201606-u1-xenial .
```

## Image Building Helper Script

The Ruby script `build_onload_image.rb` helps generate command lines for building Onload images.

```
$ ./build_onload_image.rb --help
build_onload_image.rb [options]

    --versions                show list of onload version name (use with -v to show all fields)
    --flavors                 show list of image flavors

    --onload   -o  <version>  show docker build for OpenOnload <version>
    --flavor   -f  <flavor>   add <flavor> to build

    --url      -u <url>       Override URL for "packaged" versions.

    --tag      -t <tag>       tag image as <tag>
    --autotag  -a <prefix>    tag image as <prefix><version>-<flavor>[-nozf]. 
                              <prefix> is optional, but note without a <prefix> with colon,
                              the autotag will be a name not an image-name:tag

    --zf                      build with TCPDirect (zf)

    --arg          <arg>      pass '--build-arg <arg>' to "docker build"

    --quiet    -q             build quietly (pass -q to "docker build")
    --no-cache                pass --no-cache to "docker build"

    --execute  -x             also execute the build line

    --verbose  -v             verbose output
    --help     -h             show this help
```

Example usage:

```
./build_onload_image.rb -o 7.1.1.75 --arg foo -f buster --zf -x
```

There are also `build_all_flavors.sh` and `build_all_images.sh`.

## Customized Image Building

Dockerfiles are provided for the following base systems, selecting the Dockerfile path with `-f`:

 * [CentOS 7](https://github.com/neomantra/docker-onload/centos7/Dockerfile) (`centos7/Dockerfile`)
 * [CentOS 8](https://github.com/neomantra/docker-onload/centos8/Dockerfile) (`centos8/Dockerfile`)
 * [Debian Stretch](https://github.com/neomantra/docker-onload/stretch/Dockerfile) (`stretch/Dockerfile`)
 * [Debian Buster](https://github.com/neomantra/docker-onload/buster/Dockerfile) (`buster/Dockerfile`)
 * [Ubuntu Trusty](https://github.com/neomantra/docker-onload/trusty/Dockerfile) (`trusty/Dockerfile`)
 * [Ubuntu Xenial](https://github.com/neomantra/docker-onload/xenial/Dockerfile) (`xenial/Dockerfile`)
 * [Ubuntu Bionic](https://github.com/neomantra/docker-onload/bionic/Dockerfile) (`bionic/Dockerfile`)
  * [Ubuntu Focal](https://github.com/neomantra/docker-onload/focal/Dockerfile) (`focal/Dockerfile`)

Each system folder has a `Dockerfile`.
 
The following are the available build-time options. They can be set using the `--build-arg` CLI argument, like so:

```
docker build --build-arg ONLOAD_VERSION="201509" --build-arg ONLOAD_MD5SUM="b093ea9f3a534c9c9fe9da6c2b6ccb7a" -f trusty/Dockerfile .
```

The Dockerfile downloads specific versions from [openonload.org](https://openonload.org "openonload.org") using the following `ARG` settings:

| Key  | Default | Description |
:----- | :-----: |:----------- |
|ONLOAD_VERSION | "7.1.1.75" |The version of OpenOnload to download. |
|ONLOAD_MD5SUM | "39b2d8d40982f6f3afd3cdb084969e90" |The MD5 checksum of the download. |
|ONLOAD_PACKAGE_URL | (see below) | If set, it will download and unzip the tarball from the newer packaging. |
|ONLOAD_LEGACY_URL | (see below) | Download the OpenOnload tarball from this URL, `ONLOAD_PACKAGE_URL` has priority. |
|ONLOAD_WITHZF | |Set to non-empty to include TCPDirect. |
|ONLOAD_DISABLE_SYSCALL_HOOK | |Set to non-empty to disables hooking the syscall function from libc. |
|ONLOAD_USERSPACE_ID | |Set to non-empty to specify the userspace build md5sum ID. |

`ONLOAD_PACKAGE_URL` defaults to https://support-nic.xilinx.com/wp/onload?sd=SF-109585-LS-35&pe=SF-122921-DH-4

`ONLOAD_LEGACY_URL` defaults to https://www.openonload.org/download/openonload-${ONLOAD_VERSION}.tgz.   If you want to build from a legacy (non-packaged) URL, you must also set `ONLOAD_PACKAGE_URL` to `''` (empty string).

If you change the `ONLOAD_VERSION`, you must also change `ONLOAD_MD5SUM` to match. Note that Docker is only supported by OpenOnload since version 201502.

If you patch OpenOnload, you must specify `ONLOAD_USERSPACE_ID` to match the ID of the driver.  It can be found in the build tree at `./build/gnu_x86_64/lib/transport/ip/uk_intf_ver.h`. The following are driver interface IDs we have recorded:

| OpenOnload Version | Driver Interface ID |
:----------- |:------------------- |
| 7.1.1.75   | 65869c81c4a7f92b75316cf88446a9f1 |
| 7.1.0.265  | d9857bc9bddb5c6abdeb3f22d69b21d1 |
| 7.0.0.176  | 6ac17472788a64c61013f3d7ed9ae4c9 |
| 201811     | 357bb6508f1e324ea32da88f948efafa |
| 201811-u1  | 2d850c0cd0616655dc3e31c7937acaf7 |

## License

Copyright (c) 2015-2021 Neomantra BV

Released under the MIT License, see LICENSE.txt
