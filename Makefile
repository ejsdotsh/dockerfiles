#!/usr/bin/make -f

# from: https://lithic.tech/blog/2020-05/makefile-dot-env
# if it exists, load .env
ifneq (,$(wildcard ./.env))
	include .env
	export
	ENV_FILE_PARAM = --env-file .env
endif

SHELL := /bin/bash

BUILD_DATE := $$(date +%F)
BUILD_VERSION := $$(grep version ${NAME}/Dockerfile | cut -d'=' -f 2 | cut -d' ' -f 1)

.PHONY: test
test:
	@echo ${CURDIR}
	@echo ${HOME}
	@echo ${BUILD_DATE}
	@echo ${BUILD_VERSION}

.PHONY: build
build:
	@podman build --rm --force-rm --squash \
		--build-arg BUILD_DATE=$(date +%F) \
		--build-arg ADMIN_USER=${ADMIN_USER} \
  	--tag ejsdotsh/${NAME}:${BUILD_VERSION} \
		--tag ejsdotsh/${NAME}:latest \
		--file ${NAME}/Dockerfile \
			.build/.

.PHONY: image-clean
image-clean:
	@podman rmi $$(podman images -f "dangling=true" -q)
