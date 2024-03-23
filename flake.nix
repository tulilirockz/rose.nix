{
  description = "Tulilirockz' NixOS configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    plasma-manager.url = "github:pjones/plasma-manager";
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
    niri.url = "github:sodiboo/niri-flake";
  };

  outputs =
    { self
    , nixpkgs
    , home-manager
    , nixvim
    , nix-colors
    , plasma-manager
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
        browser = "chromium";
        desktop = "niri";
        desktop_is_wm = true;
        username = "tulili";
      };

      generateSystemConfiguration = hostName: system: device: nixpkgs.lib.nixosSystem {
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
          inputs.impermanence.nixosModules.home-manager.impermanence
          (import ./nixos/generic/disko.nix { inherit device; })
          ./nixos/hosts/${hostName}/configuration.nix
        ];
      };

      generateHomeManagerConfiguration = system: configuration: home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { inherit system; };

        extraSpecialArgs = {
          inherit inputs;
          inherit preferences;
        };

        modules = [
          nix-colors.homeManagerModules.default
          nixvim.homeManagerModules.nixvim
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
      packages = forEachSupportedSystem ({ pkgs }: rec {
        neovim = nixvim.legacyPackages.${pkgs.system}.makeNixvimWithModule {
          inherit pkgs;
          module = import ./home-manager/modules/nixvim/default.nix {
            inherit pkgs;
            config = { colorScheme.palette = nix-colors.colorScheme.catppucin; };
          };
        };
        default = neovim;
        nvim = neovim;
      });

      nixosConfigurations = {
        studio = generateSystemConfiguration "studio" "x86_64-linux" "/dev/sda";
        light = generateSystemConfiguration "light" "x86_64-linux" "/dev/sda";
        minimal = generateSystemConfiguration "minimal" "x86_64-linux" "/dev/sda";

        live-system = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [ (nixpkgs + "/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix") ./nixos/hosts/live-system/configuration.nix ];
        };
      };

      homeConfigurations = rec {
        default = portable-strict;
        portable-full = generateHomeManagerConfiguration "x86_64-linux" "tulip-nixos";
        portable-strict = generateHomeManagerConfiguration "x86_64-linux" "portable";
      };

      devShells = forEachSupportedSystem ({ pkgs }: {
        default = pkgs.mkShell { packages = with pkgs; [ nil just nixpkgs-fmt ]; };
      });

      formatter = forEachSupportedSystem ({ pkgs }: pkgs.nixpkgs-fmt);
    };
}
