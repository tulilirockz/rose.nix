{preferences,...}: {
  imports = [
    ../modules.nix
  ];
  targets.genericLinux.enable = true;
  programs.home-manager.enable = true;
  home.username = preferences.main_username;
  home.homeDirectory = "/home/${preferences.main_username}";
  home.stateVersion = "24.05";
  programs.devtools.enable = true;
}
