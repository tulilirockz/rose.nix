{
  config,
  lib,
  pkgs,
  preferences,
  ...
}:
let
  cfg = config.rose.programs.desktops.wayfire;
  autoStartScript = pkgs.writeScriptBin "wf-autostart.sh" ''
    ${lib.getExe pkgs.swaybg} -m fill -i ${preferences.theme.wallpaperPath} &
    ${lib.getExe config.rose.programs.ags.package}
  '';
in
{
  options.rose.programs.desktops.wayfire.enable = lib.mkEnableOption "Wayfire Compositor Configuration";

  config = lib.mkIf cfg.enable {
    rose.programs.desktops.wm.enable = true;
    rose.programs.ags.enable = true;

    xdg.configFile = {
      "wayfire.ini".text = ''
        [core]
        plugins = animate autostart command vswitch simple-tile move zoom decorate
        close_top_view = <super> KEY_C
        preferred_decoration_mode = client
        vwidth = 3
        vheight = 3

        [zoom]
        modifier = <super> <shift>

        [resize]
        actvate = <super> BTN_LEFT

        [input]
        xkb_layout = us,br
        xkb_option = grp:win_space_toggle,compose:ralt
        xkb_variant = ,phonetic
        kb_repeat_rate = 60.0
        kb_repeat_delay = 200.0

        [simple-tile]
        key_focus_above = <super> KEY_UP
        key_focus_below = <super> KEY_DOWN
        key_focus_left = <super> KEY_LEFT
        key_focus_right = <super> KEY_RIGHT
        key_toggle = <super> KEY_T
        key_toggle_fullscreen = <super> KEY_X
        button_resize = <super> BTN_RIGHT
        inner_gap_size = 5
        outer_horiz_gap_size = 5
        outer_vert_gap_size = 5

        [vswitch]
        duration = 150
        binding_up = <super> <shift> KEY_UP
        binding_down = <super> <shift> KEY_DOWN
        binding_left = <super> <shift> KEY_LEFT
        binding_right = <super> <shift> KEY_RIGHT

        [command]
        binding_print = KEY_PRINT
        binding_terminal = <super> KEY_Q
        binding_browser = <super> KEY_F
        binding_launcher = <super> KEY_R
        binding_files = <super> KEY_E
        binding_logout = <super> KEY_M
        command_print = ${lib.getExe pkgs.grim} -g \"$(${lib.getExe pkgs.slurp})" - | ${pkgs.wl-clipboard}/bin/wl-copy
        command_terminal = ${pkgs.foot}/bin/footclient
        command_browser = ${lib.getExe config.rose.programs.browsers.mainBrowser}        
        command_launcher = ${lib.getExe config.rose.programs.ags.package}
        command_files = ${lib.getExe pkgs.gnome.nautilus}
        command_logout = ${lib.getExe pkgs.wlogout}

        [autostart]
        shell = ${lib.getExe autoStartScript}
      '';
    };
  };
}
