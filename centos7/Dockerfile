# Dockerfile - CentOS 7
#
# Installs Solarflare's OpenOnload into CentOS 7.
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
# Copyright (c) 2015-2021 Neomantra BV
# Released under the MIT License, see LICENSE.txt
#

ARG ONLOAD_CENTOS_BASE="centos"
ARG ONLOAD_CENTOS_TAG="7"

FROM ${ONLOAD_CENTOS_BASE}:${ONLOAD_CENTOS_TAG}

ARG ONLOAD_CENTOS_BASE="centos"
ARG ONLOAD_CENTOS_TAG="7"

# Onload version and its md5sum
ARG ONLOAD_VERSION="7.1.1.75"
ARG ONLOAD_MD5SUM="39b2d8d40982f6f3afd3cdb084969e90"

# Onload package URL and legacy URL
# If ONLOAD_PACKAGE_URL is set, it will download and unzip the tarball from the newer packaging,
# otherwise it will download the tarball from ONLOAD_LEGACY_URL as before.
ARG ONLOAD_PACKAGE_URL="https://support-nic.xilinx.com/wp/onload?sd=SF-109585-LS-35&pe=SF-122921-DH-4"
ARG ONLOAD_LEGACY_URL="https://www.openonload.org/download/openonload-${ONLOAD_VERSION}.tgz"

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
        glibc-devel.x86_64 \
        kernel-devel \
        libgcc.x86_64 \
        libpcap-devel \
        libtool \
        make \
        module-init-tools \
        python-devel \
        sed \
        tar \
        unzip \
        valgrind-devel \
        which \
    && cd /tmp \
    && if [ -n "${ONLOAD_PACKAGE_URL}" ] ; then \
          curl -fSL "${ONLOAD_PACKAGE_URL}" -o /tmp/onload-${ONLOAD_VERSION}-package.zip \
          && unzip /tmp/onload-${ONLOAD_VERSION}-package.zip \
          && echo "${ONLOAD_MD5SUM} onload-${ONLOAD_VERSION}.tgz" | md5sum --check \
          && tar -zxf onload-${ONLOAD_VERSION}.tgz ; \
    else \
          curl -fSL "${ONLOAD_LEGACY_URL}" -o /tmp/onload-${ONLOAD_VERSION}.tgz \
          && echo "${ONLOAD_MD5SUM} onload-${ONLOAD_VERSION}.tgz" | md5sum --check \
          && tar -zxf onload-${ONLOAD_VERSION}.tgz \
          && mv openonload-${ONLOAD_VERSION} onload-${ONLOAD_VERSION}; \
    fi \
    && cd /tmp/onload-${ONLOAD_VERSION} \
    && if [ -n "${ONLOAD_DISABLE_SYSCALL_HOOK}" ] ; then \
        echo 'ONLOAD_DISABLE_SYSCALL_HOOK set, disabling CI_CFG_USERSPACE_SYSCALL' \
        && sed -i 's/#define CI_CFG_USERSPACE_SYSCALL        1/#define CI_CFG_USERSPACE_SYSCALL        0 \/\/ disabled by ONLOAD_DISABLE_SYSCALL_HOOK/' ./src/include/ci/internal/transport_config_opt.h ; \
    fi \
    && if [ -n "${ONLOAD_USERSPACE_ID}" ] ; then \
        echo "ONLOAD_USERSPACE_ID set, applying userspace interface id '${ONLOAD_USERSPACE_ID}'" \
        && sed -i "s/\$\$md5/${ONLOAD_USERSPACE_ID}/" src/lib/transport/ip/mmake.mk ; \
    fi \
    && cd scripts \
    && ./onload_build --user64 \
    && ./onload_install --userfiles --nobuild \
    && cd /tmp \
    && rm -rf onload-${ONLOAD_VERSION}* \
    && if [ -z ${ONLOAD_WITHZF} ] ; then \
        rm -rf /usr/include/zf /usr/bin/zf_stackdump /usr/bin/zf_debug /usr/lib/x86_64-linux-gnu/zf /usr/lib/x86_64-linux-gnu/libonload_zf* ; \
    fi \
    && yum clean all


# Labels for introspection
LABEL maintainer="Evan Wies <evan@neomantra.net>"
LABEL ONLOAD_CENTOS_BASE="${ONLOAD_CENTOS_BASE}"
LABEL ONLOAD_CENTOS_TAG="${ONLOAD_CENTOS_TAG}"
LABEL ONLOAD_PACKAGE_URL="${ONLOAD_PACKAGE_URL}"
LABEL ONLOAD_LEGACY_URL="${ONLOAD_LEGACY_URL}"
LABEL ONLOAD_VERSION="${ONLOAD_VERSION}"
LABEL ONLOAD_MD5SUM="${ONLOAD_MD5SUM}"
LABEL ONLOAD_WITHZF="${ONLOAD_WITHZF}"
LABEL ONLOAD_DISABLE_SYSCALL_HOOK="${ONLOAD_DISABLE_SYSCALL_HOOK}"
LABEL ONLOAD_USERSPACE_ID="${ONLOAD_USERSPACE_ID}"
