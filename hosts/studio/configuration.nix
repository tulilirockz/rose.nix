{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/sys/desktops/hyprland.nix
    ../../modules/sys/std.nix
    ../../modules/usr/user.nix
  ];

  system.stateVersion = "24.05";

  boot = {
    loader.systemd-boot.enable = true;
    extraModulePackages = [config.boot.kernelPackages.rtl8192eu];
    #kernelPackages = pkgs.linuxPackages_latest;
  };

  networking.hostName = "studio";

  zramSwap.memoryPercent = 75;

  services.system76-scheduler.enable = true;

  environment.systemPackages = with pkgs; [
    alacritty
    gamescope
    mangohud
    gamemode
    heroic
    virtiofsd
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

  programs.steam.enable = true;
}
