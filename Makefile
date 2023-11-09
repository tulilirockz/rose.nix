<<<<<<< HEAD
TARGET = $(shell hostname)

all: fetch

fetch: /etc/nixos/*.nix $(HOME)/.local/share/devbox/global/current/devbox.json
	cp -f /etc/nixos/*.nix $(TARGET)/system
	cp -f $(HOME)/.local/share/devbox/global/current/devbox.json $(TARGET)/user/devbox.json
=======
CURRENT_MACHINE=$(shell hostname)

deploy:
	sudo nixos-rebuild switch --flake .#$(CURRENT_MACHINE)
>>>>>>> 19846a6 (feat: use flakes for configuration)
