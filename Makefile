ORGANIZATION := segence
REPOSITORY := $(shell basename -s .git `git config --get remote.origin.url`)
VERSION := $(shell git tag --points-at HEAD)

ifdef qualifier
	VERSION := $(VERSION)-$(qualifier)
endif

FONT_ESC := $(shell printf '\033')
FONT_BOLD := ${FONT_ESC}[1m
FONT_NC := ${FONT_ESC}[0m # No colour

all:
	@echo "Use a specific goal. To list all goals, type 'make help'"

.PHONY: build # Builds Docker image
build:
	@docker build -t $(ORGANIZATION)/$(REPOSITORY):$(VERSION) .

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

.PHONY: help # Generate list of goals with descriptions
help:
	@echo "Available goals:\n"
	@grep '^.PHONY: .* #' Makefile | sed "s/\.PHONY: \(.*\) # \(.*\)/${FONT_BOLD}\1:${FONT_NC}\2~~/" | sed $$'s/~~/\\\n/g' | sed $$'s/~/\\\n\\\t/g'
