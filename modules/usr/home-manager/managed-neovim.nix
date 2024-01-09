{
  config,
  lib,
  ...
}: let
  cfg = config.programs.managed-neovim;
in {
  options = {
    programs.managed-neovim.enable = lib.mkEnableOption {
      description = "Enable my managed nixneovim configuration";
      example = true;
      default = false;
    };
  };
  config = lib.mkIf cfg.enable {
    programs.nixvim = lib.mkMerge [{enable = true;} (import ./nixvim/shared.nix).config];
  };
}
