# vim: set noexpandtab:

default: lint

install:
	@rsync --exclude '.keep' --mkpath --recursive --times --verbose src/home/ \
		"${HOME}"

lint:
	@shellcheck src/home/.local/bin/*

.PHONY: install lint
