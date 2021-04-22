#!/bin/bash
set -eu -o pipefail

readonly IMAGE_NAME='shakiyam/capybara'

DOCKER=$(command -v podman || command -v docker); readonly DOCKER
current_image="$($DOCKER image ls -q $IMAGE_NAME:latest)"
$DOCKER image build \
  -t "$IMAGE_NAME" "$(dirname "$0")"
latest_image="$($DOCKER image ls -q $IMAGE_NAME:latest)"
if [[ "$current_image" != "$latest_image" ]]; then
  $DOCKER image tag $IMAGE_NAME:latest $IMAGE_NAME:"$(date +%Y%m%d%H%S)"
fi
