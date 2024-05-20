{
  preferences,
  pkgs,
  ...
}:
{
  imports = [ ../modules ];

  rose = {
    home = {
      impermanence.enable = true;
      general.enable = true;
      gui.enable = true;
    };
    programs = {
      dev = {
        enable = true;
        gui.enable = true;
        impermanence.enable = true;
      };
      creation = {
        enable = true;
        impermanence.enable = true;
      };
      browsers = {
        enable = true;
        extras.enable = true;
        impermanence.enable = true;
        mainBrowser = pkgs.chromium;
      };
      desktops.${preferences.desktop}.enable = true;
    };
  };
}
