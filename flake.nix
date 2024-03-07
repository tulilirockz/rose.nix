{
  description = "Tulilirockz' NixOS configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
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
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri.url = "github:sodiboo/niri-flake";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nix-flatpak,
    nixvim,
    nix-colors,
    nixos-generators,
    ...
  } @ inputs: let
    system = "x86_64-linux";

    pkgs = import nixpkgs {inherit system;};

    portable = {
      enable = false;
      user = "tulili";
    };

    preferences = rec {
      theme = "catppucin";
      main_username =
        if (portable.enable == true)
        then portable.user
        else "tulili";
      font_family = "IntoneMono Nerd Font";
      wallpaper = ./assets/wserver2025.jpg;
      user_wallpaper = "${wallpaper}";
      theme_type = "dark";
      theme_wallpaper = true;
      colorScheme =
        if (theme_wallpaper == true)
        then
          (nix-colors.lib.contrib {inherit pkgs;}).colorSchemeFromPicture {
            path = preferences.wallpaper;
            variant = preferences.theme_type;
          }
        else nix-colors.colorSchemes.${theme};
    };
  in {
    packages.${system} = rec {
      neovim = nixvim.legacyPackages.${system}.makeNixvimWithModule {
        inherit pkgs;
        module = import ./home-manager/modules/nixvim/default.nix {
          inherit pkgs;
          config = {colorScheme.palette = nix-colors.colorScheme.catppucin;};
        };
      };
      default = neovim;
      nvim = neovim;
    };

    nixosConfigurations = {
      studio = nixpkgs.lib.nixosSystem {
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
          (import ./nixos/generic/disko.nix {device = "/dev/sda";})
          ./nixos/hosts/studio/configuration.nix
        ];
      };
      light = nixpkgs.lib.nixosSystem {
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
          (import ./nixos/generic/disko.nix {device = "/dev/sda";})
          ./nixos/hosts/light/configuration.nix
        ];
      };
      live-system = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          (nixpkgs + "/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix")
          ./nixos/hosts/live-system/configuration.nix
        ];
      };
      minimal = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          inputs.disko.nixosModules.disko
          (import ./nixos/generic/disko.nix {device = "/dev/sda";})
          ./nixos/hosts/minimal/configuration.nix
        ];
      };
    };

    homeConfigurations = rec {
      default = portable-strict;

      portable-full = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        extraSpecialArgs = {
          inherit inputs;
          inherit preferences;
        };

        modules = [
          nix-colors.homeManagerModules.default
          nix-flatpak.homeManagerModules.nix-flatpak
          nixvim.homeManagerModules.nixvim
          ./home-manager/configurations/tulip-nixos.nix
          ({...}: {
            targets.genericLinux.enable = true;
          })
        ];
      };

      portable-strict = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        extraSpecialArgs = {
          inherit inputs;
          inherit preferences;
        };

        modules = [
          nix-colors.homeManagerModules.default
          nix-flatpak.homeManagerModules.nix-flatpak
          nixvim.homeManagerModules.nixvim
          ./home-manager/configurations/portable.nix
        ];
      };

      ${preferences.main_username} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        extraSpecialArgs = {
          inherit inputs;
          inherit preferences;
        };

        modules = [
          nix-colors.homeManagerModules.default
          nix-flatpak.homeManagerModules.nix-flatpak
          nixvim.homeManagerModules.nixvim
          ./home-manager/configurations/tulip-nixos.nix
        ];
      };
    };

    devShells.${system}.default = pkgs.mkShell {
      nativeBuildInputs = with pkgs; [nil just];
    };

    formatter.${system} = pkgs.alejandra;
  };
}
