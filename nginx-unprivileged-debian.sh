#!/bin/bash

MODULES_TO_ADD_LIST=""
IMAGE_NAME_GENERATED=""
BASE_NGINX_IMAGE="nginxinc/nginx-unprivileged:mainline"

# Get the current folder and check if .env file exists before sourcing it
dir="$(dirname "$0")"
if [ -f "$dir/.env" ]; then
    source "$dir/.env"
fi

# Check if the environnement variables are set
if [ -z "${MODULES_TO_ADD_LIST}" ]; then
    echo "MODULES_TO_ADD_LIST is not set"
    exit 1
else
    MODULES_TO_ADD_LIST=${MODULES_TO_ADD_LIST}
fi


if [ -z "${IMAGE_NAME_GENERATED}" ]; then
    echo "IMAGE_NAME_GENERATED is not set"
    exit 1
else
    IMAGE_NAME_GENERATED=${IMAGE_NAME_GENERATED}
fi

# Copy the Dockerfile that will get the module on the host
curl https://raw.githubusercontent.com/nginxinc/docker-nginx/master/modules/Dockerfile > Dockerfile.build.temp

# Change to user root to install the dependencies
sed -i '/SHELL \["\/bin\/bash", "-exo", "pipefail", "-c"\]/N; /SHELL \["\/bin\/bash", "-exo", "pipefail", "-c"\]/a USER root' Dockerfile.build.temp
sed -i '/^FROM ${NGINX_FROM_IMAGE}$/a USER root' Dockerfile.build.temp

# Go back to unprivileged user
echo "USER nginx" >> Dockerfile.build.temp

# Run the dockerfile to generate the clean image with modules
export DOCKER_BUILDKIT=1
docker build -f Dockerfile.build.temp \
    --build-arg ENABLED_MODULES="$MODULES_TO_ADD_LIST" \
    --build-arg NGINX_FROM_IMAGE="$BASE_NGINX_IMAGE" \
    -t "$IMAGE_NAME_GENERATED" \
    .

# Delete the Dockerfile
rm Dockerfile.build.temp