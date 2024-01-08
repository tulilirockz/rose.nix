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
  };

  outputs = { nixpkgs, home-manager, nix-flatpak, nixvim, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
      };
      main_username = "tulili";
      hosts-folder = "hosts";
    in
    {
      nixosConfigurations = {
        studio = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [ ./${hosts-folder}/studio/configuration.nix ];
        };
        light = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [ ./${hosts-folder}/light/configuration.nix ];
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
          nix-flatpak.homeManagerModules.nix-flatpak
          nixvim.homeManagerModules.nixvim
          ./modules/usr/home-manager.nix 
        ];
      };

      devShells.${system}.default = pkgs.mkShell {
        nativeBuildInputs = with pkgs; [ nil gnumake ];
      };
    };
}

