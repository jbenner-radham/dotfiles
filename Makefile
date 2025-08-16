# vim: set noexpandtab:

UNAME = $(shell uname)

default: lint

install: install-darwin-only install-lesskey install-linux-only
	@rsync --exclude '.keep' --exclude '.config/Code' --mkpath --recursive \
		--times --verbose src/home/ "${HOME}"

install-darwin-only:
ifeq ($(UNAME), Darwin)
		@rsync --mkpath --recursive --times --verbose --verbose \
			src/home/.config/Code "${HOME}/Library/Application Support"
endif

install-lesskey:
	@./src/print-lesskey.zsh > "${HOME}/.lesskey"

install-linux-only:
ifeq ($(UNAME), Linux)
		@rsync --mkpath --recursive --times --verbose --verbose \
			src/home/.config/Code "${HOME}/.config"
endif

lint:
	@shellcheck src/home/.local/bin/*

.PHONY: install install-darwin-only install-lesskey install-linux-only lint
