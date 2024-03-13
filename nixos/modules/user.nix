{ config
, pkgs
, preferences
, ...
}: {
  users = {
    defaultUserShell = pkgs.nushell;
    mutableUsers = false;
    users.${preferences.username} = {
      isNormalUser = true;
      hashedPassword = "$6$iea8d6J3Sppre8Sy$.Oyx.gAZfZjIe3t7f98boN8lyQMoTdqyVT/WheOdLrMuJFH7ptgoUQvdUJxYLFZBoUYlyH6cEhssuBt2BUX1E1";
      extraGroups = [ "wheel" "libvirtd" "incus-admin" "qemu" ];
      shell = config.users.defaultUserShell;
    };
  };

  services.flatpak.enable = true;
    
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
  };

  environment.localBinInPath = true;
  services.onedrive.enable = true;
  security.pam.services.${preferences.username}.showMotd = true;
}
