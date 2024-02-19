{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/sys/desktops/hyprland.nix
    ../../modules/sys/std.nix
    ../../modules/sys/sunshine.nix
    ../../modules/usr/user.nix
  ];

  system.stateVersion = "24.05";

  boot = {
    loader.systemd-boot.enable = true;
    extraModulePackages = [config.boot.kernelPackages.rtl8192eu];
    #kernelPackages = pkgs.linuxPackages_latest;
  };

  networking.hostName = "studio";
  networking.firewall = {
    allowedUDPPorts = lib.mkForce [
      51413 # Transmission
      24800 # Input Leap
    ];
    allowedTCPPorts = lib.mkForce [
      51413 # Transmission
      24800 # Input Leap
    ];
    extraInputRules = ''
      ip saddr 192.168.0.0/24 accept
    '';
    extraCommands = ''
      iptables -A INPUT -s 192.168.0.0/24 -j ACCEPT
    '';
  };

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
  programs.sunshine.enable = true;
  programs.steam.enable = true;
}
