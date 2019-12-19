#!/bin/bash
set -eu -o pipefail

readonly IMAGE_NAME='shakiyam/capybara'

docker container run \
  -t \
  --rm \
  -u "$(id -u):$(id -g)" \
  -v "$(cd "$(dirname "$0")" && pwd)":/work:ro \
  "$IMAGE_NAME" "$@"
