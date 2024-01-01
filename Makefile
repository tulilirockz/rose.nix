CURRENT_MACHINE=$(shell hostname)

sys/upgrade:
	nixos-rebuild --use-remote-sudo switch --flake .#$(CURRENT_MACHINE) --upgrade --update-input nixpkgs

home/switch:
	home-manager switch --substitute --flake .#$(USER)

sys/switch:
	nixos-rebuild --use-remote-sudo switch --flake .#$(CURRENT_MACHINE)

sys/hardware:
	cp -f /etc/nixos/hardware-configuration.nix hosts/$(CURRENT_MACHINE)/

sys/deploy:
	nixos-install --root /mnt --flake .#$(CURRENT_MACHINE)

iso/build: hosts/live-system/*.nix
	nix build --impure .#nixosConfigurations.live-system.config.system.build.isoImage

