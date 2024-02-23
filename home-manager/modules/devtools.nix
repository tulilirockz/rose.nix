{
  config,
  pkgs,
  lib,
  preferences,
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
    home.sessionVariables = {
      EDITOR = "nvim";
      DOCKER_HOST = "unix:///run/podman/podman.sock";
      GOPATH = "${config.home.homeDirectory}/.local/share/go";
    };
    programs.git = {
      enable = true;
      userEmail = "tulilirockz@outlook.com";
      userName = "Tulili";
      signing.key = "/home/tulili/.ssh/id_ed25519.pub";
      signing.signByDefault = true;
      extraConfig = {
        gpg.format = "ssh";
        init.defaultBranch = "main";
      };
    };

    xdg.configFile."libvirt/qemu.conf".text = ''
      nvram = [ "/run/libvirt/nix-ovmf/AAVMF_CODE.fd:/run/libvirt/nix-ovmf/AAVMF_VARS.fd", "/run/libvirt/nix-ovmf/OVMF_CODE.fd:/run/libvirt/nix-ovmf/OVMF_VARS.fd" ]
    '';

    programs.nixvim = lib.mkMerge [
      {enable = true;}
      (import ./devtools/nixvim/dev-general.nix {
        inherit pkgs;
        inherit config;
        inherit preferences;
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
      #tmux
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
