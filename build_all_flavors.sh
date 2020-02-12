#!/bin/bash
#
# build_all_flavors.sh
#
# Builds all the images in this repo.
# Handy for quality control before push
#

#DOCKER_FWD="--no-cache -q "

VERSION="${1:-7.0.0.176}"

for FLAVOR in $(./build_onload_image.rb --flavors); do
    time ./build_onload_image.rb -x -v $DOCKER_FWD -f $FLAVOR -o $VERSION -a ootestbuild:
    time ./build_onload_image.rb -x -v $DOCKER_FWD -f $FLAVOR -o $VERSION -a ootestbuild: --zf
done
