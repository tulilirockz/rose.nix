{
  config,
  pkgs,
  lib,
  preferences,
  ...
}: {
  programs.wlogout = {
    enable = true;
    layout = import ./wlogout/layout.nix;
    style = import ./wlogout/style.nix {
      inherit config;
      inherit pkgs;
    };
  };

  programs.fuzzel = {
    enable = true;
    settings = {
      colors = {
        background = "${config.colorScheme.palette.base00}FF";
        text = "${config.colorScheme.palette.base05}FF";
        match = "${config.colorScheme.palette.base08}FF";
        selection-match = "${config.colorScheme.palette.base09}FF";
        selection = "${config.colorScheme.palette.base02}FF";
        selection-text = "${config.colorScheme.palette.base0A}FF";
        border = "${config.colorScheme.palette.base07}FF";
      };

      border = {
        width = 2;
        radius = 3;
      };
    };
  };

  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = with config.colorScheme.palette; {
      image = preferences.user_wallpaper;
      clock = true;
      font = preferences.font_family;
      ignore-empty-password = true;
      indicator = true;
      indicator-capslock = true;
      effect-blur = "20x6";
      indicator-radius = 240;
      indicator-thickness = 20;

      text-clear-color = "${base0C}00";
      text-ver-color = "${base0B}00";
      text-wrong-color = "${base08}00";

      key-hl-color = 880033;

      #separator-color=${base02}00;
      #
      #inside-color=${base02}00;
      #inside-clear-color=${}00;
      #inside-caps-lock-color=009ddc00;
      #inside-ver-color=d9d8d800;
      #inside-wrong-color=ee2e2400;
      #
      #ring-color=${base06}D9;
      #ring-clear-color=${base07}D9;
      #ring-caps-lock-color=${base08}D9;
      #ring-ver-color=${base0B}D9;
      #ring-wrong-color=${base0F}D9;
      #
      #line-color=${};
      #line-clear-color=ffd204FF;
      #line-caps-lock-color=009ddcFF;
      #line-ver-color=d9d8d8FF;
      #line-wrong-color=ee2e24FF;
      #
      #bs-hl-color="${base0B}FF";
      #caps-lock-key-hl-color="${base0A}FF";
      #caps-lock-bs-hl-color="${base00}FF";
      #text-caps-lock-color="${base0A}FF";
    };
  };

  programs.waybar = {
    enable = true;
    style = import ./waybar/style.nix {
      inherit config;
    };
    settings = import ./waybar/settings.nix {
      inherit pkgs;
      inherit lib;
    };
  };

  xdg.configFile."swaync/style.css".text = import ./swaync-theme.nix {
    inherit config;
    inherit preferences;
  };
}
