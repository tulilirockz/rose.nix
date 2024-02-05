{
  config,
  pkgs,
  lib,
  user_wallpaper,
  ...
}: {
  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload = ${user_wallpaper}
    wallpaper = HDMI-A-1,${user_wallpaper}
    splash = false
  '';

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

  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";
    "$browser" = "${lib.getExe pkgs.firefox}";
    "$terminal" = "${lib.getExe pkgs.alacritty}";
    "$file" = "${pkgs.gnome.nautilus}/bin/nautilus";
    "$selector" = "${lib.getExe pkgs.wofi}";
    "$screenshot" = "${lib.getExe pkgs.grimblast}";

    windowrulev2 = "nomaximizerequest, class:.*";

    general = with config.colorScheme.palette; {
      "col.active_border" = "rgba(${base0E}ff) rgba(${base09}ff) 60deg";
      "col.inactive_border" = "rgba(${base00}ff)";
    };

    input = {
      kb_layout = "us,br";
      kb_options = ["grp:win_space_toggle"];
      accel_profile = "flat";
      sensitivity = 0.0;
      repeat_delay = 300;
      repeat_rate = 50;
    };

    decoration = {
      rounding = 3;
      blur = {
        enabled = true;
        size = 3;
        passes = 1;
        vibrancy = 0.1696;
      };
      drop_shadow = true;
      shadow_range = 4;
      shadow_render_power = 3;
    };

    bind =
      [
        "$mod, F, exec, $browser"
        "$mod, Q, exec, $terminal"
        "$mod, E, exec, $file"
        "$mod, L, exec, ${lib.getExe pkgs.swaylock-effects}"
        "$mod, R, exec, $selector --show drun --exec-start --show-icons"
        ", Print, exec, $screenshot copy area"
        "$mod, V, togglefloating"
        "$mod, X, fullscreen"
        "$mod, C, killactive"
        "$mod, P, pseudo"
        "$mod, M, exec, ${lib.getExe pkgs.wlogout}"
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"

        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"
      ]
      ++ (
        # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
        builtins.concatLists (builtins.genList (
            x: let
              ws = let
                c = (x + 1) / 10;
              in
                builtins.toString (x + 1 - (c * 10));
            in [
              "$mod, ${ws}, workspace, ${toString (x + 1)}"
              "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
            ]
          )
          10)
      );
    bindm = [
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
    ];
  };

  wayland.windowManager.hyprland.extraConfig = "exec-once=${lib.getExe (pkgs.writeScriptBin "initial_script.sh" ''
    ${lib.getExe pkgs.networkmanagerapplet} --indicator &
    ${lib.getExe pkgs.hyprpaper} &
    ${pkgs.gnome.gnome-keyring}/gnome-keyring-daemon -r --unlock &
    ${lib.getExe pkgs.swaynotificationcenter} &
    ${pkgs.ssh-agents}/bin/ssh-agent &
    ${pkgs.udiskie}/bin/udiskie &
    ${lib.getExe pkgs.swayidle} -w timeout 150 '${lib.getExe pkgs.swaylock-effects} -f'
  '')}";
}
