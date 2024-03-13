{ preferences, ... }: {
  imports = [
    ../modules/browsers.nix
    ../modules/clitools.nix
    ../modules/devtools.nix
  ];
  targets.genericLinux.enable = true;
  
  home = {
    username = preferences.username;
    homeDirectory = "/home/${preferences.username}";
    stateVersion = "24.05";
  };
  
  programs = {
    home-manager.enable = true;
    devtools.enable = true;
    clitools.enable = true;
    browsers.enable = true;
  };
}
