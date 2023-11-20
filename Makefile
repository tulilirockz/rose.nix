CURRENT_MACHINE=$(shell hostname)

switch:
	nixos-rebuild --use-remote-sudo switch --flake .#$(CURRENT_MACHINE)

hardware:
	cp -f /etc/nixos/hardware-configuration.nix hosts/$(CURRENT_MACHINE)/

deploy:
	nixos-install --root /mnt --flake .#$(CURRENT_MACHINE)

build-iso: hosts/live-system/*.nix
	nix build --impure .#nixosConfigurations.live-system.config.system.build.isoImage

gnome/refresh-dconf:
	cat config/dconf/main.ini | dconf load /
