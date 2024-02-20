{
  config,
  inputs,
  pkgs,
  preferences,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/desktops/hyprland.nix
    ../../modules/std.nix
    ../../modules/sunshine.nix
    ../../modules/user.nix
    inputs.home-manager.nixosModules.home-manager
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
  programs.sunshine.enable = true;
  programs.steam.enable = true;
  home-manager = {
    extraSpecialArgs = {
      inherit preferences;
      inherit inputs;
    };
    useGlobalPkgs = true;
    users = {
      ${preferences.main_username} = {...}: {
        imports = [
          inputs.hyprland.homeManagerModules.default
          inputs.nix-colors.homeManagerModules.default
          inputs.nix-flatpak.homeManagerModules.nix-flatpak
          inputs.nixvim.homeManagerModules.nixvim
          ../../../home-manager/configurations/tulip-nixos.nix
        ];
      };
    };
  };
}
