PROJECT_NAME := arsperger
mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
SERVICE_NAME := $(notdir $(patsubst %/,%,$(dir $(mkfile_path))))
IMAGE_NAME := ${PROJECT_NAME}/${SERVICE_NAME}
RELEASE_VERSION := $(shell cat VERSION)
DISTRO_VERSION := buster

no-cache ?= no

comma := ,
empty :=
space := $(empty) $(empty)
eq = $(if $(or $(1),$(2)),$(and $(findstring $(1),$(2)),\
                                $(findstring $(2),$(1))),1)

no-cache-arg = $(if $(call eq, $(no-cache), yes), --no-cache, $(empty))


all: build

# Build Docker image.
#
# Usage:
#       make build [no-cache=(yes|no)]
build:
	@docker build $(no-cache-arg) --build-arg DISTRO_VERSION=${DISTRO_VERSION} \
				--tag ${IMAGE_NAME}:${RELEASE_VERSION} -f $(PWD)/debian/$(DISTRO_VERSION)/Dockerfile \
				 .

# Remove all stopped containers
clean-container:
	@docker container prune -f

# Remove all dangling images
clean: clean-container
	@docker rmi $(shell docker images --filter "dangling=true" -q --no-trunc)

# Start docker-compose test container
#
# Usage:
#       make test
test:
	@docker-compose -f docker-compose.yml up -d


.PHONY: all build test cleanall clean-container
