{pkgs,lib, user_wallpaper, ...}:
{
  xdg.configFile = {
    "river/autostart.sh".executable = true;
    "river/autostart.sh".text = ''
    ${lib.getExe pkgs.networkmanagerapplet} --indicator &
    ${lib.getExe pkgs.swww} init &
    ${lib.getExe pkgs.swww} img ${user_wallpaper} &
    ${pkgs.gnome.gnome-keyring}/bin/gnome-keyring-daemon -r --unlock &
    ${lib.getExe pkgs.swaynotificationcenter} &
    ${pkgs.openssh}/bin/ssh-agent &
    ${pkgs.udiskie}/bin/udiskie &
    ${lib.getExe pkgs.swayidle} -w timeout 150 '${lib.getExe pkgs.swaylock-effects} -f' &
    ${lib.getExe (
        pkgs.waybar.overrideAttrs (oldAttrs: {
          mesonFlags = oldAttrs.mesonFlags ++ ["-Dexperimental=true"];
        })
      )}
    '';


    "river/init".executable = true;
    "river/init".text = ''
    mod="Super"
    riverctl map normal $mod F spawn ${lib.getExe pkgs.firefox} 
    riverctl map normal $mod Q spawn ${lib.getExe pkgs.alacritty} 
    riverctl map normal $mod L spawn ${lib.getExe pkgs.swaylock-effects}
    riverctl map normal $mod E spawn ${pkgs.gnome.nautilus}/bin/nautilus 
    riverctl map normal $mod R spawn ${lib.getExe pkgs.fuzzel}
    riverctl map normal $mod M spawn ${lib.getExe pkgs.wlogout}
    riverctl map normal $mod Print spawn ${lib.getExe pkgs.grimblast} copy area
    
    riverctl map normal Super Left focus-output next
    riverctl map normal Super Right focus-output previous
    riverctl map-pointer normal Super BTN_MIDDLE toggle-float
    
    riverctl map normal $mod C close


    for i in $(seq 1 9)
    do
        tags=$((1 << ($i - 1)))
    
        # Super+[1-9] to focus tag [0-8]
        riverctl map normal $mod $i set-focused-tags $tags
    
        # Super+Shift+[1-9] to tag focused view with tag [0-8]
        riverctl map normal $mod+Shift $i set-view-tags $tags
    
        # Super+Control+[1-9] to toggle focus of tag [0-8]
        riverctl map normal $mod+Control $i toggle-focused-tags $tags
    
        # Super+Shift+Control+[1-9] to toggle tag [0-8] of focused view
        riverctl map normal $mod+Shift+Control $i toggle-view-tags $tags
    done
    tags1to9=$(((1 << 9) - 1))
    riverctl map normal $mod Tab focus-previous-tags

    for mode in normal locked
    do
        # Control volume 
        riverctl map $mode None XF86AudioRaiseVolume  spawn 'amixer sset Master 2%+'
        riverctl map $mode None XF86AudioLowerVolume  spawn 'amixer sset Master 2%-'
        riverctl map $mode None XF86AudioMute         spawn 'amixer set Master 1+ toggle'
    
        # Control MPRIS aware media players with playerctl (https://github.com/altdesktop/playerctl)
        riverctl map $mode None XF86AudioMedia spawn 'playerctl play-pause'
        riverctl map $mode None XF86AudioPlay  spawn 'playerctl play-pause'
        riverctl map $mode None XF86AudioPrev  spawn 'playerctl previous'
        riverctl map $mode None XF86AudioNext  spawn 'playerctl next'
    
        # Control screen backlight brightness with light (https://github.com/haikarainen/light)
        riverctl map $mode None XF86MonBrightnessUp   spawn 'light -A 5; light -O'
        riverctl map $mode None XF86MonBrightnessDown spawn 'light -U 5; light -O'
    done

    riverctl map-pointer normal $mod BTN_LEFT move-view
    riverctl map-pointer normal $mod BTN_RIGHT resize-view 
    
    riverctl map normal $mod V toggle-float
    riverctl map normal $mod X toggle-fullscreen
    
    riverctl set-repeat 50 300

    riverctl focus-follows-cursor normal
    riverctl set-cursor-warp on-focus-change
    riverctl rule-add -app-id "waybar" csd
    riverctl rule-add -app-id "wlogout" csd
    riverctl rule-add -app-id "wlogout" fullscreen 
    riverctl default-layout rivertile

    $HOME/.config/river/autostart.sh &
    rivertile -view-padding 6 -outer-padding 6
    '';
  };
}
