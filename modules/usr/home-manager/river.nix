{
  config,
  pkgs,
  lib,
  preferences,
  ...
}: {
  xdg.configFile = {
    "river/autostart.sh".executable = true;
    "river/autostart.sh".text = ''
      ${lib.getExe pkgs.networkmanagerapplet} --indicator &
      ${lib.getExe pkgs.swaybg} -m fill -i ${preferences.wallpaper} &
      ${pkgs.gnome.gnome-keyring}/bin/gnome-keyring-daemon -r --unlock &
      ${lib.getExe pkgs.swaynotificationcenter} &
      ${pkgs.openssh}/bin/ssh-agent &
      ${pkgs.udiskie}/bin/udiskie &
      ${lib.getExe pkgs.swayidle} -w timeout 150 '${lib.getExe pkgs.swaylock-effects} -f' &
      ${lib.getExe pkgs.foot} --server &
      ${lib.getExe pkgs.waybar}
    '';

    "river/init".executable = true;
    "river/init".text = ''
      mod="Super"
      amixer="${pkgs.alsa-utils}/bin/amixer"
      light="${lib.getExe pkgs.light}"
      playerctl="${lib.getExe pkgs.playerctl}"
      terminal="${pkgs.foot}/bin/footclient"

      riverctl map normal $mod F spawn ${lib.getExe pkgs.firefox}
      riverctl map normal $mod Q spawn $terminal
      riverctl map normal $mod L spawn ${lib.getExe pkgs.swaylock-effects}
      riverctl map normal $mod E spawn "$terminal -e \"${lib.getExe pkgs.yazi}\""
      riverctl map normal $mod R spawn ${lib.getExe pkgs.fuzzel}
      riverctl map normal $mod M spawn ${lib.getExe pkgs.wlogout}
      riverctl map normal None Print spawn "${lib.getExe pkgs.grimblast} copy area"
      riverctl map normal $mod C close

      for i in $(seq 1 9)
      do
          tags=$((1 << ($i - 1)))

          # $mod+[1-9] to focus tag [0-8]
          riverctl map normal $mod $i set-focused-tags $tags

          # $mod+Shift+[1-9] to tag focused view with tag [0-8]
          riverctl map normal $mod+Shift $i set-view-tags $tags

          # $mod+Control+[1-9] to toggle focus of tag [0-8]
          riverctl map normal $mod+Control $i toggle-focused-tags $tags

          # $mod+Shift+Control+[1-9] to toggle tag [0-8] of focused view
          riverctl map normal $mod+Shift+Control $i toggle-view-tags $tags
      done
      tags1to9=$(((1 << 9) - 1))


      for mode in normal locked
      do
          # Control volume
          riverctl map $mode None XF86AudioRaiseVolume  spawn '$amixer set Master 2%+'
          riverctl map $mode None XF86AudioLowerVolume  spawn '$amixer set Master 2%-'
          riverctl map $mode None XF86AudioMute         spawn '$amixer set Master 1+ toggle'

          # Control MPRIS aware media players with playerctl (https://github.com/altdesktop/playerctl)
          riverctl map $mode None XF86AudioMedia spawn '$playerctl play-pause'
          riverctl map $mode None XF86AudioPlay  spawn '$playerctl play-pause'
          riverctl map $mode None XF86AudioPrev  spawn '$playerctl previous'
          riverctl map $mode None XF86AudioNext  spawn '$playerctl next'

          # Control screen backlight brightness with light (https://github.com/haikarainen/light)
          riverctl map $mode None XF86MonBrightnessUp   spawn '$light -A 5; $light -O'
          riverctl map $mode None XF86MonBrightnessDown spawn '$light -U 5; $light -O'
      done

      for pointer in $(riverctl list-inputs | grep -v configured | grep pointer) ; do
          riverctl input $pointer accel-profile flat
          riverctl input $pointer pointer-accel 0
      done

      riverctl map normal $mod Tab focus-previous-tags

      riverctl map-pointer normal $mod BTN_LEFT move-view
      riverctl map-pointer normal $mod BTN_RIGHT resize-view
      riverctl map-pointer normal $mod BTN_MIDDLE toggle-float

      riverctl map normal $mod V toggle-float
      riverctl map normal $mod X toggle-fullscreen

      riverctl map normal $mod Up focus-view next
      riverctl map normal $mod Down focus-view previous

      riverctl map normal $mod J focus-view next
      riverctl map normal $mod K focus-view previous


      riverctl map normal $mod+Shift Period send-to-output next
      riverctl map normal $mod+Shift Comma send-to-output previous

      riverctl map normal $mod Return zoom

      riverctl map normal $mod+Alt H move left 100
      riverctl map normal $mod+Alt J move down 100
      riverctl map normal $mod+Alt K move up 100
      riverctl map normal $mod+Alt L move right 100

      riverctl map normal $mod+Alt Left move left 100
      riverctl map normal $mod+Alt Down move down 100
      riverctl map normal $mod+Alt Up move up 100
      riverctl map normal $mod+Alt Right move right 100

      riverctl map normal $mod+Shift H resize horizontal -100
      riverctl map normal $mod+Shift J resize vertical 100
      riverctl map normal $mod+Shift K resize vertical -100
      riverctl map normal $mod+Shift L resize horizontal 100

      riverctl map normal $mod+Shift Left resize horizontal -100
      riverctl map normal $mod+Shift Down resize vertical 100
      riverctl map normal $mod+Shift Up resize vertical -100
      riverctl map normal $mod+Shift Right resize horizontal 100

      riverctl map normal $mod+Shift 9 keyboard-layout br
      riverctl map normal $mod+Shift 0 keyboard-layout us

      riverctl map normal $mod Left send-layout-cmd rivertile "main-ratio -0.05"
      riverctl map normal $mod Right send-layout-cmd rivertile "main-ratio +0.05"

      riverctl map normal $mod H send-layout-cmd rivertile "main-ratio -0.05"
      riverctl map normal $mod L send-layout-cmd rivertile "main-ratio +0.05"

      riverctl map normal $mod+Shift Left send-layout-cmd rivertile "main-count +1"
      riverctl map normal $mod+Shift Right send-layout-cmd rivertile "main-count -1"

      riverctl map normal $mod+Shift H send-layout-cmd rivertile "main-count +1"
      riverctl map normal $mod+Shift L send-layout-cmd rivertile "main-count -1"

      riverctl set-repeat 50 300

      riverctl focus-follows-cursor normal
      riverctl set-cursor-warp on-focus-change
      riverctl rule-add -app-id "waybar" csd
      riverctl rule-add -app-id "wlogout" csd
      riverctl rule-add -app-id "wlogout" fullscreen
      riverctl default-layout rivertile

      riverctl border-color-focused 0x${config.colorScheme.palette.base0E}FF
      riverctl border-color-unfocused 0x${config.colorScheme.palette.base00}FF
      riverctl border-color-urgent 0x${config.colorScheme.palette.base07}FF

      riverctl map-switch normal lid close "systemctl suspend"

      $HOME/.config/river/autostart.sh &
      rivertile -view-padding 6 -outer-padding 6
    '';
  };
}
