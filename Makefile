# vim: set noexpandtab:

UNAME := $(shell uname)
ZSH_SCRIPT_PATHS := src/profiles/base/.zprofile \
	src/profiles/base/.zshenv                     \
	src/profiles/base/.zshrc                      \
	$(wildcard src/profiles/base/.local/bin/*)    \
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

install: test $(PLATFORM_INSTALL) install-base-only $(PROFILE_INSTALL) \
	install-lesskey

install-darwin-only:
	@rsync --mkpath --recursive --times --verbose \
		src/profiles/base/.config/Code "${HOME}/Library/Application Support"

install-lesskey:
	@./src/print-lesskey.zsh > "${HOME}/.lesskey"

install-linux-only:
	@rsync --mkpath --recursive --times --verbose \
		src/profiles/base/.config/Code "${HOME}/.config"

install-base-only:
	@rsync --exclude '.keep' --exclude '.config/Code' \
		--mkpath --recursive --times --verbose src/profiles/base/ "${HOME}"

install-personal-only:
	@rsync --exclude '.keep' --mkpath --recursive --times --verbose \
		src/profiles/personal/ "${HOME}"

install-work-only:
	@rsync --exclude '.keep' --mkpath --recursive --times --verbose \
		src/profiles/work/ "${HOME}"

lint:
	@shellcheck src/profiles/base/.local/bin/*

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
