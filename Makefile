# vim: set noexpandtab:

UNAME = $(shell uname)

default: lint

install: install-darwin-only install-linux-only
	@rsync --exclude '.keep' --exclude '.config/Code' --mkpath --recursive \
		--times --verbose src/home/ "${HOME}"

install-darwin-only:
ifeq ($(UNAME), Darwin)
		@rsync --dry-run --mkpath --recursive --times --verbose --verbose \
			src/home/.config/Code "${HOME}/Library/Application Support"
endif

install-linux-only:
ifeq ($(UNAME), Linux)
		@rsync --dry-run --mkpath --recursive --times --verbose --verbose \
			src/home/.config/Code "${HOME}/.config"
endif

lint:
	@shellcheck src/home/.local/bin/*

.PHONY: install install-darwin-only install-linux-only lint
