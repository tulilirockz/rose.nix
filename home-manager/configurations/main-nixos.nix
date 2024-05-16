{
  preferences,
  pkgs,
  config,
  inputs,
  ...
}:
{
  imports = [ ../modules ];

  colorScheme =
    if (preferences.theme.colorSchemeFromWallpaper) then
      (inputs.nix-colors.lib.contrib { inherit pkgs; }).colorSchemeFromPicture {
        path = preferences.theme.wallpaperPath;
        variant = preferences.theme.type;
      }
    else
      inputs.nix-colors.colorSchemes.${preferences.theme.name};

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
      creation.enable = true;
      browsers = {
        enable = true;
        extras.enable = true;
        impermanence.enable = true;
        mainBrowser = pkgs.epiphany;
      };
      desktops.${preferences.desktop}.enable = true;
    };
  };
}
