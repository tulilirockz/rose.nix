TARGET = $(shell hostname)

all: fetch

fetch: /etc/nixos/*.nix $(HOME)/.local/share/devbox/global/current/devbox.json
	cp -f /etc/nixos/*.nix $(TARGET)/system
	cp -f $(HOME)/.local/share/devbox/global/current/devbox.json $(TARGET)/user/devbox.json
