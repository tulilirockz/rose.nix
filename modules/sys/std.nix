{
  config,
  pkgs,
  ...
}: {
  boot = {
    loader.systemd-boot.configurationLimit = 5;
    loader.efi.canTouchEfiVariables = true;
  };

  time.timeZone = "America/Sao_Paulo";

  i18n.defaultLocale = "en_US.UTF-8";

  services.printing.enable = true;

  zramSwap.enable = true;
  services.fwupd.enable = true;

  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    experimental-features = ["nix-command" "flakes"];
  };

  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 2d";
  };
  nixpkgs.config.allowUnfree = true;

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
    firewall = {
      enable = true;
      allowedUDPPorts = [
        51413 # Transmission
        24800 # Input Leap
      ];
      allowedTCPPorts = config.networking.firewall.allowedUDPPorts;
    };
  };

  hardware.opentabletdriver = {
    enable = true;
    daemon.enable = true;
  };

  hardware.bluetooth.enable = true;

  security.sudo.enable = false;
  security.sudo-rs.enable = true;

  environment.systemPackages = with pkgs; [home-manager git bubblewrap just];

  programs.rust-motd.enable = true;
  programs.rust-motd.settings = {
    banner = {
      color = "magenta";
      command = "${pkgs.busybox}/bin/busybox hostname | ${pkgs.figlet}/bin/figlet";
    };
  };

  boot.kernel.sysctl = {
    "kernel.sysrq" = 1;
  };

  services.input-remapper.enable = true;
}
