{
  description = "Tulip's NixOS configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plasma-manager.url = "github:pjones/plasma-manager";
    agenix.url = "github:ryantm/agenix";
    persist-retro.url = "github:Geometer1729/persist-retro";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-colors.url = "github:misterio77/nix-colors";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence.url = "github:nix-community/impermanence";
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self
    , nixpkgs
    , home-manager
    , ...
    } @ inputs:
    let
      preferences = {
        theme = {
          name = "windows-10";
          type = "dark";
          wallpaperPath = ./assets/purble.jpg;
          colorSchemeFromWallpaper = false;
          fontFamily = "IntoneMono Nerd Font";
          cursor.name = "Fuchsia";
          icon.name = "Adwaita";
          gtk.name = "adw-gtk3-dark";
        };

        locale = "en_US.UTF-8";
        timeZone = "America/Sao_Paulo";
        desktop = "niri";
        desktop_is_wm = true;
        username = "tulili";
      };

      mkSystem = hostName: system: device: nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = {
          inherit inputs;
          inherit preferences;
        };

        modules = with inputs; [
          niri.nixosModules.niri
          home-manager.nixosModules.home-manager
          disko.nixosModules.disko
          agenix.nixosModules.default
          persist-retro.nixosModules.persist-retro
          impermanence.nixosModules.impermanence
        ] ++ [
          (import ./nixos/generic/disko.nix { inherit device; })
          ./nixos/hosts/${hostName}
        ];
      };

      mkHome = system: configuration: home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { inherit system; };

        extraSpecialArgs = {
          inherit inputs;
          inherit preferences;
        };

        modules = with inputs; [
          plasma-manager.homeManagerModules.plasma-manager
          nix-colors.homeManagerModules.default
          impermanence.nixosModules.home-manager.impermanence
          persist-retro.nixosModules.home-manager.persist-retro
        ] ++ [
          ./home-manager/configurations/${configuration}.nix
          ({ ... }: {
            targets.genericLinux.enable = true;
          })
        ];
      };

      supportedSystems = [ "x86_64-linux" "aarch64-darwin" "x86_64-darwin" "aarch64-linux" ];
      forEachSupportedSystem = f:
        nixpkgs.lib.genAttrs supportedSystems (system: f {
          pkgs = import nixpkgs { inherit system; };
        });
    in
    {
      nixosConfigurations = {
        studio = mkSystem "studio" "x86_64-linux" "/dev/sda";
        light = mkSystem "light" "x86_64-linux" "/dev/sda";
        minimal = mkSystem "minimal" "x86_64-linux" "/dev/sda";

        live-system = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [ (nixpkgs + "/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix") ./nixos/hosts/live-system/configuration.nix ];
        };
      };

      homeConfigurations = rec {
        default = portable-strict;
        portable-full = mkHome "x86_64-linux" "main-nixos";
        portable-strict = mkHome "x86_64-linux" "portable";
      };

      devShells = forEachSupportedSystem ({ pkgs }: {
        default = pkgs.mkShell { packages = with pkgs; [ nil go-task nixpkgs-fmt ]; };
      });

      formatter = forEachSupportedSystem ({ pkgs }: pkgs.nixpkgs-fmt);
    };
}
