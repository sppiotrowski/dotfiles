SHELL := /usr/bin/env bash
lint:
	shellcheck -x *.sh

push:
	. ./cli.sh && .cli.backup

publish: lint push
