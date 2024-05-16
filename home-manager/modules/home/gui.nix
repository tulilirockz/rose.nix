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
      "org/gnome/evolution/mail" = {
        prompt-check-if-default-mailer = false;
        layout = 1;
      };
      "/com/github/wwmm/easyeffects/streaminputs" = {
        plugins = ["echo_canceller#0" "rnnoise#0"];
      };
      "/com/github/wwmm/easyeffects/streaminputs/rnnoise/0" = {
        enable-vad = true;
      };
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
