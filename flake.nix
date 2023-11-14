{
  description = "Tulilirockz' NixOS configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }: 
    let
      inherit (nixpkgs.lib) genAttrs nixosSystem;
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
      };
    in {
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
          modules = [(nixpkgs + "/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix")
          ./hosts/live-system/configuration.nix ];
        };
      };
      devShells.${system}.default = pkgs.mkShell {
      	nativeBuildInputs = with pkgs; [ nil gnumake ];
      };
  };
}

