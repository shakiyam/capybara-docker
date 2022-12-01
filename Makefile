MAKEFLAGS += --warn-undefined-variables
SHELL := /bin/bash
.SHELLFLAGS := -eu -o pipefail -c
.DEFAULT_GOAL := help
.SUFFIXES:

ALL_TARGETS := $(shell egrep -o ^[0-9A-Za-z_-]+: $(MAKEFILE_LIST) | sed 's/://')

.PHONY: $(ALL_TARGETS)

all: lint update_lockfile build rspec ## Lint, update Gemfile.lock, build, and test

build: ## Build an image from a Dockerfile
	@echo -e "\033[36m$@\033[0m"
	@./tools/build.sh docker.io/shakiyam/capybara

hadolint: ## Lint Dockerfile
	@echo -e "\033[36m$@\033[0m"
	@./tools/hadolint.sh Dockerfile

help: ## Print this help
	@echo 'Usage: make [target]'
	@echo ''
	@echo 'Targets:'
	@awk 'BEGIN {FS = ":.*?## "} /^[0-9A-Za-z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

lint: hadolint rubocop shellcheck shfmt ## Lint all dependencies

rspec: ## Test capybara
	@echo -e "\033[36m$@\033[0m"
	@./capybara.sh

rubocop: ## Lint Ruby scripts
	@echo -e "\033[36m$@\033[0m"
	@./tools/rubocop.sh

shellcheck: ## Lint shell scripts
	@echo -e "\033[36m$@\033[0m"
	@./tools/shellcheck.sh *.sh tools/*.sh

shfmt: ## Lint shell scripts
	@echo -e "\033[36m$@\033[0m"
	@./tools/shfmt.sh -l -d -i 2 -ci -bn *.sh tools/*.sh

update_lockfile: ## Update Gemfile.lock
	@echo -e "\033[36m$@\033[0m"
	@./tools/update_lockfile.sh
