#!/bin/bash -x
# Builds and pushes flavors, with image names based on TRAVIS variables
#
# ./docker_build_and_push_flavor.sh FLAVOR [DOCKERFILE_PATH] [BUILD PARAMS]
#
# Environment Variables
#  DOCKER_ORG
#  DOCKER_USERNAME
#  DOCKER_TOKEN
#  IMAGE_NAME
#  GITHUB_REF_NAME
#  GITHUB_REF_TYPE
#

set -e

if [ -z "$DOCKER_ORG" ] ; then
    echo "missing env DOCKER_ORG" >&2
    exit 1
fi


FLAVOR="$1"
shift
DOCKERFILE_PATH=${1:-$FLAVOR/Dockerfile}
shift
DOCKER_BUILD_PARAMS="$@"

IMAGE_NAME="${IMAGE_NAME:-onload}"

docker_login_from_file () {
    if [ -f "$DOCKER_PASSFILE" ] ; then
        cat "$DOCKER_PASSFILE" | docker login -u="$DOCKER_USERNAME" --password-stdin
    fi
}


docker_login_from_file

docker build -t $IMAGE_NAME:$FLAVOR -f $DOCKERFILE_PATH $DOCKER_BUILD_PARAMS .

if [[ "$GITHUB_REF_NAME" == "master" ]] ; then
    docker_login_from_file &&
    docker tag $IMAGE_NAME:$FLAVOR $DOCKER_ORG/$IMAGE_NAME:$FLAVOR &&
    docker push $DOCKER_ORG/$IMAGE_NAME:$FLAVOR ;
fi

if [[ "$GITHUB_REF_TYPE" == "tag" ]] ; then
    docker_login_from_file &&
    docker tag $IMAGE_NAME:$FLAVOR $DOCKER_ORG/$IMAGE_NAME:$GITHUB_REF_NAME-$FLAVOR &&
    docker push $DOCKER_ORG/$IMAGE_NAME:$GITHUB_REF_NAME-$FLAVOR ;
fi
