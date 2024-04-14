{ config, lib, pkgs, ... }:
let
  cfg = config.rose.programs.gaming;
in
{
  options.rose.programs.gaming = with lib; {
    enable = mkEnableOption "Gaming Related";
    steam = mkOption {
      type = types.submodule (_: {
        options.enable = mkEnableOption "Steam";
      });
    };
    others = mkOption {
      type = types.submodule (_: {
        options.enable = mkEnableOption "Other gaming platforms";
      });
    };
  };

  config = with lib; mkIf cfg.enable {
    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (pkgs.lib.getName pkg) [ "steam" "steam-original" "steam-run" "steam-tui" "steamcmd" ];
    environment.systemPackages = with pkgs; [ steam-tui bottles heroic ];
    programs.steam = mkIf cfg.steam.enable {
      enable = true;
      gamescopeSession.enable = true;
    };
  };
}
