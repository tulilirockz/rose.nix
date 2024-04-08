{
  description = "Tulilirockz' NixOS configuration";

  inputs = {
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1.*.tar.gz";
    plasma-manager.url = "github:pjones/plasma-manager";
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
    niri.url = "github:sodiboo/niri-flake";
  };

  outputs =
    { self
    , nixpkgs
    , home-manager
    , nix-colors
    , plasma-manager
    , impermanence
    , ...
    } @ inputs:
    let
      preferences = {
        theme = {
          name = "windows-10";
          type = "dark";
          wallpaperPath = ./assets/wserver2025.jpg;
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

        modules = [
          inputs.niri.nixosModules.niri
          inputs.home-manager.nixosModules.home-manager
          inputs.disko.nixosModules.disko
          inputs.impermanence.nixosModules.impermanence
          (import ./nixos/generic/disko.nix { inherit device; })
          ./nixos/hosts/${hostName}/configuration.nix
        ];
      };

      mkHome = system: configuration: home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { inherit system; };

        extraSpecialArgs = {
          inherit inputs;
          inherit preferences;
        };

        modules = [
          plasma-manager.homeManagerModules.plasma-manager
          nix-colors.homeManagerModules.default
          impermanence.nixosModules.home-manager.impermanence
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
        portable-full = mkHome "x86_64-linux" "tulip-nixos";
        portable-strict = mkHome "x86_64-linux" "portable";
      };

      devShells = forEachSupportedSystem ({ pkgs }: {
        default = pkgs.mkShell { packages = with pkgs; [ nil go-task nixpkgs-fmt ]; };
      });

      formatter = forEachSupportedSystem ({ pkgs }: pkgs.nixpkgs-fmt);
    };
}
