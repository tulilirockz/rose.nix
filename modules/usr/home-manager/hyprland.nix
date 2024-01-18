{
  config,
  pkgs,
  lib,
  ...
}: {
  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload = ~/.config/wallpaper.png
    wallpaper = HDMI-A-1,~/.config/wallpaper.png
    splash = false
  '';

  programs.waybar = {
    enable = true;
    systemd.enable = true;
    style = import ./waybar/css.nix {
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

    input = {
      kb_layout = "us";
      accel_profile = "flat";
      sensitivity = 0.0;
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
        "$mod, R, exec, $selector --show drun --exec-start --show-icons"
        ", Print, exec, $screenshot copy area"
        "$mod, V, togglefloating"
        "$mod, C, killactive"
        "$mod, P, pseudo"
        "$mod, M, exit"
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"

        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"
      ]
      ++ (
        # workspaces
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
    ${lib.getExe pkgs.mako}
  '')}";
}
