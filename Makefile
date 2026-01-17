# vim: set noexpandtab:

UNAME := $(shell uname)
ZSH_SCRIPT_PATHS := src/home/.zprofile \
	src/home/.zshenv                     \
	src/home/.zshrc                      \
	$(wildcard src/home/.local/bin/*)    \
	$(shell find . -path './.git' -prune -or -name '*.zsh' -type f -print)

ifeq ($(UNAME),Darwin)
	PLATFORM_INSTALL := install-darwin-only
else ifeq ($(UNAME),Linux)
	PLATFORM_INSTALL := install-linux-only
endif

default: lint

install: test $(PLATFORM_INSTALL) install-lesskey
	@rsync --exclude '.keep' --exclude '.config/Code' --mkpath --recursive \
		--times --verbose src/home/ "${HOME}"

install-darwin-only:
	@rsync --mkpath --recursive --times --verbose \
		src/home/.config/Code "${HOME}/Library/Application Support"

install-lesskey:
	@./src/print-lesskey.zsh > "${HOME}/.lesskey"

install-linux-only:
	@rsync --mkpath --recursive --times --verbose \
		src/home/.config/Code "${HOME}/.config"

lint:
	@shellcheck src/home/.local/bin/*

test:
	@for path in $(ZSH_SCRIPT_PATHS); do zsh --no-exec "$${path}"; done

.PHONY: default       \
	install             \
	install-darwin-only \
	install-lesskey     \
	install-linux-only  \
	lint                \
	test
