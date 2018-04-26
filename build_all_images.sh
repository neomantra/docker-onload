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
    'bionic'
)

for DIST in "${DISTS[@]}"; do
    cd $DIST
    echo $DIST
    time docker build -q --no-cache -f .
    time docker build -q --no-cache -f --build-arg ONLOAD_WITHZF=1 .
    cd ..
done
