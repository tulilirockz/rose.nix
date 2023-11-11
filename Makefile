CURRENT_MACHINE=$(shell hostname)

switch:
	nixos-rebuild --use-remote-sudo switch --impure --flake .#$(CURRENT_MACHINE)

hardware:
	cp -f /etc/nixos/hardware-configuration.nix hosts/$(CURRENT_MACHINE)/
