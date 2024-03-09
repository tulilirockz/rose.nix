{ config
, pkgs
, preferences
, ...
}: {
  system.autoUpgrade = {
    enable = true;
    dates = "12:00";
    flake = "/etc/nixos";
    flags = [
      "--update-input"
      "nixpkgs"
    ];
  };

  services.flatpak.enable = true;
  users.defaultUserShell = pkgs.nushell;
  users.mutableUsers = false;
  users.users.${preferences.main_username} = {
    isNormalUser = true;
    hashedPassword = "$6$iea8d6J3Sppre8Sy$.Oyx.gAZfZjIe3t7f98boN8lyQMoTdqyVT/WheOdLrMuJFH7ptgoUQvdUJxYLFZBoUYlyH6cEhssuBt2BUX1E1";
    extraGroups = [ "wheel" "libvirtd" "incus-admin" "qemu" "vboxusers" ];
    shell = pkgs.nushell;
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
  };

  programs.fish = {
    enable = false;
    useBabelfish = true;
  };

  environment.localBinInPath = true;

  services.onedrive.enable = true;

  security.pam.services.${preferences.main_username}.showMotd = true;
}
