{config, pkgs, lib, user_wallpaper,...}:{
  programs.wlogout = {
    enable = true;
    layout = import ./wlogout/layout.nix;
    style = import ./wlogout/style.nix {
      inherit config;
      inherit pkgs;
    };
  };

  programs.wofi = {
    enable = true;
    style = import ./wofi-style.nix {inherit config;};
  };

  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {
      image = user_wallpaper;
      clock = true;
      font = config.programs.alacritty.settings.font.normal.family;
      ignore-empty-password = true;
      indicator = true;
      indicator-radius = 300;
      indicator-thickness = 10;
      indicator-capslock = true;
      effect-blur = "20x6";
    };
  };

  programs.waybar = {
    enable = true;
    systemd.enable = true;
    style = import ./waybar/style.nix {
      inherit config;
    };
    settings = import ./waybar/settings.nix {
      inherit pkgs;
      inherit lib;
    };
  };
}
