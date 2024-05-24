{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.rose.system.theme;
in
{
  options.rose.system.theme = with lib; {
    enable = mkEnableOption "Default theme for Rose";
    polarity = mkOption {
      default = "dark";
      description = "Dark or Light theme";
      type = types.str;
    };
    homeManager = mkOption {
      default = { };
      description = "Enable HomeManager integration";
      type = types.submodule (_: {
        options.enable = mkEnableOption "Home Manager integration with Stylix";
      });
    };
  };

  config = lib.mkIf cfg.enable {
    stylix = {
      image = ../../../assets/amiga.png;
      polarity = cfg.polarity;
      targets.gnome.enable = lib.mkForce false;
      autoEnable = true;
      cursor = {
        size = 26;
        name = "macOS-Monterey";
        package = pkgs.apple-cursor;
      };
      opacity = rec {
        terminal = 0.7;
        popups = terminal;
        applications = terminal;
      };
      fonts = {
        monospace = {
          name = "JetBrainsMono Nerd Font Mono";
          package = pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; };
        };
        sansSerif = {
          name = "Inter";
          package = pkgs.inter;
        };
        serif = {
          name = "Inter";
          package = pkgs.inter;
        };
        sizes = {
          applications = 12;
          terminal = 12;
          desktop = 12;
          popups = 12;
        };
      };
      base16Scheme = rec {
        #scheme: "Windows 10"
        #author: "Fergus Collins (https://github.com/C-Fergus)"
        base00 = "0c0c0c"; # black
        base01 = "2f2f2f"; # darkish black
        #base02 = "535353"; # brightish black
        base02 = base01; # brightish black
        base03 = "767676"; # bright black
        base04 = "b9b9b9"; # darker white
        base05 = "cccccc"; # white
        base06 = "dfdfdf"; # middle white
        base07 = "f2f2f2"; # bright white
        #base08 = "e74856"; # bright red
        base08 = base0D; # bright red
        base09 = "c19c00"; # yellow
        base0A = "f9f1a5"; # bright yellow
        base0B = base0C; # bright green
        base0C = "61d6d6"; # bright cyan
        base0D = "3b78ff"; # bright blue
        base0E = "b4009e"; # bright magenta
        # base0F = "13a10e"; # green
        base0F = base0D; # green
      };
    };
  };
}
