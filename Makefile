# vim: set noexpandtab:

default: lint

lint:
	@shellcheck .local/bin/*

.PHONY: lint
