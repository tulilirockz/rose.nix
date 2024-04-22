{ config
, pkgs
, lib
, inputs
, ...
}:
let
  cfg = config.rose.programs.tools.dev;
in
{
  options.rose.programs.tools.dev = with lib; {
    enable = mkEnableOption "Development Tools";
    gui = mkOption {
      type = types.submodule (_: {
        options.enable = mkEnableOption "GUI Development Tools";
      });
    };
    impermanence = mkOption {
      type = types.submodule (_: {
        options.enable = mkEnableOption "Enable Impermanence support";
      });
    };
  };

  config = lib.mkIf cfg.enable {
    rose.home.impermanence.extraDirectories = lib.mkIf cfg.impermanence.enable [
      ".nixops"
      ".wasmer"
      ".vscode"
      ".vscodium"
      ".cache/tldr"
      ".cache/NuGetPackages"
      ".cache/nvim"
      ".cache/cargo"
      ".cache/mise"
      ".cache/pre-commit"
      ".cache/direnv"
      ".config/asciinema"
      ".config/carapace"
      ".config/gh"
      ".config/lazygit"
      ".config/watson"
      ".config/direnv"
      ".config/packer"
      ".local/share/flakehub"
      ".local/share/atuin"
      ".local/share/go"
      ".local/share/zoxide"
      ".local/share/dotnet"
      ".local/share/direnv"
      ".local/share/nvim"
    ];

    programs.jujutsu = {
      enable = true;
      settings = {
        user = {
          name = config.programs.git.userName;
          email = config.programs.git.userEmail;
        };
        ui = {
          default-command = "log";
          diff-editor = "meld";
        };
        signing = {
          sign-all = true;
          backend = "ssh";
          key = config.programs.git.signing.key;
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
        core.excludesfile = "${pkgs.writers.writeText "gitignore" ''
        .jj
        .jj/*
        /.jj
        /.git
        .git/*
        .direnv
        /.direnv
        .direnv/*
        ''}";
      };
    };

    xdg.configFile."libvirt/qemu.conf".text = ''
      nvram = [ "/run/libvirt/nix-ovmf/AAVMF_CODE.fd:/run/libvirt/nix-ovmf/AAVMF_VARS.fd", "/run/libvirt/nix-ovmf/OVMF_CODE.fd:/run/libvirt/nix-ovmf/OVMF_VARS.fd" ]
    '';

    programs.direnv = {
      enable = true;
      enableNushellIntegration = true;
      enableBashIntegration = true;
      nix-direnv.enable = true;
    };

    programs.yazi = {
      enable = true;
      enableNushellIntegration = true;
      settings = {
        manager = {
          show_hidden = true;
        };
      };
    };

    programs.zellij = {
      enable = true;
      settings = {
        default_shell = "nu";
        default_layout = "compact";
        pane_frames = false;
      };
    };

    programs.helix = {
      enable = true;
      defaultEditor = true;
      extraPackages = with pkgs; [
        (python3.withPackages
          (p: with p; [
            python-lsp-server
            pylsp-mypy
            pylsp-rope
            python-lsp-ruff
          ])
        )
        yaml-language-server
        tailwindcss-language-server
        clang-tools
        nil
        zls
        marksman
        rust-analyzer
        gopls
        ruff
        docker-ls
        vscode-langservers-extracted
        clojure-lsp
        dockerfile-language-server-nodejs
        nodePackages.typescript-language-server
        terraform-lsp
      ];
      settings = {
        theme = "boo_berry";
        editor = {
          line-number = "relative";
          mouse = false;
          middle-click-paste = false;
          auto-save = true;
          auto-pairs = false;
          lsp = {
            display-messages = true;
            display-inlay-hints = true;
          };
          whitespace.render = {
            tab = "all";
            nbsp = "none";
            nnbsp = "none";
            newline = "none";
          };
          file-picker = {
            hidden = false;
          };
        };
      };
    };

    programs = {
      bun = {
        enable = true;
      };
      fd = {
        enable = true;
      };
      bacon = {
        enable = true;
      };
      bat = {
        enable = true;
      };
      carapace = {
        enable = true;
        enableNushellIntegration = true;
      };
      go = {
        enable = true;
        goPath = ".local/share/go";
      };
      gh = {
        enable = true;
      };
      gh-dash = {
        enable = true;
      };
      thefuck = {
        enable = true;
      };
      hyfetch = {
        enable = true;
        settings = {
          preset = "gendernonconforming1";
          mode = "rgb";
          light_dark = "dark";
          lightness = 0.53;
          color_align = {
            mode = "custom";
            custom_colors = {
              "1" = 1;
              "2" = 3;
            };
            fore_back = [ ];
          };
          backend = "neofetch";
          args = null;
          distro = null;
          pride_month_shown = [ ];
          pride_month_disable = false;
        };
      };
      mise = {
        enable = true;
      };
      navi = {
        enable = true;
      };
      nix-index = {
        enable = true;
      };
      pyenv = {
        enable = true;
      };
      watson = {
        enable = true;
      };
    };

    home.packages = with pkgs; [
      unzip
      buildah
      glab
      fd
      ripgrep
      podman-compose
      tldr
      jq
      yq
      scc
      nix-tree
      just
      iotop
      nix-prefetch-git
      pre-commit
      fh
      android-tools
      wireshark
      wormhole-rs
      lldb
      okteta
      bubblewrap
      just
      waypipe
      cage
      distrobox
      cosign
      jsonnet
      inputs.agenix.packages.${pkgs.system}.default
      gitg
      gource
      meld
      jujutsu
      melange
      dive
      poetry
      earthly
      gdu
      asciinema
      act
      wasmer
      go-task
      gnome.gnome-disk-utility
      (writeScriptBin "gh-jj" ''
        GIT_DIR=.jj/repo/store/git ${lib.getExe pkgs.gh} $@ 
      '')
      (writeScriptBin "mount-qcow" ''
        	set -ex
          QCOW_PATH=$1
        	shift
        	set -euox pipefail
        	sudo modprobe nbd
        	sudo qemu-nbd $QCOW_PATH /dev/nbd0 &
        	sudo pkill qemu-nbd
      '')
      #(writeScriptBin "code-wayland" "${lib.getExe config.programs.vscode.package} --enable-features=UseOzonePlatform,WaylandWindowDecorations --ozone-platform=wayland $@")
    ];
  };
}
