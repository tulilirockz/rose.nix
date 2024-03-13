{ pkgs
, ...
}:
# Made to be imported by programs.nixvim
let
  leaderBinding = key: command: {
    key = "<leader>${key}";
    action = "<cmd>${command}<CR>";
    options.silent = true;
  };
in
{
  config = {
    globals.mapleader = ",";

    clipboard.register = "unnamedplus";
    clipboard.providers.wl-copy.enable = true;

    options = {
      number = true;
      relativenumber = true;
      shiftwidth = 2;
    };

    filetype.pattern = {
      ".*\.nu" = "nu";
    };

    colorschemes.poimandres.enable = true;

    extraPlugins = with pkgs.vimPlugins; [
      nvim-remote-containers
      plenary-nvim
      vim-rhubarb
      octo-nvim
    ];

    extraConfigLua = "${import ./octo-config.nix}";

    keymaps = map ({ key, action }: leaderBinding "${key}" "${action}") [
      { key = "m"; action = "Oil"; }
      { key = "sg"; action = "Telescope live_grep"; }
      { key = "sf"; action = "Telescope find_files"; }
      { key = "sb"; action = "Telescope current_buffer_fuzzy_find"; }
      { key = "gf"; action = "Telescope git_files"; }
      { key = "t"; action = "ToggleTerm"; }
      { key = "ty"; action = "ToggleTermSendCurrentLine"; }
      { key = "T"; action = "term"; }
      { key = "g"; action = "Neogit"; }
      { key = "gc"; action = "Neogit commit"; }
      { key = "ol"; action = "Octo actions"; }
      { key = "oi"; action = "Octo issue list"; }
      { key = "op"; action = "Octo pr list"; }
      { key = "ha"; action = "lua require(\"harpoon.mark\").add_file()"; }
      { key = "hn"; action = "lua require(\"harpoon.ui\").nav_next()"; }
      { key = "hp"; action = "lua require(\"harpoon.ui\").nav_prev()"; }
      { key = "hm"; action = "Telescope harpoon marks"; }
      { key = "ik"; action = "Telescope keymaps"; }
      { key = "ic"; action = "Telescope commands"; }
      { key = "ih"; action = "Telescope help_tags"; }
      { key = "it"; action = "Tutor"; }
      { key = "e"; action = "TroubleToggle"; }
      { key = "ld"; action = "Telescope lsp_definitions"; }
      { key = "lr"; action = "Telescope lsp_references"; }
      { key = "li"; action = "Telescope lsp_implementations"; }
      { key = "lD"; action = "Telescope lsp_type_definitions"; }
      { key = "lds"; action = "Telescope lsp_document_symbols"; }
      { key = "lws"; action = "Telescope lsp_workspace_symbols"; }
    ] ++
    (map (num: leaderBinding "${toString num}" "lua require(\"harpoon.ui\").nav_file(${toString num})")
      [ 1 2 3 4 5 6 7 8 9 ]
    );

    editorconfig.enable = true;

    plugins = {
      nix-develop.enable = true;
      toggleterm.enable = true;
      rustaceanvim = {
        enable = true;
        tools.executor = "toggleterm";
      };

      trouble.enable = true;
      friendly-snippets.enable = true;
      lint.enable = true;
      dap.enable = true;
      lsp-format.enable = true;
      lsp = {
        enable = true;
        keymaps = {
          diagnostic = {
            "<leader>j" = "goto_next";
            "<leader>k" = "goto_prev";
          };
          lspBuf = {
            "K" = "hover";
            "<leader>lrn" = "rename";
          };
        };
        servers = {
          bashls.enable = true;
          tailwindcss.enable = true;
          yamlls.enable = true;
          clojure-lsp.enable = true;
          nushell = {
            enable = true;
            autostart = true;
            filetypes = [ "*.nu" "nu" ];
          };
          rust-analyzer = {
            enable = false;
            installCargo = true;
            installRustc = true;
            settings.files.excludeDirs = [
              ".direnv/**"
              "target/**"
            ];
          };
          clangd.enable = true;
          gopls.enable = true;
          dockerls.enable = true;
          zls.enable = true;
          nil_ls.enable = true;
          pyright = {
            enable = true;
            autostart = true;
          };
        };
      };

      # Static after this line, should not edit! 
      telescope.enable = true;
      treesitter.enable = true;
      treesitter-context.enable = true;
      fidget.enable = true;
      which-key.enable = true;
      indent-blankline.enable = true;
      spider.enable = true;
      nvim-colorizer.enable = true;
      neogit.enable = true;
      harpoon = {
        enable = true;
        enableTelescope = true;
      };
      oil = {
        enable = true;
        skipConfirmForSimpleEdits = true;
        deleteToTrash = true;
        viewOptions.showHidden = true;
      };
      leap.enable = true;
      lualine = { enable = true; globalstatus = true; };
      coq-nvim = {
        enable = true;
        alwaysComplete = true;
        autoStart = true;
        installArtifacts = true;
        recommendedKeymaps = true;
      };
      gitblame = {
        enable = true;
        messageTemplate = "<summary> by <author> @ <date>";
      };
    };
  };
}
