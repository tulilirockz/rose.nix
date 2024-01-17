{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/sys/desktops/gnome.nix
    ../../modules/usr/user.nix
    ../../modules/sys/std.nix
  ];

  system.stateVersion = "24.05";

  boot = {
    loader.systemd-boot.enable = true;
    loader.systemd-boot.configurationLimit = 5;
    loader.efi.canTouchEfiVariables = true;
    extraModulePackages = [config.boot.kernelPackages.rtl8192eu];
  };

  networking.hostName = "studio";

  zramSwap.memoryPercent = 75;

  environment.systemPackages = with pkgs; [
    # android-studio
    alacritty 
    gamescope
    mangohud
    gamemode
  ];

  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
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
