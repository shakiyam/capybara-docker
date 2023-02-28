#!/bin/bash
set -eu -o pipefail

if [[ $(command -v docker) ]]; then
  docker container run \
    --name capybara$$ \
    --net "${NETWORK:-bridge}" \
    --rm \
    -t \
    -u "$(id -u):$(id -g)" \
    -v "$PWD":/work:ro \
    ghcr.io/shakiyam/capybara "$@"
elif [[ $(command -v podman) ]]; then
  podman container run \
    --name capybara$$ \
    --net "${NETWORK:-bridge}" \
    --rm \
    --security-opt label=disable \
    -t \
    -v "$PWD":/work:ro \
    ghcr.io/shakiyam/capybara "$@"
else
  echo "Neither docker nor podman is installed."
  exit 1
fi
