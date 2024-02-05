CURRENT_MACHINE=$(shell hostname)

sys/upgrade:
	nix run nixpkgs#nixos-rebuild -- --use-remote-sudo switch --flake .#$(CURRENT_MACHINE) --upgrade --update-input nixpkgs

home/switch:
	nix run nixpkgs#home-manager -- switch --substitute -b backup --flake .#$(USER)

sys/switch:
	nix run nixpkgs#nixos-rebuild -- --use-remote-sudo switch --flake .#$(CURRENT_MACHINE)

sys/hardware:
	cp -f /etc/nixos/hardware-configuration.nix hosts/$(CURRENT_MACHINE)/

sys/deploy:
	nixos-install --root /mnt --flake .#$(CURRENT_MACHINE)

iso/build: hosts/live-system/*.nix
	nix build .#nixosConfigurations.live-system.config.system.build.isoImage

run/neovim:
	nix run .#neovim
