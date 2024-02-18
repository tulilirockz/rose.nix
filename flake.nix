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
    preferences = rec {
      theme = "catppucin";
      main_username = "tulili";
      font_family = "FiraCode Nerd Font Mono";
      wallpaper = ./assets/lockscreen.png;
      user_wallpaper = "${wallpaper}";
    };
  in {
    packages.${system} = {
      neovim = nixvim.legacyPackages.${system}.makeNixvimWithModule {
        inherit pkgs;
        module = import ./modules/usr/home-manager/nixvim.nix {
          inherit pkgs;
          config = {colorScheme.palette = nix-colors.colorScheme.catppucin;};
        };
      };
      default = self.packages.${system}.neovim;
      nvim = self.packages.${system}.neovim;
    };

    nixosConfigurations = {
      studio = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs;
          inherit preferences;
        };

        modules = [./hosts/studio/configuration.nix];
      };
      light = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs;
          inherit preferences;
        };
        modules = [import ./hosts/light/configuration.nix];
      };
      live-system = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          (nixpkgs + "/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix")
          ./hosts/live-system/configuration.nix
        ];
      };
    };

    homeConfigurations.${preferences.main_username} = home-manager.lib.homeManagerConfiguration {
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
        ./modules/usr/home-manager.nix
      ];
    };

    devShells.${system}.default = pkgs.mkShell {
      nativeBuildInputs = with pkgs; [nil just];
    };

    formatter.${system} = pkgs.alejandra;
  };
}
