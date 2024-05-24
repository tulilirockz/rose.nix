{ ... }:
{
  imports = [ ../modules ];

  home = rec {
    username = "tulili";
    homeDirectory = "/home/${username}";
    stateVersion = "24.11";
  };

  programs = {
    home-manager.enable = true;
    devtools.enable = true;
    clitools.enable = true;
    browsers.enable = true;
  };
}
