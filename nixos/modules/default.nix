{ ... }:
{
  imports = [
    ./services
    ./programs
    ./system
    ./hardware.nix
    ./networking.nix
    ./virtualization.nix
  ];
}
