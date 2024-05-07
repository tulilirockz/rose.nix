{
  inputs,
  pkgs,
  preferences,
  config,
  ...
}:
rec {
  imports = [
    ./hardware-configuration.nix
    ../../modules
  ];

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
    kernelPackages = pkgs.linuxPackages_zen;
  };

  zramSwap.enable = true;
  zramSwap.memoryPercent = 75;

  time.timeZone = preferences.timeZone;
  i18n.defaultLocale = preferences.locale;

  environment.localBinInPath = true;
  users = {
    defaultUserShell = pkgs.nushell;
    mutableUsers = false;
    users.${preferences.username} = {
      isNormalUser = true;
      hashedPassword = "$6$iea8d6J3Sppre8Sy$.Oyx.gAZfZjIe3t7f98boN8lyQMoTdqyVT/WheOdLrMuJFH7ptgoUQvdUJxYLFZBoUYlyH6cEhssuBt2BUX1E1";
      extraGroups = [
        "wheel"
        "libvirtd"
        "incus-admin"
        "qemu"
      ];
      shell = config.users.defaultUserShell;
    };
  };

  services.flatpak.enable = true;

  systemd.mounts = [
    {
      enable = true;
      what = "/dev/disk/by-uuid/fdebe980-2096-4938-a340-544ca8baf5d4";
      where = "/var/disk/large";
      options = "noatime,space_cache=v2,discard=async";
    }
  ];

  boot.initrd.systemd.enable = true;
  systemd.sysusers.enable = true;
  system.etc.overlay.enable = true;
  system.etc.overlay.mutable = false;

  rose = {
    system = {
      impermanence.enable = true;
      unfree.enable = true;
    };
    programs.gaming = {
      enable = true;
      steam.enable = true;
      others.enable = true;
    };
    programs.desktops.${preferences.desktop}.enable = true;
    programs.collections = with pkgs.lib; {
      enable = true;
      qt.enable = mkDefault false;
      gnome.enable = mkDefault false;
      shared.enable = mkDefault true;
      wm.enable = mkDefault false;
    };
    networking = {
      enable = true;
      wireless.enable = true;
      networkManager = false;
      firewall.enable = true;
      tailscale.enable = true;
      hosts.enable = true;
    };
    virtualization = {
      enable = true;
      gui.enable = true;
    };
    services = {
      sunshine.enable = false;
      sunshine.openFirewall = false;
    };
  };

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
  };

  system.autoUpgrade = {
    enable = true;
    dates = "12:00";
    flake = inputs.self.outPath;
    flags = [
      "--update-input"
      "nixpkgs"
      "-L"
    ];
    randomizedDelaySec = "45min";
  };

  nix = {
    package = pkgs.nixVersions.git;
    gc = {
      automatic = true;
      persistent = true;
      dates = "daily";
      options = "--delete-older-than 2d";
    };
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      use-xdg-base-directories = true;
      auto-optimise-store = true;
      allowed-users = [ "@wheel" ];
    };
    channel.enable = false;
  };

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
        imports =
          with inputs;
          [
            plasma-manager.homeManagerModules.plasma-manager
            persist-retro.nixosModules.home-manager.persist-retro
            nix-colors.homeManagerModules.default
            impermanence.nixosModules.home-manager.impermanence
          ]
          ++ [ ../../../home-manager/configurations/main-nixos.nix ];
      };
    };
  };
}
