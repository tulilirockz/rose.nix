{ pkgs, preferences, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./system-configuration.nix
    ../../modules
  ];
}
