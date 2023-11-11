all: build

build: *.nix
	nix build --impure .#nixosConfigurations.live.config.system.build.isoImage
