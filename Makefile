# vim: set noexpandtab:

UNAME := $(shell uname)
ZSH_SCRIPT_PATHS := src/home/.zprofile \
	src/home/.zshenv                     \
	src/home/.zshrc                      \
	$(wildcard src/home/.local/bin/*)    \
	$(shell find . -path './.git' -prune -or -name '*.zsh' -type f -print)

ifeq ($(UNAME),Darwin)
	PLATFORM_INSTALL := install-darwin-only
	COMPUTER_NAME := $(shell scutil --get ComputerName)

	ifeq ($(firstword $(COMPUTER_NAME)),James’)
		# ^ Checks for Unicode apostrophe.
		PROFILE_INSTALL := install-personal-only
	else ifeq ($(firstword $(COMPUTER_NAME)),James')
		# ^ Checks for ASCII apostrophe.
		PROFILE_INSTALL := install-personal-only
	else
		PROFILE_INSTALL := install-work-only
	endif
else ifeq ($(UNAME),Linux)
	PLATFORM_INSTALL := install-linux-only
	COMPUTER_NAME := $(shell hostnamectl --pretty)

	ifeq ($(firstword $(COMPUTER_NAME)),James’)
		# ^ Checks for Unicode apostrophe.
		PROFILE_INSTALL := install-personal-only
	else ifeq ($(firstword $(COMPUTER_NAME)),James')
		# ^ Checks for ASCII apostrophe.
		PROFILE_INSTALL := install-personal-only
	else
		PROFILE_INSTALL := install-work-only
	endif
endif

default: lint

install: test $(PLATFORM_INSTALL) $(PROFILE_INSTALL) install-lesskey
	@rsync --exclude '.keep' --exclude '.config/Code' \
		--exclude '.claude/CLAUDE.personal.md' --exclude '.claude/CLAUDE.work.md' \
		--mkpath --recursive --times --verbose src/home/ "${HOME}"

install-darwin-only:
	@rsync --mkpath --recursive --times --verbose \
		src/home/.config/Code "${HOME}/Library/Application Support"

install-lesskey:
	@./src/print-lesskey.zsh > "${HOME}/.lesskey"

install-linux-only:
	@rsync --mkpath --recursive --times --verbose \
		src/home/.config/Code "${HOME}/.config"

install-personal-only:
	@rsync --mkpath --recursive --times --verbose \
		src/home/.claude/CLAUDE.personal.md "${HOME}/.claude/CLAUDE.md"

install-work-only:
	@rsync --mkpath --recursive --times --verbose \
		src/home/.claude/CLAUDE.work.md "${HOME}/.claude/CLAUDE.md"

lint:
	@shellcheck src/home/.local/bin/*

test:
	@for path in $(ZSH_SCRIPT_PATHS); do zsh --no-exec "$${path}"; done

.PHONY: default \
	install \
	install-darwin-only \
	install-lesskey \
	install-linux-only \
	install-personal-only \
	install-work-only \
	lint \
	test
