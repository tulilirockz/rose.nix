{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/desktops/niri.nix
    ../../modules/std.nix
    ../../modules/sunshine.nix
    ../../modules/user.nix
  ];

  system.stateVersion = "24.05";

  boot = {
    loader.systemd-boot.enable = true;
    extraModulePackages = [config.boot.kernelPackages.rtl8192eu];
    #kernelPackages = pkgs.linuxPackages_latest;
  };

  networking.hostName = "studio";

  environment.systemPackages = with pkgs; [
    gamescope
    mangohud
    heroic
    gnome.gnome-boxes
  ];

  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      autoPrune.enable = true;
      dockerSocket.enable = true;
      defaultNetwork.settings.dns_enabled = true;
    };

    waydroid.enable = true;
    libvirtd.enable = true;
    incus.enable = true;
  };

  programs.virt-manager.enable = true;
  programs.sunshine.enable = false;
  programs.steam.enable = false;
}
