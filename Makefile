ORGANIZATION := segence
REPOSITORY := $(shell basename -s .git `git config --get remote.origin.url`)
VERSION := $(shell git tag --points-at HEAD)

all:
	@echo "Use a specific goal. To list all goals, type 'make help'"

.PHONY: build # Builds Docker image
build:
	@docker build -t $(ORGANIZATION)/$(REPOSITORY):$(VERSION) .

.PHONY: build-jenkins # Builds Docker image having the correct user set up for Jenkins CI
build-jenkins:
	@docker build -f Dockerfile.jenkins -t $(ORGANIZATION)/$(REPOSITORY):$(VERSION)-jenkins .

.PHONY: push # Pushes Docker image
push:
	@docker push $(ORGANIZATION)/$(REPOSITORY):$(VERSION)

.PHONY: release # Releases new tag; arguments: 'version=[semver version number]': define the version to release
release:
ifndef version
	$(error version parameter is undefined)
endif
	@git tag $(version)
	@git push --tags

.PHONY: help # Generate list of targets with descriptions
help:
	@grep '^.PHONY: .* #' Makefile | sed 's/\.PHONY: \(.*\) # \(.*\)/\1: \2/'
