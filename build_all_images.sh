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
    'trusty'
    'xenial'
)

for DIST in "${DISTS[@]}"; do
    cd $DIST
    echo $DIST
    time docker build -q --no-cache -f Dockerfile .
    time docker build -q --no-cache -f Dockerfile.nozf .
    cd ..
done
