CURRENT_MACHINE := `hostname`
USER := `whoami`

_default:
  @just --choose

all-switch:
  @just sys-switch
  @just home-switch

image-build HOSTNAME:
	nix build .#nixosConfigurations.{{HOSTNAME}}.config.system.build.diskoImagesScript
	./result --build-memory 4072

sys-upgrade EXTRA_FLAGS:
	nix run nixpkgs#nixos-rebuild -- --use-remote-sudo switch --flake .#{{CURRENT_MACHINE}} --upgrade --update-input nixpkgs {{EXTRA_FLAGS}}

build-vm CONFIGURATION:
	nix run nixpkgs#nixos-rebuild -- build-vm --flake .#{{CONFIGURATION}}

format-disko DEVICE:
	sudo nix run github:nix-community/disko -- --mode disko ./nixos/generic/disko.nix --arg device '"{{DEVICE}}"'

home-switch:
	nix run nixpkgs#home-manager -- switch --substitute -b backup --flake .#portable

home-switch-tulili:
	nix run nixpkgs#home-manager -- switch --substitute -b backup --flake .#{{USER}}

sys-switch:
	nix run nixpkgs#nixos-rebuild -- --use-remote-sudo switch --flake .#{{CURRENT_MACHINE}}

sys-hardware:
	cp -f /etc/nixos/hardware-configuration.nix hosts/{{CURRENT_MACHINE}}/

sys-deploy:
	nixos-install --root /mnt --flake .#{{CURRENT_MACHINE}}

iso-build: 
	nix build .#nixosConfigurations.live-system.config.system.build.isoImage

run-neovim:
	nix run .#neovim

repair-path DERIV: 
	nix-store --repair-path {{DERIV}}

repair-all:
	nix store repair --all

repair-please:
	nix-store --verify --check-contents --repair
