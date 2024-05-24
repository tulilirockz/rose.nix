{
  description = "Tulip's Aux configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    persist-retro.url = "github:Geometer1729/persist-retro";
    impermanence.url = "github:nix-community/impermanence";
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plasma-manager = {
      url = "github:pjones/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nuspawn = {
      url = "github:tulilirockz/nuspawn";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    unified-hosts-strict = {
      flake = false;
      url = "https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling-porn/hosts";
    };
    umu = {
      url = "git+https://github.com/Open-Wine-Components/umu-launcher/?dir=packaging\/nix&submodules=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      supportedSystems = [
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
        "aarch64-linux"
      ];
      forEachSupportedSystem =
        f: nixpkgs.lib.genAttrs supportedSystems (system: f { pkgs = import nixpkgs { inherit system; }; });
    in
    {
      nixosModules = rec {
        default = rose;
        rose = import ./nixos/modules;
      };
      homeManagerModules = rec {
        default = rose;
        rose = import ./home-manager/modules;
      };

      lib = {
        mkSystem =
          hostName: system: device:
          nixpkgs.lib.nixosSystem {
            inherit system;

            specialArgs = {
              inherit inputs;
            };

            modules =
              with inputs;
              [
                niri.nixosModules.niri
                home-manager.nixosModules.home-manager
                disko.nixosModules.disko
                persist-retro.nixosModules.persist-retro
                impermanence.nixosModules.impermanence
                stylix.nixosModules.stylix
              ]
              ++ [
                (import ./nixos/generic/disko.nix { inherit device; })
                ./nixos/hosts/${hostName}
              ];
          };

        mkHome =
          system: configuration:
          home-manager.lib.homeManagerConfiguration {
            pkgs = import nixpkgs { inherit system; };

            extraSpecialArgs = {
              inherit inputs;
            };

            modules =
              with inputs;
              [
                plasma-manager.homeManagerModules.plasma-manager
                impermanence.nixosModules.home-manager.impermanence
                persist-retro.nixosModules.home-manager.persist-retro
                stylix.homeManagerModules.stylix
              ]
              ++ [
                ./home-manager/configurations/${configuration}.nix
                (
                  { ... }:
                  {
                    targets.genericLinux.enable = true;
                  }
                )
              ];
          };
      };

      nixosConfigurations = with inputs.self.lib; {
        studio = mkSystem "studio" "x86_64-linux" "/dev/disk/by-uuid/cc73375c-ac4f-4d7e-9db8-362d5b84a245";
        light = mkSystem "light" "x86_64-linux" "/dev/sda";
        minimal = mkSystem "minimal" "x86_64-linux" "/dev/sda";

        live-system = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            (nixpkgs + "/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix")
            ./nixos/hosts/live-system/configuration.nix
          ];
        };
      };

      homeConfigurations = with inputs.self.lib; rec {
        default = portable-strict;
        portable-full = mkHome "x86_64-linux" "main-nixos";
        portable-strict = mkHome "x86_64-linux" "portable";
      };

      packages = forEachSupportedSystem (
        { pkgs }:
        {
          docs =
            let
              moduleDocs = pkgs.nixosOptionsDoc {
                options =
                  (import (pkgs.path + "/nixos/lib/eval-config.nix") {
                    baseModules = [
                      ./nixos/modules
                      { config._module.check = false; }
                    ];
                    modules = [ ];
                  }).options;
              };
            in
            pkgs.stdenv.mkDerivation {
              src = ./.;
              name = "docs";

              # mkdocs dependencies
              nativeBuildInputs = with pkgs; [
                mkdocs
                python3Packages.mkdocs-material
                python3Packages.pygments
              ];

              # symlink our generated docs into the correct folder before generating
              buildPhase = ''
                mkdir -p docs
                ln -s ${moduleDocs.optionsCommonMark} "./docs/nixos-options.md"
                # generate the site
                mkdocs build
              '';

              configurePhase = '''';

              installPhase = ''
                mv site $out
              '';
            };
        }
      );

      devShells = forEachSupportedSystem (
        { pkgs }:
        {
          default = pkgs.mkShell { packages = with pkgs; [ go-task ]; };
        }
      );

      formatter = forEachSupportedSystem ({ pkgs }: pkgs.nixfmt-rfc-style);
    };
}
