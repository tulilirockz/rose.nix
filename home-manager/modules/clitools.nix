{ config
, pkgs
, lib
, ...
}:
let
  cfg = config.programs.clitools;
in
{
  options = {
    programs.clitools.enable = lib.mkEnableOption {
      description = "Enable a CLI-based user experince";
      example = true;
      default = false;
    };
  };
  config = lib.mkIf cfg.enable {
    programs.fzf.enable = true;

    programs.atuin = {
      enable = true;
      enableFishIntegration = true;
      enableNushellIntegration = true;
      enableBashIntegration = true;
    };

    programs.carapace = {
      enable = true;
      enableNushellIntegration = true;
    };

    programs.tmux = {
      enable = false;
      disableConfirmationPrompt = true;
      historyLimit = 10000;
      mouse = true;
      secureSocket = true;
      clock24 = true;
      newSession = true;
      terminal = "xterm-256color";
      keyMode = "vi";
      extraConfig = ''
        	set -sg escape-time 10
              	set -g @thumbs-osc52 1
              	set-window-option -g mode-keys vi
              	bind-key -T copy-mode-vi v send-keys -X begin-selection
              	bind-key -T copy-mode-vi C-v send-keys -X rectangle toggle
              	bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel
              	
              	set -g @plugin catppuccin/tmux-mocha
              	set -g @plugin christoomey/vim-tmux-navigator
      '';
      plugins = with pkgs.tmuxPlugins; [
        tmux-fzf
        tmux-thumbs
        catppuccin
        sensible
        vim-tmux-navigator
      ];
    };

    programs.nushell.enable = true;
    programs.nushell.extraConfig = with config.colorScheme.palette; ''
            let base16_colors = {
      	  base00: "#${base00}",
      	  base01: "#${base01}",
      	  base02: "#${base02}",
      	  base03: "#${base03}",
      	  base04: "#${base04}",
      	  base05: "#${base05}",
      	  base06: "#${base06}",
      	  base07: "#${base07}",
      	  base08: "#${base08}",
      	  base09: "#${base09}",
      	  base0a: "#${base0A}",
      	  base0b: "#${base0B}",
      	  base0c: "#${base0C}",
      	  base0d: "#${base0D}",
      	  base0e: "#${base0E}",
      	  base0f: "#${base0F}"
            }

            let base16_theme = {
              separator: $base16_colors.base03
              leading_trailing_space_bg: $base16_colors.base04
              header: $base16_colors.base0b
              date: $base16_colors.base0e
              filesize: $base16_colors.base0d
              row_index: $base16_colors.base0c
              bool: $base16_colors.base08
              int: $base16_colors.base0b
              duration: $base16_colors.base08
              range: $base16_colors.base08
              float: $base16_colors.base08
              string: $base16_colors.base04
              nothing: $base16_colors.base08
              binary: $base16_colors.base08
              cellpath: $base16_colors.base08
              hints: dark_gray

              shape_garbage: { fg: "#FFFFFF" bg: "#FF0000" attr: b}
              shape_bool: $base16_colors.base0d
              shape_int: { fg: $base16_colors.base0e attr: b}
              shape_float: { fg: $base16_colors.base0e attr: b}
              shape_range: { fg: $base16_colors.base0a attr: b}
              shape_internalcall: { fg: $base16_colors.base0c attr: b}
              shape_external: $base16_colors.base0c
              shape_externalarg: { fg: $base16_colors.base0b attr: b}
              shape_literal: $base16_colors.base0d
              shape_operator: $base16_colors.base0a
              shape_signature: { fg: $base16_colors.base0b attr: b}
              shape_string: $base16_colors.base0b
              shape_filepath: $base16_colors.base0d
              shape_globpattern: { fg: $base16_colors.base0d attr: b}
              shape_variable: $base16_colors.base0e
              shape_flag: { fg: $base16_colors.base0d attr: b}
              shape_custom: {attr: b}
            }

            $env.config.color_config = $base16_theme
            $env.config.use_grid_icons = true
            $env.config.footer_mode = always #always, never, number_of_rows, auto
            $env.config.float_precision = 2
            $env.config.use_ansi_coloring = true
            $env.config.edit_mode = vi
            $env.config.show_banner = false
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
