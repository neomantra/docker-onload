# Dockerfile - Ubuntu Trusty
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
# Copyright (c) 2019 Neomantra BV
# Released under the MIT License, see LICENSE.txt
#

ARG ONLOAD_DEBIAN_BASE="ubuntu"
ARG ONLOAD_DEBIAN_TAG="trusty"

FROM ${ONLOAD_DEBIAN_BASE}:${ONLOAD_DEBIAN_TAG}

ARG ONLOAD_DEBIAN_BASE="ubuntu"
ARG ONLOAD_DEBIAN_TAG="trusty"

# Onload version and its md5sum
ARG ONLOAD_VERSION="201811"
ARG ONLOAD_MD5SUM="fde70da355e11c8b4114b54114a35de1"

# When ONLOAD_WITHZF is non-empty, the build includes Solarflare's TCPDirect library.
# Default is to exclude it.
ARG ONLOAD_WITHZF

# When ONLOAD_DISABLE_SYSCALL_HOOK is non-empty, then the build disables hooking the syscall function from libc.
# Default is empty, enabling the OpenOnload's default hooking the syscall function.
#
# This only works with OpenOnload 201811 and newer.
#
# Some libraries, such as jemalloc need to invoke syscalls at startup.
# This can cause infinite loops because the OpenOnload acceleration also needs malloc (via dlsym)
#    https://github.com/jemalloc/jemalloc/issues/443
#    https://github.com/jemalloc/jemalloc/issues/1426
ARG ONLOAD_DISABLE_SYSCALL_HOOK

# When ONLOAD_USERSPACE_ID is non-empty, it sets the userspace build md5sum ID.
# Default is empty, using the actual build md5sum ID
#
# This is necessary when the OpenOnload build is patched (for example with ONLOAD_DISABLE_SYSCALL_HOOK).
# The OpenOnload system checks for version and ID matches between userspace and the driver;
# thus one may need to spoof the userspace ID.
ARG ONLOAD_USERSPACE_ID

# 1) Install OpenOnload build dependencies
# 2) Download and verify OpenOnload from Solarflare's site
# 3) Extract, build, and install onload
# 4) Cleanup

RUN \
    DEBIAN_FRONTEND=noninteractive apt-get update -y \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        autoconf \
        automake \
        ca-certificates \
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
        sed \
        tar \
        valgrind \
        wget \
    && cd /tmp \
    && curl -fSL https://www.openonload.org/download/openonload-${ONLOAD_VERSION}.tgz -o /tmp/openonload-${ONLOAD_VERSION}.tgz \
    && echo "${ONLOAD_MD5SUM} openonload-${ONLOAD_VERSION}.tgz" | md5sum --check \
    && tar -zxf openonload-${ONLOAD_VERSION}.tgz \
    && cd /tmp/openonload-${ONLOAD_VERSION} \
    && if [ -n ${ONLOAD_DISABLE_SYSCALL_HOOK} ] ; then \
        echo 'ONLOAD_DISABLE_SYSCALL_HOOK set, disabling CI_CFG_USERSPACE_SYSCALL' \
        && sed -i 's/#define CI_CFG_USERSPACE_SYSCALL        1/#define CI_CFG_USERSPACE_SYSCALL        0 \/\/ disabled by ONLOAD_DISABLE_SYSCALL_HOOK/' ./src/include/ci/internal/transport_config_opt.h ; \
    fi \
    && if [ -n ${ONLOAD_USERSPACE_ID} ] ; then \
        echo "ONLOAD_USERSPACE_ID set, applying userspace interface id '${ONLOAD_USERSPACE_ID}'" \
        && sed -i "s/\$\$md5/${ONLOAD_USERSPACE_ID}/" src/lib/transport/ip/mmake.mk ; \

    fi \
    && cd scripts \
    && ./onload_build --user \
    && ./onload_install --userfiles --nobuild \
    && cd /tmp \
    && rm -rf openonload-${ONLOAD_VERSION}.tgz openonload-${ONLOAD_VERSION} \
    && if [ -z ${ONLOAD_WITHZF} ] ; then \
        rm -rf /usr/include/zf /usr/bin/zf_stackdump /usr/bin/zf_debug /usr/lib/x86_64-linux-gnu/zf /usr/lib/x86_64-linux-gnu/libonload_zf* ; \
    fi \
    && DEBIAN_FRONTEND=noninteractive apt-get remove -y --purge \
        curl \
    && DEBIAN_FRONTEND=noninteractive apt-get autoremove -y

# TODO: which apt packages can we remove?

# Labels for introspection
LABEL maintainer="Evan Wies <evan@neomantra.net>"
LABEL ONLOAD_DEBIAN_BASE="${ONLOAD_DEBIAN_BASE}"
LABEL ONLOAD_DEBIAN_TAG="${ONLOAD_DEBIAN_TAG}"
LABEL ONLOAD_VERSION="${ONLOAD_VERSION}"
LABEL ONLOAD_MD5SUM="${ONLOAD_MD5SUM}"
LABEL ONLOAD_WITHZF="${ONLOAD_WITHZF}"
LABEL ONLOAD_DISABLE_SYSCALL_HOOK="${ONLOAD_DISABLE_SYSCALL_HOOK}"
LABEL ONLOAD_USERSPACE_ID="${ONLOAD_USERSPACE_ID}"
