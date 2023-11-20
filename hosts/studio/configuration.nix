{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/gnome.nix    
    ../../modules/tulili.nix    
    ../../modules/std.nix    
  ];

  system.stateVersion = "23.11";
  
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    kernelPackages = pkgs.linuxPackages_zen;
    extraModulePackages = [ config.boot.kernelPackages.rtl8192eu ];
  };

  networking.hostName = "studio";
 
  environment.systemPackages = with pkgs; [
    virt-manager
    cage
    distrobox
    waydroid
    nixos-generators 
    vscode
    android-studio
    podman-compose
    docker-compose
    nerdfonts
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

  programs.steam.enable = true;
}
