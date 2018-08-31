# Dockerfile - CentOS 7
#
# Installs Solarflare's OpenOnload into CentOS 7.
#
# OpenOnload web page:
#    http://www.openonload.org/
#
# To expose the host and onload to this container, run like this:
#
#   docker run --net=host --device=/dev/onload --device=/dev/onload_epoll --device=/dev/onload_cplane -it ONLOAD_ENABLED_IMAGE_ID [COMMAND] [ARG...]
#
# NOTE: The host's OpenOnload version must be the same as the container's.
#
# Copyright (c) 2017 neomantra BV
# Released under the MIT License, see LICENSE.txt
#

ARG ONLOAD_CENTOS_BASE="centos"
ARG ONLOAD_CENTOS_TAG="7"

FROM ${ONLOAD_CENTOS_BASE}:${ONLOAD_CENTOS_TAG}

MAINTAINER Evan Wies <evan@neomantra.net>

# Onload version and its md5sum
ARG ONLOAD_VERSION="201805-u1"
ARG ONLOAD_MD5SUM="f3b3761b4bfd74fec311fa0fe380ec0a"

# When ONLOAD_WITHZF is non-empty, the build includes Solarflare's TCPDirect library.
# Default is to exclude it.
ARG ONLOAD_WITHZF

# 1) Install OpenOnload build dependencies
# 2) Download and verify OpenOnload from Solarflare's site
# 3) Extract, build, and install onload
# 4) Cleanup

RUN \
    yum install -y \
        autoconf \
        automake \
        bash \
        binutils \
        file \
        gawk \
        gcc \
        gettext \
        glibc-common \
        glibc-devel.i686 \
        glibc-devel.x86_64 \
        kernel-devel \
        libgcc.i686 \
        libgcc.x86_64 \
        libpcap-devel \
        libtool \
        make \
        python-devel \
        sed \
        valgrind-devel \
        which \
    && cd /tmp \
    && curl -fSL http://www.openonload.org/download/openonload-${ONLOAD_VERSION}.tgz -o /tmp/openonload-${ONLOAD_VERSION}.tgz \
    && echo "${ONLOAD_MD5SUM} openonload-${ONLOAD_VERSION}.tgz" | md5sum --check \
    && tar -zxf openonload-${ONLOAD_VERSION}.tgz \
    && cd /tmp/openonload-${ONLOAD_VERSION}/scripts \
    && ./onload_build --user \
    && ./onload_install --userfiles --nobuild \
    && cd /tmp \
    && rm -rf openonload-${ONLOAD_VERSION}.tgz openonload-${ONLOAD_VERSION} \
    && if [ -z ${ONLOAD_WITHZF} ] ; then rm -rf /usr/include/zf /usr/bin/zf_stackdump /usr/bin/zf_debug /usr/lib/x86_64-linux-gnu/zf /usr/lib/x86_64-linux-gnu/libonload_zf* ; fi \
    && yum clean all

# TODO: which yum packages can we remove
