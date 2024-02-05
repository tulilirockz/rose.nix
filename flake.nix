{
  description = "Tulilirockz' NixOS configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
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
    pkgs = import nixpkgs {
      inherit system;
      config = {allowUnfree = true;};
    };
    main_username = "tulili";
    hosts-folder = "hosts";
    nixvim' = nixvim.legacyPackages.${system};
    nvim = nixvim'.makeNixvimWithModule {
      inherit pkgs;
      module = import ./modules/usr/home-manager/nixvim.nix;
    };
    theme = "catppuccin-mocha";
  in {
    packages.${system} = {
      neovim = nvim;
      default = self.packages.${system}.neovim;
    };

    nixosConfigurations = {
      studio = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs;};
        modules = [
          ({config, ...}:
            import ./${hosts-folder}/studio/configuration.nix {
              inherit pkgs;
              inherit config;
              inherit main_username;
            })
        ];
      };
      light = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs;};
        modules = [
          ({config, ...}:
            import ./${hosts-folder}/light/configuration.nix {
              inherit pkgs;
              inherit config;
              inherit main_username;
            })
        ];
      };
      live-system = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          (nixpkgs + "/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix")
          ./${hosts-folder}/live-system/configuration.nix
        ];
      };
    };

    homeConfigurations.${main_username} = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      modules = [
        hyprland.homeManagerModules.default
        nix-colors.homeManagerModules.default
        nix-flatpak.homeManagerModules.nix-flatpak
        nixvim.homeManagerModules.nixvim
        ({config, ...}:
          import ./modules/usr/home-manager.nix {
            inherit pkgs;
            inherit (pkgs) lib;
            inherit config;
            inherit main_username;
            inherit theme;
            inherit inputs;
            user_wallpaper = "~/.config/wallpaper.png";
          })
      ];
    };

    devShells.${system}.default = pkgs.mkShell {
      nativeBuildInputs = with pkgs; [nil just];
    };

    formatter.${system} = pkgs.alejandra;
  };
}
