{ config
, pkgs
, preferences
, ...
}: {
  system.autoUpgrade = {
    enable = true;
    dates = "12:00";
    flake = "${config.users.users.${preferences.username}.home}/opt/tulili.nix";
  };

  services.flatpak.enable = true;
  users.defaultUserShell = pkgs.nushell;
  users.mutableUsers = false;
  users.users.${preferences.username} = {
    isNormalUser = true;
    hashedPassword = "$6$iea8d6J3Sppre8Sy$.Oyx.gAZfZjIe3t7f98boN8lyQMoTdqyVT/WheOdLrMuJFH7ptgoUQvdUJxYLFZBoUYlyH6cEhssuBt2BUX1E1";
    extraGroups = [ "wheel" "libvirtd" "incus-admin" "qemu" ];
    shell = config.users.defaultUserShell;
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
  };

  environment.localBinInPath = true;
  services.onedrive.enable = true;
  security.pam.services.${preferences.username}.showMotd = true;
}
