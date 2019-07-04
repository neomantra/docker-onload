# docker-onload CHANGELOG

## 2019-07-04 (tagged 201811-u1)

 * Update to OpenOnload 201811-u1
 * Add Ubuntu Disco image

## 2019-07-04 (tagged 201811)

 * Fix quoting for ONLOAD_DISABLE_SYSCALL_HOOK and ONLOAD_USERSPACE_ID test

## 2019-06-21

 * Add ONLOAD_DISABLE_SYSCALL_HOOK build-arg
 * Add ONLOAD_USERSPACE_ID build-arg
 * Update docs
 * Add Docker image labels

## 2019-01-16

 * Fixup Centos Dockerfile to support centos:6 (#1, #2)

## 2018-12-03

 * Update to OpenOnload 201811
 * Remove -k from curl and use https since openonload.org now supports SSL

## 2018-10-23

 * Add Ubuntu Cosmic image
 * Pass -k to curl because openonload.org doesn't support SSL
 * Travis builds!

## 2018-08-31

 * Update to OpenOnload 201805-u1

## 2018-05-09

 * Update to OpenOnload 201805

## 2018-04-26

 * Add Ubuntu Bionic image, with patched OpenOnload 201710-u1.1

## 2018-04-23

 * Update to OpenOnload 201710-u1.1

## 2018-01-23

 * Update to OpenOnload 201710-u1
 * Add Debian Stretch images, derived from `stretch-slim`

## 2017-12-26

 * Parameterize `FROM` stanzas with `ONLOAD_CENTOS_BASE` and `ONLOAD_DEBIAN_BASE`
 * Manage TCPDirect using build-arg `ONLOAD_WITHZF` instead of separate Dockerfiles
 * Remove all the `Dockerfile.nozf` files

## 2017-10-10

 * Update to OpenOnload 201710

## 2017-06-28

 * Update to OpenOnload 201606-u1.3
 * Xenial builds need `libtool-bin` package

## 2017-03-21

 * Update to OpenOnload 201606-u1.2

## 2017-02-02

 * Update to OpenOnload 201606-u1.1
 * Add note about `EF_USE_HUGE_PAGES=0`

## 2017-01-18

 * Add Dockerfile.nozf for Docker Hub builds
 * Add TCPDirect notes
 * Add docs about onload_cplane in Dockerfiles
 * Added `CHANGELOG.md`
