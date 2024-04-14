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
    programs.waybar = {
      enable = true;
      style = import ./waybar/style.nix {
        inherit pkgs;
        inherit config;
        inherit preferences;
      };
      settings = import ./waybar/settings.nix {
        inherit pkgs;
        inherit lib;
      };
    };
  
    home.packages = with pkgs; [
      xwayland-run

      (writeScriptBin "gh-jj" ''
        GIT_DIR=.jj/repo/store/git ${lib.getExe pkgs.gh} $@ 
      '')

      (writeScriptBin "xwayland-run-sway" ''
        ${lib.getExe pkgs.sway} -V &
        sleep 1
        DISPLAY=:0 $@
      '')

      (writeScriptBin "gamescope-run" ''
        ${lib.getExe pkgs.gamescope} -W 1920 -H 1080 -e $@
      '')
    ];

    programs.wlogout = {
      enable = true;
      layout = import ./wlogout/layout.nix;
      style = import ./wlogout/style.nix {
        inherit preferences;
        inherit config;
        inherit pkgs;
      };
    };

    programs.foot = {
      enable = true;
      server.enable = false;
      settings = {
        main = {
          font = "${preferences.theme.fontFamily}:size=12";
          shell = pkgs.lib.getExe pkgs.nushell;
          title = "amogus";
          locked-title = true;
          bold-text-in-bright = true;
        };
        environment = {
          "EDITOR" = lib.getExe pkgs.helix;
        };
        colors = with config.colorScheme.palette; {
          alpha = 0.7;
          background = base00;
          foreground = base05;
        };
      };
    };

    programs.fuzzel = {
      enable = true;
      settings = {
        colors = with config.colorScheme.palette; {
          background = "${base00}FF";
          text = "${base05}FF";
          match = "${base08}FF";
          selection-match = "${base09}FF";
          selection = "${base02}FF";
          selection-text = "${base0A}FF";
          border = "${base07}FF";
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
        image = "${preferences.theme.wallpaperPath}";
        clock = true;
        font = preferences.theme.fontFamily;
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

    xdg.configFile."mako/config".text = with config.colorScheme.palette ; ''
      background-color=#${base00}
      text-color=#${base05}
      border-color=#${base08}
      progress-color=over #${base04}
    
      [urgency=high]
      border-color=#${base0A}
    '';
  };
}
