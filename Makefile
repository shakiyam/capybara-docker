MAKEFLAGS += --warn-undefined-variables
SHELL := /bin/bash
.SHELLFLAGS := -eu -o pipefail -c
.DEFAULT_GOAL := help
.SUFFIXES:

ALL_TARGETS := $(shell egrep -o ^[0-9A-Za-z_-]+: $(MAKEFILE_LIST) | sed 's/://')

.PHONY: $(ALL_TARGETS)

all: shellcheck hadolint rubocop update_lockfile build rspec ## Lint, update Gemfile.lock, build, and test
	@:

build: ## Build an image from a Dockerfile
	@echo -e "\033[36m$@\033[0m"
	@./build.sh

hadolint: ## Lint Dockerfile
	@echo -e "\033[36m$@\033[0m"
	@hadolint --ignore DL3018 Dockerfile

rspec: build ## Test the applicattion
	@echo -e "\033[36m$@\033[0m"
	@./capybara.sh

rubocop: ## Check for Ruby scripts
	@echo -e "\033[36m$@\033[0m"
	@rubocop

shellcheck: ## Lint shell scripts
	@echo -e "\033[36m$@\033[0m"
	@shellcheck capybara.sh *.sh

update_lockfile: ## Update Gemfile.lock
	@echo -e "\033[36m$@\033[0m"
	@./update_lockfile.sh

help: ## Print this help
	@echo 'Usage: make [target]'
	@echo ''
	@echo 'Targets:'
	@awk 'BEGIN {FS = ":.*?## "} /^[0-9A-Za-z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
