{ inputs
, config
, pkgs
, preferences
, ...
}: rec {
  imports = [
    ./hardware-configuration.nix
    ../../modules/managed-desktops.nix
    ../../modules/sunshine.nix
    ../../modules/virtual.nix
    ../../modules/user.nix
    ../../modules/impermanence.nix
  ];

  system = {
    stateVersion = "24.05";
    nixos.impermanence.enable = true;
  };

  boot = {
    loader.systemd-boot.enable = true;
    loader.systemd-boot.configurationLimit = 5;
    loader.efi.canTouchEfiVariables = true;
    kernelPackages = pkgs.linuxPackages_zen;
    kernel.sysctl."kernel.sysrq" = 1;
  };

  networking.hostName = "studio";

  zramSwap.enable = true;
  zramSwap.memoryPercent = 75;

  time.timeZone = preferences.timeZone;
  i18n.defaultLocale = preferences.locale;

  hardware = {
    bluetooth.enable = true;
    opentabletdriver = {
      enable = true;
      daemon.enable = true;
    };
  };

  services = {
    printing.enable = true;
    system76-scheduler.enable = true;
    fwupd.enable = true;
    sunshine.enable = false;
    sunshine.openFirewall = false;
  };

  system.autoUpgrade = {
    enable = true;
    dates = "12:00";
    flake = "${config.users.users.${preferences.username}.home}/opt/tulili.nix";
  };

  nixpkgs.overlays = [ inputs.niri.overlays.niri ];
  nix = {
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 2d";
    };
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      use-xdg-base-directories = true;
      substituters = [ "https://niri.cachix.org" ];
      trusted-public-keys = [ "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964=" ];
    };
  };
  
  environment.systemPackages = with pkgs; [
    heroic
  ];

  programs = {
    managed-desktops = {
      enable = true;
      shared.enable = true;
      wm.enable = true;
      ${preferences.desktop}.enable = true;
    };
    niri.package = pkgs.niri-unstable;
    steam.enable = false;
  };

  virtualisation.managed.enable = true;
  security.sudo.enable = false;
  security.sudo-rs.enable = !(security.sudo.enable);
  
  home-manager = {
    extraSpecialArgs = {
      inherit preferences;
      inherit inputs;
    };
    useGlobalPkgs = true;
    users = {
      ${preferences.username} = _: {
        imports = [
          inputs.plasma-manager.homeManagerModules.plasma-manager
          inputs.nix-colors.homeManagerModules.default
          inputs.nixvim.homeManagerModules.nixvim
          inputs.impermanence.nixosModules.home-manager.impermanence
          ../../../home-manager/configurations/tulip-nixos.nix
        ];
      };
    };
  };

  networking = {
    networkmanager.enable = true;
    networkmanager.wifi.backend = "iwd";
    wireless.iwd.enable = true;
    wireless.iwd.settings = {
      Network = {
        EnableIPV6 = true;
      };
      Settings = {
        AutoConnect = true;
      };
    };
    nftables.enable = true;
    firewall = {
      enable = false;
      allowedUDPPorts = [
        51413 # Transmission
        24800 # Input Leap
      ];
      allowedTCPPorts = [
        51413 # Transmission
        24800 # Input Leap
      ];
      extraInputRules = ''
        ip saddr 192.168.0.0/24 accept
      '';
    };
  };
}
