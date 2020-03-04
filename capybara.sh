#!/bin/bash
set -eu -o pipefail

if [[ $(command -v podman) ]]; then
  podman container run \
    --name capybara$$ \
    --rm \
    --security-opt label=disable \
    -t \
    -v "$PWD":/work \
    shakiyam/capybara "$@"
else
  docker container run \
    --name capybara$$ \
    --rm \
    -t \
    -u "$(id -u):$(id -g)" \
    -v "$PWD":/work:ro \
    shakiyam/capybara "$@"
fi
