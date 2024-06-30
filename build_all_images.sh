#!/bin/bash
#
# build_all_images.sh
#
# Builds all the images in this repo.
# Handy for quality control before push
#

#DOCKER_FWD="--no-cache -q "

FLAVOR="${1:-noble}"


for VERSION in $(./build_onload_image.rb --versions); do
    time ./build_onload_image.rb -x -v $DOCKER_FWD -f $FLAVOR -o $VERSION -a ootestbuild:
    time ./build_onload_image.rb -x -v $DOCKER_FWD -f $FLAVOR -o $VERSION -a ootestbuild: --zf
done
