{
  description = "Tulilirockz' NixOS configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      inherit (nixpkgs.lib) genAttrs nixosSystem;
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
      };
      main_username = "tulili";
    in
    {
      nixosConfigurations = {
        studio = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [ ./hosts/studio/configuration.nix ];
        };
        light = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [ ./hosts/light/configuration.nix ];
        };
        live-system = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            (nixpkgs + "/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix")
            ./hosts/live-system/configuration.nix
          ];
        };
      };

      homeConfigurations.${main_username} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./modules/userspace/home-manager.nix ];
      };

      devShells.${system}.default = pkgs.mkShell {
        nativeBuildInputs = with pkgs; [ nil gnumake ];
      };
    };
}

