#!/bin/bash
set -eu -o pipefail

readonly IMAGE_NAME='shakiyam/capybara'

current_image="$(docker image ls -q $IMAGE_NAME:latest)"
docker image build \
  --build-arg http_proxy="${http_proxy:-}" \
  --build-arg https_proxy="${https_proxy:-}" \
  -t "$IMAGE_NAME" "$(dirname "$0")"
latest_image="$(docker image ls -q $IMAGE_NAME:latest)"
if [[ "$current_image" != "$latest_image" ]]; then
  docker image tag $IMAGE_NAME:latest $IMAGE_NAME:"$(date +%Y%m%d%H%S)"
fi
