{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.programs.devtools;
in {
  options = {
    programs.devtools.enable = lib.mkEnableOption {
      description = "Enable my managed development configuration";
      example = true;
      default = false;
    };
  };
  config = lib.mkIf cfg.enable {
    programs.nixvim = lib.mkMerge [
      {enable = true;}
      (import ./nixvim.nix {
        inherit pkgs;
        inherit config;
      })
      .config
    ];

    programs.vscode = {
      enable = true;
      package = pkgs.vscodium;
    };

    programs.direnv = {
      enable = true;
      enableNushellIntegration = true;
      enableBashIntegration = true;
      nix-direnv.enable = true;
    };

    home.packages = with pkgs; [
      lazygit
      darcs
      unzip
      just
      git
      tmux
      ollama
      buildah
      gh
      glab
      fd
      ripgrep
      nixos-generators
      podman-compose
      docker-compose
      tldr
      manix
      podman-desktop
      godot_4
      gitg
      gource
      scc
      just
      iotop
      nix-prefetch-git
      kind
      pre-commit
      atuin
      fh
      (pkgs.writeScriptBin "code" "${lib.getExe config.programs.vscode.package} --enable-features=UseOzonePlatform,WaylandWindowDecorations --ozone-platform=wayland $@")
    ];
  };
}
