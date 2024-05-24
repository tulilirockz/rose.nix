{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
let
  cfg = config.rose.programs.dev;
in
{
  options.rose.programs.dev = with lib; {
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
      ".cache/pre-commit"
      ".cache/direnv"
      ".config/asciinema"
      ".config/carapace"
      ".config/gh"
      ".config/Code"
      ".config/lazygit"
      ".config/lapce-stable"
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
      ".local/share/navi"
      ".local/share/lapce-stable"
    ];

    xdg.configFile."libvirt/qemu.conf".text = ''
      nvram = [ "/run/libvirt/nix-ovmf/AAVMF_CODE.fd:/run/libvirt/nix-ovmf/AAVMF_VARS.fd", "/run/libvirt/nix-ovmf/OVMF_CODE.fd:/run/libvirt/nix-ovmf/OVMF_VARS.fd" ]
    '';

    programs = {
      atuin = {
        enable = true;
        enableNushellIntegration = true;
        settings = {
          update_check = false;
        };
      };

      nushell = {
        enable = true;
        package = pkgs.nushellFull;
        extraConfig = ''
          $env.SSH_AUTH_SOCK = $"($env.XDG_RUNTIME_DIR)/ssh-agent"
          $env.config.use_grid_icons = true
          $env.config.footer_mode = always
          $env.config.use_ansi_coloring = true
          $env.config.show_banner = false
          $env.TERM = xterm-256color
        '';

        extraEnv = pkgs.lib.concatMapStringsSep "\n" (string: string) (
          pkgs.lib.attrsets.mapAttrsToList (
            var: value: if (var != "XCURSOR_PATH") then "$env.${toString var} = ${toString value}" else ""
          ) config.home.sessionVariables
        );
      };

      zoxide = {
        enable = true;
        enableNushellIntegration = true;
      };

      jujutsu = {
        enable = true;
        settings = {
          user = {
            name = config.programs.git.userName;
            email = config.programs.git.userEmail;
          };
          ui = {
            default-command = "log";
            paginate = "never";
            merge-editor = "meld";
            diff-editor = "meld";
          };
          signing = {
            sign-all = true;
            backend = "ssh";
            key = config.programs.git.signing.key;
          };
          git = {
            auto-local-branch = true;
          };
          snapshot.max-new-file-size = "10MiB";
        };
      };

      git = {
        enable = true;
        package = pkgs.gitoxide;
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

      direnv = {
        enable = true;
        enableNushellIntegration = true;
        enableBashIntegration = true;
        nix-direnv.enable = true;
      };

      yazi = {
        enable = true;
        enableNushellIntegration = true;
        settings = {
          manager = {
            show_hidden = true;
          };
        };
      };

      helix = {
        enable = true;
        defaultEditor = true;
        extraPackages = with pkgs; [
          (python3.withPackages (
            p: with p; [
              python-lsp-server
              pylsp-mypy
              pylsp-rope
              python-lsp-ruff
            ]
          ))
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
          nodePackages.bash-language-server
          terraform-lsp
          lexical
          glas
        ];
        settings = {
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

      zellij = {
        enable = true;
        settings = {
          default_shell = "nu";
          pane_frames = false;
        };
      };
      go = {
        enable = true;
        goPath = ".local/share/go";
      };

      carapace = {
        enable = true;
        enableNushellIntegration = true;
      };

      bun.enable = true;
      fd.enable = true;
      bacon.enable = true;
      bat.enable = true;
      gh.enable = true;
      gh-dash.enable = true;
      btop.enable = true;
      mangohud.enable = true;
      zsh.enable = true;
    };

    home.packages =
      (lib.optionals cfg.gui.enable (
        with pkgs;
        [
          forge-sparks
          gitg
          gource
          meld
          gnome.gnome-disk-utility
          wireshark
          gitg
          python3Packages.jupyterlab
        ]
      ))
      ++ (with pkgs; [
        nix-prefetch-git
        fh
        nix-tree


        elixir
        clojure
        cargo
        rustc
        gleam
        clang
        erlang
        zig

        cilium-cli
        hubble
        fluxctl
        git
        tektoncd-cli
        woodpecker-cli

        glab
        fd
        ripgrep
        tldr
        jq
        yq
        just
        android-tools
        wormhole-rs
        lldb
        just
        waypipe
        mkosi
        cosign
        melange
        dive
        poetry
        sshx
        mprocs
        earthly
        cool-retro-term
        gdu
        asciinema
        act
        yt-dlp
        ffmpeg-full
        cyme
        btop
        slides
        presenterm
        lapce
        wasmer
        go-task
        glow
        fastfetch
        dysk
        ttyd
        vhs
        trivy
      ]);
  };
}
