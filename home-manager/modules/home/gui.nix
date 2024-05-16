{
  config,
  preferences,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.rose.home.gui;
in
{
  options.rose.home.gui.enable = lib.mkEnableOption "General GUI related home-manager options";

  config = lib.mkIf cfg.enable {

    home.pointerCursor = {
      gtk.enable = true;
      x11.enable = true;
      package = pkgs.fuchsia-cursor;
      name = preferences.theme.cursor.name;
      size = 16;
    };

    gtk = {
      enable = true;
      theme = {
        package = pkgs.adw-gtk3;
        name = preferences.theme.gtk.name;
      };
      iconTheme = {
        package = pkgs.gnome.adwaita-icon-theme;
        name = preferences.theme.icon.name;
      };
    };

    xdg.configFile."gnome-boxes/sources/QEMU System".text = ''
      [source]
      name=QEMU Session
      type=libvirt
      uri=qemu+unix:///session
      save-on-quit=true
    '';

    dconf.settings = {
      "org/virt-manager/virt-manager/connections" = {
        autoconnect = [ "qemu:///session" ];
        uris = [ "qemu:///session" ];
      };
    };
  };
}
