{
  config,
  lib,
  pkgs,
  ...
}:
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

  config = lib.mkIf cfg.enable {
    rose.system.unfree.extraPredicates = [
      "steam"
      "steam-original"
      "steam-run"
      "steam-tui"
      "steamcmd"
    ];
    environment.systemPackages = with pkgs; [
      steam-tui
      bottles
      heroic
    ];
    programs.steam = lib.mkIf cfg.steam.enable {
      enable = true;
      extraCompatPackages = with pkgs; [ proton-ge-bin ];
      gamescopeSession.enable = false;
    };
  };
}
