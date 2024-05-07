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
        systemd-run --user ${lib.getExe sway}
        sleep 1
        systemd-run --user -E DISPLAY=:0 -E WAYLAND_DISPLAY=wayland-2 $@
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

    programs.wlogout = {
      enable = true;
      layout = [
        {
          "label" = "lock";
          "action" = "${lib.getExe pkgs.swaylock-effects}";
          "keybind" = "l";
        }
        {
          "label" = "hibernate";
          "action" = "${pkgs.systemd}/bin/systemctl hibernate";
          "keybind" = "h";
        }
        {
          "label" = "logout";
          "action" = "${pkgs.systemd}/bin/loginctl terminate-user $USER";
          "keybind" = "e";
        }
        {
          "label" = "shutdown";
          "action" = "${pkgs.systemd}/bin/systemctl poweroff";
          "keybind" = "s";
        }
        {
          "label" = "suspend";
          "action" = "${pkgs.systemd}/bin/systemctl suspend";
          "keybind" = "u";
        }
        {
          "label" = "reboot";
          "action" = "${pkgs.systemd}/bin/systemctl reboot";
          "keybind" = "r";
        }
      ];
      style = with config.colorScheme.palette; ''
        window {
            font-size: 16px;
            color: #${base05};
            background-color: rgba(0, 0, 0, 0.5);
        }
        button {
            background-repeat: no-repeat;
            background-position: center;
            background-size: 50%;
            border: 5px solid rgba(0,0,0,0);
            background-color: rgba(0, 0, 0, 0.5);
            margin: 5px;
            border-radius: 5px;
            transition: box-shadow 0.2s ease-in-out, background-color 0.2s ease-in-out;
        }
        button:hover {
            background-color: rgba(0,0,0,0.6);
        }
        button:focus {
            background-color: #${base00};
            border: 5px solid #${base06};
            border-radius: 5px;
            color: #${base0D};
        }

        #lock {
            background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/lock.png"));
        }

        #logout {
            background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/logout.png"));
        }

        #suspend {
            background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/suspend.png"));
        }

        #hibernate {
            background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/hibernate.png"));
        }

        #shutdown {
            background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/shutdown.png"));
        }

        #reboot {
            background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/reboot.png"));
        }
      '';
    };
  };
}
