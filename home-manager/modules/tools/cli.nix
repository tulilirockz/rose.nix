{ config
, pkgs
, lib
, ...
}:
let
  cfg = config.rose.programs.tools.cli;
in
{
  options.rose.programs.tools.cli.enable = lib.mkEnableOption "CLI-only tools";

  config = lib.mkIf cfg.enable {
    programs.fzf.enable = true;

    programs.atuin = {
      enable = true;
      enableNushellIntegration = true;
    };

    programs.fish.enable = true;
    programs.nushell.enable = true;
    programs.nushell.extraConfig = ''    
      $env.SSH_AUTH_SOCK = $"($env.XDG_RUNTIME_DIR)/ssh-agent.socket"
      $env.config.use_grid_icons = true
      $env.config.footer_mode = always
      $env.config.use_ansi_coloring = true
      $env.config.edit_mode = vi
      $env.config.show_banner = false
      ${if (config.programs.mise.enable) then
        ''
          if not ("${config.home.homeDirectory}/.cache/mise/init.nu" | path exists) {
            ${lib.getExe pkgs.mise} activate | save --force ${config.home.homeDirectory}/.cache/mise/init.nu
          }

          source ${config.home.homeDirectory}/.cache/mise/init.nu
        ''
      else ""}
    '';

    programs.nushell.extraEnv = pkgs.lib.concatMapStringsSep "\n" (string: string) (
      pkgs.lib.attrsets.mapAttrsToList
        (var: value:
          if (var != "XCURSOR_PATH" && var != "TMUX_TMPDIR")
          then "$env.${toString var} = ${toString value}"
          else "")
        config.home.sessionVariables
    );

    programs.zoxide = {
      enable = true;
      enableNushellIntegration = true;
    };
  };
}
