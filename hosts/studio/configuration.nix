{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/gnome.nix
    ../../modules/userspace/user.nix
    ../../modules/std.nix
  ];

  system.stateVersion = "23.11";

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    kernelPackages = pkgs.linuxPackages_latest;
    extraModulePackages = [ config.boot.kernelPackages.rtl8192eu ];
  };

  networking.hostName = "studio";

  zramSwap.memoryPercent = 75;

  environment.systemPackages = with pkgs; [
    android-studio
  ];

  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
    waydroid.enable = true;
    libvirtd.enable = true;
    vmware.host.enable = true;
  };

  programs.virt-manager.enable = true;

  programs.steam.enable = true;
}
