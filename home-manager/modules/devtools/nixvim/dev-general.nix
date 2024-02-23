{
  pkgs,
  ...
}:
# Made to be imported by programs.nixvim
{
  config = {
    globals.mapleader = ",";
    
    enableMan = true;

    clipboard.register = "unnamedplus";
    clipboard.providers.wl-copy.enable = true;

    options = {
      number = true;
      relativenumber = true;
      shiftwidth = 2;
    };

    colorschemes.melange = {
      enable = true;
    };

    extraPlugins = with pkgs.vimPlugins; [
      nvim-remote-containers
      plenary-nvim
      octo-nvim
    ];

    extraConfigLua = import ./octo-config.nix;

    keymaps = [
      {
        key = "<C-s>";
        action = ":w<CR>";
      }
      {
        key = "<leader>n";
        action = "<cmd>Lspsaga outline<CR>";
        options.silent = true;
      }
      {
        key = "<leader>m";
        action = "<cmd>CHADopen<CR>";
        options.silent = true;
      }
      {
        key = "<leader>sg";
        action = "<cmd>Telescope live_grep<CR>";
        options.silent = true;
      }
      {
        key = "<leader>sf";
        action = "<cmd>Telescope find_files<CR>";
        options.silent = true;
      }
      {
        key = "<leader>sb";
        action = "<cmd>Telescope current_buffer_fuzzy_find<CR>";
        options.silent = true;
      }
      {
        key = "<leader>gf";
        action = "<cmd>Telescope git_files<CR>";
        options.silent = true;
      }
      {
        key = "<leader>t";
        action = "<cmd>term<CR>";
        options.silent = true;
      }
      {
        key = "<leader>e";
        action = "<cmd>Lspsaga show_buf_diagnostics<CR>";
        options.silent = true;
      }
      {
        key = "<leader>rn";
        action = "<cmd>Lspsaga rename<CR>";
        options.silent = true;
      }
      {
        key = "<leader>ca";
        action = "<cmd>Lspsaga code_action<CR>";
        options.silent = true;
      }
      {
        key = "<leader>k";
        action = "<cmd>Lspsaga hover_doc<CR>";
        options.silent = true;
      }
      {
        key = "<leader>gd";
        action = "<cmd>Lspsaga goto_definition<CR>";
        options.silent = true;
      }
      {
        key = "<leader><space>";
        action = "<cmd>Startify<CR>";
        options.silent = true;
      }
    ];

    editorconfig.enable = true;

    plugins = {
      chadtree.enable = true;
      telescope.enable = true;
      cursorline.enable = true;
      fidget.enable = true;
      nix-develop.enable = true;
      bufferline.enable = true;
      which-key.enable = true;
      treesitter.enable = true;
      indent-blankline.enable = true;
      lsp-format.enable = true;
      nix.enable = true;
      nvim-colorizer.enable = true;
      lint.enable = true;
      molten.enable = true;
      netman.enable = true;
      gitblame.enable = true;

      image.enable = true;

      fugitive.enable = true;

      nvim-bqf = {
        enable = true;
        autoEnable = true;
        autoResizeHeight = true;
      };

      startify = {
        enable = true;
        enableUnsafe = true;
        changeToVcsRoot = true;
        updateOldFiles = true;
      };

      lspsaga = {
        enable = true;
        beacon.enable = true;
        callhierarchy.layout = "normal";
        codeAction.showServerName = true;
        lightbulb.enable = true;
        lightbulb.sign = false;
      };

      lualine = {
        enable = true;
        globalstatus = true;
        extensions = ["fzf" "quickfix" "chadtree" "man" "symbols-outline"];
      };

      coq-nvim = {
        enable = true;
        alwaysComplete = true;
        autoStart = true;
        installArtifacts = true;
        recommendedKeymaps = true;
      };

      barbar = {
        enable = true;
        keymaps = {
          goTo1 = "<A-1>";
          goTo2 = "<A-2>";
          goTo3 = "<A-3>";
          goTo4 = "<A-4>";
          goTo5 = "<A-5>";
          goTo6 = "<A-6>";
          goTo7 = "<A-7>";
          goTo8 = "<A-8>";
          goTo9 = "<A-9>";
          last = "<A-0>";
          pin = "<A-p>";
          next = "<TAB>";
          previous = "<S-TAB>";
          close = "<A-c>";
        };
      };

      lsp = {
        enable = true;
        keymaps = {
          silent = true;
        };
        servers = {
          bashls.enable = true;
          clangd.enable = true;
          gopls.enable = true;
          rust-analyzer.enable = true;
          rust-analyzer.installCargo = true;
          rust-analyzer.installRustc = true;
          dockerls.enable = true;
          tailwindcss.enable = true;
          yamlls.enable = true;
          zls.enable = true;
          nil_ls.enable = true;
          pyright = {
            enable = true;
            autostart = true;
          };
        };
      };
    };
  };
}
