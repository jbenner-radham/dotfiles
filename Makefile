# vim: set noexpandtab:

UNAME := $(shell uname)
ZSH_SCRIPT_GLOBS := $(shell find . -name '*.zsh' -type f -not -path '*/\.git/*') \
	src/home/.zprofile \
	src/home/.zshenv \
	src/home/.zshrc \
	src/home/.local/bin/*
ZSH_SCRIPT_PATHS := $(foreach glob,$(ZSH_SCRIPT_GLOBS),$(wildcard $(glob)))

default: lint

install: test install-darwin-only install-lesskey install-linux-only
	@rsync --exclude '.keep' --exclude '.config/Code' --mkpath --recursive \
		--times --verbose src/home/ "${HOME}"

install-darwin-only:
ifeq ($(UNAME), Darwin)
	@rsync --mkpath --recursive --times --verbose \
		src/home/.config/Code "${HOME}/Library/Application Support"
endif

install-lesskey:
	@./src/print-lesskey.zsh > "${HOME}/.lesskey"

install-linux-only:
ifeq ($(UNAME), Linux)
	@rsync --mkpath --recursive --times --verbose \
		src/home/.config/Code "${HOME}/.config"
endif

lint:
	@shellcheck src/home/.local/bin/*

test:
	@for path in $(ZSH_SCRIPT_PATHS); do zsh --no-exec "$${path}"; done

.PHONY: default \
	install \
	install-darwin-only \
	install-lesskey \
	install-linux-only \
	lint \
	test
