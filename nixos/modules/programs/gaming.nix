{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
let
  cfg = config.rose.programs.gaming;
in
{
  options.rose.programs.gaming = with lib; {
    enable = mkEnableOption "Gaming Related";
    steam = mkOption {
      description = "Steam and Unfree predicates";
      type = types.submodule (_: {
        options.enable = mkEnableOption "Steam";
      });
    };
    others = mkOption {
      default = { };
      description = "Placeholder for other game types";
      type = types.submodule (_: {
        options.enable = mkEnableOption "Other gaming platforms";
      });
    };
  };

  config = lib.mkIf cfg.enable {
    rose.system.unfree.extraPredicates =
      (lib.lists.optionals cfg.steam.enable [
        "steam"
        "steam-original"
        "steam-run"
        "steam-tui"
        "steamcmd"
      ]);
    environment.systemPackages =
      with pkgs;
      [ mangohud ]
      ++ (lib.lists.optionals cfg.steam.enable (
        with pkgs;
        [
          steam-tui
          steamcmd
        ]
      ))
      ++ (lib.lists.optionals cfg.others.enable (
        with pkgs;
        [
          bottles
          heroic
          inputs.umu.packages.${pkgs.system}.umu
        ]
      ));
    programs.steam = {
      enable = cfg.steam.enable;
      extraCompatPackages = with pkgs; [ proton-ge-bin ];
    };
  };
}
