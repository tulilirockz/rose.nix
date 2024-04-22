{ config
, pkgs
, lib
, preferences
, ...
}:
let
  cfg = config.rose.programs.desktops.wm;
in
{
  options.rose.programs.desktops.wm.enable = lib.mkEnableOption "WM apps";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      (writeScriptBin "xwayland-run-sway" ''
        ${lib.getExe pkgs.sway} -V &
        sleep 1
        DISPLAY=:0 $@
      '')

      (writeScriptBin "gamescope-run" ''
        ${lib.getExe pkgs.gamescope} -W 1920 -H 1080 -e $@
      '')
    ];

    services.kdeconnect.enable = true;
    services.udiskie.enable = true;

    programs.rio = {
      enable = true;
      settings = {
        use-fork = true;
        confirm-before-quit = false;
        window = {
          background-opacity = 0.8;
          blur = true;
        };
        renderer = {
          performance = "High";
          backend = "Vulkan";
        };
        fonts = {
          family = "${preferences.theme.fontFamily}";
          size = 24;
        };
      };
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
