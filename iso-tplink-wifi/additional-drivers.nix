{ config, pkgs, ... }:
{
  boot.extraModulePackages = [ config.boot.kernelPackages.rtl8192eu ];
}

