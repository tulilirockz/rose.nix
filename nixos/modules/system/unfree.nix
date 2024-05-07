{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.rose.system.unfree;
in
{
  options.rose.system.unfree = with lib; {
    enable = mkEnableOption "Allow unfree apps";
    extraPredicates = mkOption {
      type = with types; listOf str;
      default = [ ];
      example = [ "steamcmd" ];
      description = "List of strings that will allow unfree packages";
    };
  };

  config = lib.mkIf cfg.enable {
    nixpkgs.config.allowUnfreePredicate =
      pkg: builtins.elem (pkgs.lib.getName pkg) ([ "vscode" ] ++ cfg.extraPredicates);
  };
}
