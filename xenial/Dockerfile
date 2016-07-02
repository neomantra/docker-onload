# Dockerfile - Ubuntu Xenial
#
# Installs Solarflare's OpenOnload into Ubuntu Xenial.
#
# OpenOnload web page:
#    http://www.openonload.org/
#
# To expose the host and onload to this container, run like this:
#
#   docker run --net=host --device=/dev/onload --device=/dev/onload_epoll -it ONLOAD_ENABLED_IMAGE_ID [COMMAND] [ARG...]
#
# NOTE: The host's OpenOnload version must be the same as the container's.
#
# Copyright (c) 2016 neomantra BV
# Released under the MIT License, see LICENSE.txt
#

FROM ubuntu:xenial

MAINTAINER Evan Wies <evan@neomantra.net>

# Onload version and its md5sum
ARG ONLOAD_VERSION="201606"
ARG ONLOAD_MD5SUM="a94dc9b45bda85096814d85e366afdea"


# 1) Install OpenOnload build dependencies
# 2) Download and verify OpenOnload from Solarflare's site
# 3) Extract, build, and install onload
# 4) Cleanup

RUN \
    DEBIAN_FRONTEND=noninteractive apt-get update -y \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        autoconf \
        automake \
        coreutils \
        curl \
        ethtool \
        gcc \
        gcc-multilib \
        kmod \
        libc6-dev-i386 \
        libpcap0.8-dev \
        libtool \
        make \
        net-tools \
        perl \
        python-dev \
        tar \
        valgrind \
        wget \
    && cd /tmp \
    && curl -fSL http://www.openonload.org/download/openonload-${ONLOAD_VERSION}.tgz -o /tmp/openonload-${ONLOAD_VERSION}.tgz \
    && echo "${ONLOAD_MD5SUM} openonload-${ONLOAD_VERSION}.tgz" | md5sum --check \
    && tar -zxf openonload-${ONLOAD_VERSION}.tgz \
    && cd /tmp/openonload-${ONLOAD_VERSION}/scripts \
    && ./onload_build --user \
    && ./onload_install --userfiles --nobuild \
    && cd /tmp \
    && rm -rf openonload-${ONLOAD_VERSION}.tgz openonload-${ONLOAD_VERSION} \
    && DEBIAN_FRONTEND=noninteractive apt-get remove -y --purge \
        curl \
    && DEBIAN_FRONTEND=noninteractive apt-get autoremove -y

# TODO: which apt packages can we remove?
