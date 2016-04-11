# Dockerfile - Ubuntu Trusty
#
# Installs Solarflare's OpenOnload into Ubuntu Trusty.
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

FROM ubuntu:trusty

MAINTAINER Evan Wies <evan@neomantra.net>


# Install OpenOnload build dependencies
RUN DEBIAN_FRONTEND=noninteractive apt-get update -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    wget coreutils \
    perl autoconf automake libtool tar gcc make net-tools ethtool \
    valgrind libpcap0.8-dev python-dev \
    gcc-multilib libc6-dev-i386


# Onload version and its md5sum
ARG ONLOAD_VERSION="201509-u1"
ARG ONLOAD_MD5SUM="01192799b6e932a043fdf27f5c28e6be"


# Download and verify OpenOnload from Solarflare's site
WORKDIR /tmp
ADD http://www.openonload.org/download/openonload-${ONLOAD_VERSION}.tgz /tmp/openonload-${ONLOAD_VERSION}.tgz
RUN echo "${ONLOAD_MD5SUM} openonload-${ONLOAD_VERSION}.tgz" | md5sum --check


# Extract, build, and install onload
RUN tar -zxf openonload-${ONLOAD_VERSION}.tgz
WORKDIR /tmp/openonload-${ONLOAD_VERSION}/scripts
RUN ./onload_build --user
RUN ./onload_install --userfiles --nobuild


# Cleanup
RUN rm -rf /tmp/openonload-${ONLOAD_VERSION}.tgz /tmp/openonload-${ONLOAD_VERSION}
WORKDIR /
