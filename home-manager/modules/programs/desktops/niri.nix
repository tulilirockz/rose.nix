{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.rose.programs.desktops.niri;
in
{
  options.rose.programs.desktops.niri.enable = lib.mkEnableOption "Niri Compositor";

  config = lib.mkIf cfg.enable {
    rose.programs.desktops.wm.enable = true;

    programs.niri.config = ''
      // This config is in the KDL format: https://kdl.dev
      window-rule {
          match app-id=r#"^org\.wezfurlong\.wezterm$"#
          default-column-width {}
      }

      window-rule {
          geometry-corner-radius 4
          clip-to-geometry true
      }
      animations {
        window-open {
            duration-ms 200
            curve "ease-out-cubic"
        }
        window-close {
            duration-ms 200
            curve "ease-out-cubic"
        }
      }
      input {
          keyboard {
              xkb {
                  // xkeyboard-config(7).
                  layout "us,br"
                  options "grp:win_space_toggle,compose:ralt,ctrl:nocaps"
              }
              repeat-delay 250
              repeat-rate 75 // Characters per second
              track-layout "global"
          }

          touchpad {
              tap
              // dwt
              // dwtp
              natural-scroll
              // accel-speed 0.2
              // accel-profile "flat"
              // tap-button-map "left-middle-right"
          }

          mouse {
              accel-speed 0.2
              accel-profile "flat"
          }

          trackpoint {
              accel-speed 0.2
              accel-profile "flat"
          }

          tablet {
              map-to-output "HDMI-A-1"
          }
      }

      output "HDMI-A-1" {
          transform "normal" // normal, 90, 180, 270
          mode "1920x1080" // niri msg outputs
      }

      layout {
          focus-ring {
              width 1
              active-color 33 33 33 125
              inactive-color 80 80 80 255
          }
          preset-column-widths {
              proportion 0.33333
              proportion 0.5
              proportion 0.66667
          }
          default-column-width { proportion 0.5; }
          gaps 10 // px
          center-focused-column "never"
      }
      prefer-no-csd
      screenshot-path "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png"
      hotkey-overlay {
          skip-at-startup
      }
      binds {
          // `niri msg action do-something`.
          Mod+Shift+H { show-hotkey-overlay; }
          Mod+C { close-window; }
          Mod+Q { spawn "${lib.getExe pkgs.wezterm}"; }
          Mod+F { spawn "${lib.getExe config.rose.programs.browsers.mainBrowser}"; }
          Mod+R { spawn "${lib.getExe pkgs.fuzzel}"; }
          Mod+D { spawn "${lib.getExe pkgs.wezterm}" "start" "${pkgs.peaclock}/bin/peaclock"; }
          Mod+E { spawn "${lib.getExe pkgs.gnome.nautilus}"; }
          XF86AudioRaiseVolume { spawn "${pkgs.wireplumber}/bin/wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+"; }
          XF86AudioLowerVolume { spawn "${pkgs.wireplumber}/bin/wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-"; }

          Mod+T { switch-preset-column-width; }
          Mod+V { maximize-column; }
          Mod+X { fullscreen-window; }
          Print { screenshot; }
          Ctrl+Print { screenshot-screen; }
          Alt+Print { screenshot-window; }
          Mod+Shift+E { quit; }
          Mod+Shift+P { power-off-monitors; }

          Mod+Left  { focus-column-left; }
          Mod+Right { focus-column-right; }
          Mod+Up    { focus-window-or-workspace-up; }
          Mod+Down  { focus-window-or-workspace-down; }
          Mod+H     { focus-column-left; }
          Mod+L     { focus-column-right; }
          Mod+J     { focus-window-or-workspace-down; }
          Mod+K     { focus-window-or-workspace-up; }

          Mod+Ctrl+Left  { move-column-left; }
          Mod+Ctrl+Down  { move-window-to-workspace-down; }
          Mod+Ctrl+Up    { move-window-to-workspace-up; }
          Mod+Ctrl+Right { move-column-right; }
          Mod+Ctrl+H     { move-column-left; }
          Mod+Ctrl+J     { move-window-to-workspace-down; }
          Mod+Ctrl+K     { move-window-to-workspace-up; }
          Mod+Ctrl+L     { move-column-right; }

          Mod+1      { focus-workspace 1; }
          Mod+2      { focus-workspace 2; }
          Mod+3      { focus-workspace 3; }
          Mod+4      { focus-workspace 4; }
          Mod+5      { focus-workspace 5; }
          Mod+6      { focus-workspace 6; }
          Mod+7      { focus-workspace 7; }
          Mod+8      { focus-workspace 8; }
          Mod+9      { focus-workspace 9; }
          Mod+Ctrl+1 { move-column-to-workspace 1; }
          Mod+Ctrl+2 { move-column-to-workspace 2; }
          Mod+Ctrl+3 { move-column-to-workspace 3; }
          Mod+Ctrl+4 { move-column-to-workspace 4; }
          Mod+Ctrl+5 { move-column-to-workspace 5; }
          Mod+Ctrl+6 { move-column-to-workspace 6; }
          Mod+Ctrl+7 { move-column-to-workspace 7; }
          Mod+Ctrl+8 { move-column-to-workspace 8; }
          Mod+Ctrl+9 { move-column-to-workspace 9; }
        
          Mod+Comma  { consume-window-into-column; }
          Mod+Period { expel-window-from-column; }
          Mod+Minus { set-column-width "-10%"; }
          Mod+Equal { set-column-width "+10%"; }
          Mod+Shift+Minus { set-window-height "-10%"; }
          Mod+Shift+Equal { set-window-height "+10%"; }
      }
    '';
  };
}
