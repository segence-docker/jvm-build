ORGANIZATION := segence
REPOSITORY := $(shell basename -s .git `git config --get remote.origin.url`)
VERSION := $(shell git tag --points-at HEAD)

all:
	@echo "Use a specific goal. To list all goals, type 'make help'"

.PHONY: build # Builds Docker image
build:
	@docker build -t $(ORGANIZATION)/$(REPOSITORY):$(VERSION) .

.PHONY: push # Pushes Docker image
push:
	@docker push $(ORGANIZATION)/$(REPOSITORY):$(VERSION)

.PHONY: help # Generate list of targets with descriptions
help:
	@grep '^.PHONY: .* #' Makefile | sed 's/\.PHONY: \(.*\) # \(.*\)/\1: \2/'
