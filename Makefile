CURRENT_MACHINE=$(shell hostname)

deploy:
	sudo nixos-rebuild switch --flake .#$(CURRENT_MACHINE)
