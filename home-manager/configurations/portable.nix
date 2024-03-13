{ preferences, ... }: {
  imports = [
    ../modules/browsers.nix
    ../modules/clitools.nix
    ../modules/devtools.nix
  ];
  targets.genericLinux.enable = true;
  programs.home-manager.enable = true;
  home.username = preferences.username;
  home.homeDirectory = "/home/${preferences.username}";
  home.stateVersion = "24.05";
  programs.devtools.enable = true;
  programs.clitools.enable = true;
  programs.browsers.enable = true;
}
