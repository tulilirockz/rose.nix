{
  preferences,
  config,
  lib,
  ...
}:
let
  cfg = config.rose.home.impermanence;
in
{
  options.rose.home.impermanence = with lib; {
    enable = mkEnableOption "Impermanence setup for Home";
    extraDirectories = mkOption {
      type = types.listOf types.str;
      default = [ ];
      example = [ ".local/share/amogus" ];
      description = "Extra Paths to be added to impermanence";
    };
  };

  config = lib.mkIf cfg.enable {
    home.persistence."/nix/persist/home/${preferences.username}" = {
      allowOther = true;
      directories = [
        "Downloads"
        "Music"
        "Pictures"
        "Documents"
        "Videos"
        "Games"
        "opt"
        ".gnupg"
        ".ssh"
        ".mozilla"
        ".cache/nix"
        ".config/nautilus"
        ".local/share/nautilus"
        ".config/news-flash"
        ".config/monophony"
        ".config/nix"
        ".config/heroic"
        ".config/libvirt"
        ".config/kdeconnect"
        ".config/rclone"
        ".config/libreoffice"
        ".local/state/wireplumber"
        ".local/share/flatpak"
        ".local/share/keyrings"
        ".local/share/gnome-podcasts"
        ".local/share/news-flash"
        ".local/share/news_flash"
        {
          directory = ".var";
          method = "symlink";
        }
        {
          directory = ".local/share/bottles";
          method = "symlink";
        }
        {
          directory = ".local/share/Steam";
          method = "symlink";
        }
        {
          directory = ".local/share/waydroid";
          method = "symlink";
        }
        {
          directory = ".local/share/gnome-boxes";
          method = "symlink";
        }
        {
          directory = ".local/share/images";
          method = "symlink";
        }
        {
          directory = ".local/share/containers";
          method = "symlink";
        }
        {
          directory = ".local/share/docker";
          method = "symlink";
        }
      ] ++ cfg.extraDirectories;
    };
  };
}
