{
  description = "Tulilirockz' NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=a4d4fe8c5002202493e87ec8dbc91335ff55552c";
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nix-flatpak,
    nixvim,
    hyprland,
    nix-colors,
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
      font_family = "FiraCode Nerd Font Mono";
      wallpaper = ./assets/surface.jpg;
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

          inputs.home-manager.nixosModules.home-manager
          ./nixos/hosts/studio/configuration.nix];
      };
      light = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs;
          inherit preferences;
        };
        modules = [
          inputs.home-manager.nixosModules.home-manager
          import ./nixos/hosts/light/configuration.nix];
      };
      live-system = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          (nixpkgs + "/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix")
          ./nixos/hosts/live-system/configuration.nix
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
          hyprland.homeManagerModules.default
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
          hyprland.homeManagerModules.default
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
          hyprland.homeManagerModules.default
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
