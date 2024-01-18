{...}: {
  time.timeZone = "America/Sao_Paulo";
  i18n.defaultLocale = "en_US.UTF-8";
  services.printing.enable = true;
  zramSwap.enable = true;
  services.fwupd.enable = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
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
    firewall.enable = true;
  };
}
