# docker-onload CHANGELOG

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
