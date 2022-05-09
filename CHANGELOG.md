# docker-onload CHANGELOG

## 2022-05-08 (tagged 7.1.3.202) 

  * Migrate to latest downloads at Xilinx Support
  * Add Ubuntu `jammy` flavor

## 2022-03-30

  * Update to Onload 7.1.3.202 (#8)
  * `centos8` image (from EOL Centos 8) now uses yum repo http://vault.centos.org

## 2021-07-12 (tagged 7.1.2.141)

 * Update to Onload 7.1.2.141
 * Add `bullseye` image to automated build as it can now be built from release.

## 2021-05-21 (untagged)

 * Add `bullseye` flavor which can be built from Git.
   There is no automated build for it.

## 2021-05-09 (tagged 7.1.1.75)

 * Update to Onload 7.1.1.75
 * Only build 64-bit userspace components (no 32-bit applications)
 * `focal` flavor builds with GCC 10
 * Archive `precise` flavor
 * Travis build with `docker_build_and_push_flavor.sh`
 * Move to travis-ci.com

## 2020-10-31 (tagged 7.1.0.265)

 * Add `centos8` flavor
 * Rename `centos` to `centos7`
 * Update to Solarflare download URLs
 * Fix broken args in `build_all_images.sh`

## 2020-05-06 (tagged 7.1.0.265)

 * Update to Onload 7.1.0.265

## 2020-04-23 (tagged 7.0.0.176)

 * Remove Ubuntu `disco` flavor (end of life)
 * Move stale Dockerfiles to `_archive` folder

## 2020-04-12 (tagged 7.0.0.176)

 * Add Ubuntu `focal` flavor.
 * Remove Ubuntu `cosmic` flavor (end of life)

## 2020-02-12 (tagged 7.0.0.176)

 * Add Solarflare upstream ONLOAD_PACKAGE_URL
 * Add Debian `buster` flavor, derived from `buster-slim`
 * Add `build_onload_image.rb` helper script

## 2020-02-07

 * Update to OpenOnload 7.0.0.176 (#3)
 * Support building from new OpenOnload packaging with ONLOAD_PACKAGE_URL
 * Add ONLOAD_LEGACY_URL build arg

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
