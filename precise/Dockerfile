# Dockerfile - Ubuntu Precise
#
# Installs Solarflare's OpenOnload into Ubuntu Trusty.
#
# OpenOnload web page:
#    https://www.openonload.org/
#
# To expose the host and onload to this container, run like this:
#
#   docker run --net=host --device=/dev/onload --device=/dev/onload_epoll --device=/dev/onload_cplane -it ONLOAD_ENABLED_IMAGE_ID [COMMAND] [ARG...]
#
# NOTE: The host's OpenOnload version must be the same as the container's.
#
# Copyright (c) 2018 Neomantra BV
# Released under the MIT License, see LICENSE.txt
#

ARG ONLOAD_DEBIAN_BASE="ubuntu"
ARG ONLOAD_DEBIAN_TAG="precise"

FROM ${ONLOAD_DEBIAN_BASE}:${ONLOAD_DEBIAN_TAG}

MAINTAINER Evan Wies <evan@neomantra.net>

# Onload version and its md5sum
ARG ONLOAD_VERSION="201811"
ARG ONLOAD_MD5SUM="fde70da355e11c8b4114b54114a35de1"

# When ONLOAD_WITHZF is non-empty, the build includes Solarflare's TCPDirect library.
# Default is to exclude it.
ARG ONLOAD_WITHZF

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
        libc6-dev-i386 \
        libpcap0.8-dev \
        libtool \
        make \
        module-init-tools \
        net-tools \
        perl \
        python-dev \
        tar \
        valgrind \
        wget \
    && cd /tmp \
    && curl -fSL https://www.openonload.org/download/openonload-${ONLOAD_VERSION}.tgz -o /tmp/openonload-${ONLOAD_VERSION}.tgz \
    && echo "${ONLOAD_MD5SUM}  openonload-${ONLOAD_VERSION}.tgz" | md5sum --check \
    && tar -zxf openonload-${ONLOAD_VERSION}.tgz \
    && cd /tmp/openonload-${ONLOAD_VERSION}/scripts \
    && ./onload_build --user \
    && ./onload_install --userfiles --nobuild \
    && cd /tmp \
    && rm -rf openonload-${ONLOAD_VERSION}.tgz openonload-${ONLOAD_VERSION} \
    && if [ -z ${ONLOAD_WITHZF} ] ; then rm -rf /usr/include/zf /usr/bin/zf_stackdump /usr/bin/zf_debug /usr/lib/x86_64-linux-gnu/zf /usr/lib/x86_64-linux-gnu/libonload_zf* ; fi \
    && DEBIAN_FRONTEND=noninteractive apt-get remove -y --purge \
        curl \
    && DEBIAN_FRONTEND=noninteractive apt-get autoremove -y

# TODO: which apt packages can we remove?
