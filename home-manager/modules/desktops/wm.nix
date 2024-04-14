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

    services.easyeffects.enable = true;
    services.kdeconnect.enable = true;
    services.udiskie.enable = true;

    programs.wlogout = {
      enable = true;
      layout = import ./components/wlogout/layout.nix;
      style = import ./components/wlogout/style.nix {
        inherit preferences;
        inherit config;
        inherit pkgs;
      };
    };

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
  };
}
