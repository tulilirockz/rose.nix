{ preferences, ... }:
{
  imports = [ ../modules ];

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
