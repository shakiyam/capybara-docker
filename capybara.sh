#!/bin/bash
set -eu -o pipefail

if [[ $(command -v podman) ]]; then
  podman container run \
    --name capybara$$ \
    --net "${NETWORK:-bridge}" \
    --rm \
    -t \
    --security-opt label=disable \
    -v "$PWD":/work:ro \
    shakiyam/capybara "$@"
else
  docker container run \
    --name capybara$$ \
    --net "${NETWORK:-bridge}" \
    --rm \
    -t \
    -u "$(id -u):$(id -g)" \
    -v "$PWD":/work:ro \
    shakiyam/capybara "$@"
fi
