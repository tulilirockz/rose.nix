{ config
, lib
, pkgs
, preferences
, ...
}:
let
  cfg = config.rose.programs.desktops.sway;
  toCommand = cmd: { command = cmd; };
in
{
  options.rose.programs.desktops.sway.enable = lib.mkEnableOption "Sway Compositor Configuration";

  config = lib.mkIf cfg.enable {
    rose.programs.desktops.wm.enable = true;
    rose.programs.desktops.ags.enable = true;

    wayland.windowManager.sway = {
      enable = true;
      systemd.enable = true;
      xwayland = true;
      swaynag.enable = true;
      extraConfig = ''
        blur enable
        shadows enable
        corner_radius 5
      '';
      config = {
        terminal = "${pkgs.foot}/bin/footclient";
        menu = "${lib.getExe config.rose.programs.desktops.ags.package}";
        startup = map toCommand [
          "${lib.getExe pkgs.swaybg} -m fill -i ${preferences.theme.wallpaperPath}"
          "${lib.getExe config.rose.programs.desktops.ags.package}"
        ];
        workspaceLayout = "tabbed";
        gaps = {
          inner = 5;
          outer = 5;
          left = 5;
          right = 5;
          horizontal = 5;
          bottom = 5;
          top = 5;
          vertical = 5;
          smartBorders = "on";
          smartGaps = true;
        };
        focus = {
          followMouse = "always";
        };
        bars = [ ];
        input = { };
        modes = {
          resize = {
            Down = "resize grow height 10 px";
            Escape = "mode default";
            Left = "resize shrink width 10 px";
            Return = "mode default";
            Right = "resize grow width 10 px";
            Up = "resize shrink height 10 px";
          };
        };
        keybindings = {
          "Mod4+C" = "kill";
          "Mod4+Q" = "exec ${lib.getExe pkgs.foot}";
          "Mod4+F" = "exec ${lib.getExe config.programs.chromium.package}";
          "Mod4+R" = "exec ${lib.getExe pkgs.fuzzel}";
          "Mod4+E" = "exec ${lib.getExe pkgs.gnome.nautilus}";
          "Mod4+M" = "exec ${lib.getExe pkgs.wlogout}";
          "Mod4+L" = "exec ${lib.getExe pkgs.swaylock-effects}";
          "Mod4+Left" = "focus left";
          "Mod4+Down" = "focus down";
          "Mod4+Up" = "focus up";
          "Mod4+Right" = "focus right";
        };
      };
    };
  };
}
