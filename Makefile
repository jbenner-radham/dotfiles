# vim: set noexpandtab:

default: lint

lint:
	@shellcheck src/.local/bin/*

.PHONY: lint
