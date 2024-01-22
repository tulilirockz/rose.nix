{
  "org/gnome/desktop/interface" = {
    clock-show-weekday = true;
    #cursor-theme = "Adwaita";
    document-font-name = "Cantarell 11";
    enable-hot-corners = true;
    font-antialiasing = "rgba";
    font-hinting = "full";
    font-name = "Cantarell 11";
    gtk-theme = "adw-gtk3-dark";
    icon-theme = "Adwaita";
    monospace-font-name = "Source Code Pro Regular 10";
  };

  "org/gnome/desktop/wm/preferences" = {
    titlebar-font = "Cantarell Bold 11";
  };

  "org/gnome/desktop/sound" = {
    theme-name = "Adwaita";
  };

  "org/gnome/desktop/peripherals/mouse" = {
    accel-profile = "flat";
  };

  "org/gnome/mutter" = {
    center-new-windows = true;
  };

  "org/gnome/desktop/wm/preferences" = {
    button-layout = ":minimize,maximize,close";
    num-workspaces = "4";
    title-bar-font = "Cantarell 11";
  };

  "org/gnome/shell" = {
    enabled-extensions = ["appindicatorsupport@rgcjonas.gmail.com" "blur-my-shell@aunetx" "tiling-assistant@leleat-on-github"];
    favorite-apps = ["org.gnome.Nautilus.desktop" "firefox.desktop" "Alacritty.desktop" "com.rafaelmardojai.Blanket.desktop" "org.gnome.Solanum.desktop" "Waydroid.desktop" "virt-manager.desktop"];
  };

  "org/gnome/desktop/peripherals/touchpad" = {
    tap-to-click = true;
  };

  "org/gtk/gtk4/settings/file-chooser" = {
    show-hidden = true;
    sort-directories-first = true;
  };

  "org/gnome/shell/extensions/panel-corners" = {
    panel-corners = true;
    screen-corners = true;
    scren-corner-radius = 8;
  };

  "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
    binding = "<Control><Alt>t";
    command = "kgx";
    name = "Launch Console";
  };

  "org/gnome/settings-daemon/plugins/media-keys" = {
    custom-keybindings = ["/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"];
  };

  "org/gnome/shell/extensions/blur-my-shell/panel" = {
    blur = false;
  };

  "org/gnome/desktop/privacy" = {
    remember-recent-files = false;
    remove-old-temp-files = true;
    remove-old-trash-files = true;
  };

  "org/gnome/settings-daemon/plugins/power" = {
    sleep-inactive-ac-timeout = 3600;
  };

  "org/gnome/desktop/media-handling" = {
    autorun-never = true;
  };

  "org/gnome/nautilus/preferences" = {
    search-filter-time-type = "last_modified";
  };

  "org/gnome/nautilus/list-view" = {
    use-tree-view = true;
  };

  "org/gnome/tweaks" = {
    show-extensions-notice = false;
  };
}
