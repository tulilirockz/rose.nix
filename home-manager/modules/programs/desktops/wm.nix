{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.rose.programs.desktops.wm;
in
{
  options.rose.programs.desktops.wm.enable = lib.mkEnableOption "WM apps";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      (writeScriptBin "xrun" ''
        ${pkgs.systemd}/bin/systemd-run --user ${lib.getExe sway}
        sleep 1
        ${pkgs.systemd}/bin/systemd-run --user -E DISPLAY=:0 -E WAYLAND_DISPLAY=wayland-2 $@
      '')
    ];

    services.kdeconnect.enable = true;
    services.udiskie.enable = true;

    programs.wezterm = {
      enable = true;
      extraConfig = ''
        local config = wezterm.config_builder()
        config.enable_tab_bar = false
        config.window_padding = {
          left = 0,
          right = 0,
          top = 0,
          bottom = 0,
        }
        config.enable_scroll_bar = false
        config.window_background_opacity = 0.8
        config.window_close_confirmation = 'NeverPrompt'
        config.colors = {
          -- Make the selection text color fully transparent.
          -- When fully transparent, the current text color will be used.
          selection_fg = 'none',
          -- Set the selection background color with alpha.
          -- When selection_bg is transparent, it will be alpha blended over
          -- the current cell background color, rather than replace it
          selection_bg = 'rgba(50% 50% 50% 50%)',
        }
        config.cursor_blink_rate = 0

        return config
      '';
    };
  };
}
