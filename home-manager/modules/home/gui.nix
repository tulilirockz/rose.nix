{
  config,
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
      name = "Fuchsia";
      size = 16;
    };

    gtk = {
      enable = true;
      theme = {
        package = pkgs.adw-gtk3;
        name = "adw-gtk3-dark";
      };
      iconTheme = {
        package = pkgs.gnome.adwaita-icon-theme;
        name = "Adwaita";
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
      "org/virt-manager/virt-manager/new-vm" = {
        "storage-format" = "raw";
        "graphics-type" = "spice";
        "cpu-default" = "host-passthrough";
        firmware = "uefi";
        "enable-cpu-poll" = false;
        "cpu-usage" = false;
        "xmleditor-enabled" = true;
      };    
    };
  };
}
