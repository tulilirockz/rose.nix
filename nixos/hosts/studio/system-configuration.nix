{ pkgs, preferences, ... }:
{
  system.stateVersion = "24.05";
  networking.hostName = "studio";

  boot = {
    loader.efi.canTouchEfiVariables = true;
    loader.systemd-boot = {
      enable = true;
      configurationLimit = 10;
      memtest86.enable = true;
      netbootxyz.enable = true;
    };
    kernelPackages = pkgs.linuxPackages_latest;
  };
  
  i18n.defaultLocale = "en_US.UTF-8";
  
  rose = {
    hardware = {
      enable = true;
      general.enable = true;
    };
    networking = {
      enable = true;
      firewall.enable = true;
      tailscale.enable = true;
      hosts.enable = true;
      wireless.enable = true;
    };
    virtualization = {
      enable = true;
      gui.enable = true;
    };
    programs = {
      gaming = {
        enable = true;
        steam.enable = true;
        others.enable = false;
      };
      gnome.enable = true;
    };
    system = {
      impermanence.enable = true;
      nixos = {
        enable = true;
        autoUpgrade.enable = true;
      };
      unfree.enable = true;
      users = {
        enable = true;
        tulili.enable = true;
      };
    };
    services = {
      desktopManager.${preferences.desktop}.enable = true;
      rclone = {
        enable = true;
        onedrive.enable = true;
      };
    };
  };
}
