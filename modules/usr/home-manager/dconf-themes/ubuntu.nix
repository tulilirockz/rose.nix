{ 
  "org/gnome/desktop/interface" = {
    color-scheme = "prefer-dark";
    cursor-theme = "Yaru";
    document-font-name = "Ubuntu Nerd Font 11";
    font-name = "Ubuntu Nerd Font 12";
    gtk-theme = "Yaru-magenta-dark";
    icon-theme = "Yaru-magenta-dark";
    monospace-font-name = "UbuntuMono Nerd Font 18";
  };

  "org/gnome/desktop/sound" = {
    allow-volume-above-100-percent = true;
    theme-name = "Yaru";
  };

  "org/gnome/shell/extensions/user-theme" = {
    name = "Yaru-magenta-dark";
  };

  "org/gnome/shell" = {
    enabled-extensions = [ "user-theme@gnome-shell-extensions.gcampax.github.com" "dash-to-dock@micxgx.gmail.com" "appindicatorsupport@rgcjonas.gmail.com" ];
  };

  "org/gnome/desktop/wm/preferences" = {
    button-layout = ":minimize,maximize,close";
    num-workspaces = "4";
    title-bar-font = "Ubuntu Bold 12";
  };

  "org/gnome/shell/extensions/dash-to-dock" = {
    background-color = "rgb(0,0,0)";
    background-opacity = 1;
    click-action = "focus-minimize-or-previews";
    custom-background-color = true;
    custom-theme-shrink = true;
    customize-alphas = true;
    dash-max-icon-size = 48;
    disable-overview-on-startup = true;
    dock-fixed = true;
    dock-position = "LEFT";
    extend-height = true;
    force-straight-corner = false;
    how-icons-notifications-counter = true;
    icon-size-fixed = true;
    show-icons-notifications-counter = true;
    show-mounts = true;
    show-trash = true;
    transparency-mode = "DEFAULT";
  };
  
}
