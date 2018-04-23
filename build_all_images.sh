#!/bin/bash
#
# build_all_images.sh
#
# Builds all the images in this repo.
# Handy for quality control before push
#

DISTS=(
    'centos'
    'precise'
    'stretch'
    'trusty'
    'xenial'
)

for DIST in "${DISTS[@]}"; do
    cd $DIST
    echo $DIST
    time docker build -q --no-cache  .
    time docker build -q --no-cache --build-arg ONLOAD_WITHZF=1 .
    cd ..
done
