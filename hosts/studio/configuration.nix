{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/kde.nix    
    ../../modules/tulili.nix    
    ../../modules/std.nix    
  ];

  system.stateVersion = "23.11";
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
 
  boot.extraModulePackages = [ config.boot.kernelPackages.rtl8192eu ];

  networking.hostName = "studio";
 
  environment.systemPackages = with pkgs; [
    virt-manager
    cage
    distrobox
    waydroid
    nixos-generators 
    home-manager
  ];
 
  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
    waydroid.enable = true;
    virtualbox.host.enable = true;
    libvirtd.enable = true;
    vmware.host.enable = true;
  };
  programs.virt-manager.enable = true;
}
