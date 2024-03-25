{ config
, pkgs
, lib
, ...
}:
let
  cfg = config.programs.devtools;
in
{
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
      GOPATH = "${config.home.homeDirectory}/.local/share/go";
    };

    programs.jujutsu = {
      enable = true;
      settings = {
        user = {
          name = config.programs.git.userName;
          email = config.programs.git.userEmail;
        };
	ui = {
	  default-command = "log";
	};
      };
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
      { enable = true; }
      (import ./devtools/nixvim/dev-general.nix {
        inherit pkgs;
        inherit config;
      }).config
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
      lazydocker
      undocker
      udocker
      docker-ls
      docker-gc
      docker-sync
      docker-slim
      docker-buildx
      docker-compose

      lazygit
      darcs
      unzip
      git
      ollama
      buildah
      gh
      glab
      fd
      ripgrep
      sbctl
      podman-compose
      tldr
      jq
      yq
      scc
      just
      iotop
      nix-prefetch-git
      pre-commit
      fh
      trashy
      android-tools
      wireshark
      wormhole-rs
      lldb
      gdb
      okteta
      bubblewrap
      just
      waypipe
      cage
      distrobox
      cosign
      jsonnet
      kubernetes-helm
      kind
      jujutsu
      darcs
      melange
      dive
      earthly
      poetry
      maturin
      hatch
      bun
      act
      cargo-wasi
      wasmer
      gnome.gnome-disk-utility
      (writeScriptBin "mount-qcow" ''
        	QCOW_PATH=$1
        	shift
        	set -euox pipefail
        	sudo modprobe nbd
        	sudo qemu-nbd $QCOW_PATH /dev/nbd0 &
        	sudo pkill qemu-nbd
      '')
      (writeScriptBin "code" "${lib.getExe config.programs.vscode.package} --enable-features=UseOzonePlatform,WaylandWindowDecorations --ozone-platform=wayland $@")
    ];
  };
}
