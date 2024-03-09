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

    colorschemes.poimandres.enable = true;

    extraPlugins = with pkgs.vimPlugins; [
      nvim-remote-containers
      plenary-nvim
      vim-rhubarb
      octo-nvim
    ];

    extraConfigLua = "${import ./octo-config.nix}";

    keymaps = map ({ key, action }: leaderBinding "${key}" "${action}") [
      { key = "s"; action = "<cmd>w<CR>"; }
      { key = "n"; action = "<cmd>Lspsaga outline<CR>"; }
      { key = "m"; action = "<cmd>Oil<CR>"; }
      { key = "sg"; action = "<cmd>Telescope live_grep<CR>"; }
      { key = "sf"; action = "<cmd>Telescope find_files<CR>"; }
      { key = "sb"; action = "<cmd>Telescope current_buffer_fuzzy_find<CR>"; }
      { key = "gf"; action = "<cmd>Telescope git_files<CR>"; }
      { key = "t"; action = "<cmd>term<CR>"; }
      { key = "<space>"; action = "<cmd>Startify<CR>"; }
      { key = "gb"; action = "<cmd>Git blame<CR>"; }
      { key = "g"; action = "<cmd>Neogit<CR>"; }
      { key = "gc"; action = "<cmd>Neogit commit<CR>"; }
      { key = "ol"; action = "<cmd>Octo actions<CR>"; }
      { key = "oi"; action = "<cmd>Octo issue list<CR>"; }
      { key = "op"; action = "<cmd>Octo pr list<CR>"; }
      { key = "ha"; action = "<cmd>lua require(\"harpoon.mark\").add_file()<CR>"; }
      { key = "hn"; action = "<cmd>lua require(\"harpoon.ui\").nav_next()<CR>"; }
      { key = "hp"; action = "<cmd>lua require(\"harpoon.ui\").nav_prev()<CR>"; }
      { key = "hm"; action = "<cmd>Telescope harpoon marks<CR>"; }
      { key = "ik"; action = "<cmd>Telescope keymaps<CR>"; }
      { key = "ic"; action = "<cmd>Telescope commands<CR>"; }
      { key = "ih"; action = "<cmd>Telescope help_tags<CR>"; }
    ] ++ 
    (map (num: leaderBinding "h${toString num}" "lua require(\"harpoon.ui\").nav_file(${toString num})") 
      [ 1 2 3 4 5 6 7 8 9 ]
    );

    editorconfig.enable = true;

    plugins = {
      telescope.enable = true;
      cursorline.enable = true;
      fidget.enable = true;
      nix-develop.enable = true;
      bufferline.enable = true;
      which-key.enable = true;
      treesitter.enable = true;
      treesitter-context.enable = true;
      indent-blankline.enable = true;
      lsp-format.enable = true;
      nix.enable = true;
      nvim-colorizer.enable = true;
      lint.enable = true;
      molten.enable = true;
      netman.enable = true;
      gitblame.enable = true;
      image.enable = true;
      neogit.enable = true;
      rustaceanvim.enable = true;
      leap.enable = true;
      oil.enable = true;
      spider.enable = true;

      harpoon = {
        enable = true;
        enableTelescope = true;
      };

      startify = {
        enable = true;
        enableUnsafe = true;
        changeToVcsRoot = true;
        updateOldFiles = true;
        customHeader = "${pkgs.lib.getExe pkgs.fortune} | ${pkgs.lib.getExe pkgs.lolcat}";
      };

      lspsaga = {
        enable = false;
        callhierarchy.layout = "normal";
        codeAction.showServerName = true;
      };

      lualine = {
        enable = true;
        globalstatus = true;
        extensions = [ "fzf" "quickfix" "man" "symbols-outline" ];
      };

      coq-nvim = {
        enable = true;
        alwaysComplete = true;
        autoStart = true;
        installArtifacts = true;
        recommendedKeymaps = true;
      };

      lsp = {
        enable = true;
        keymaps = {
          silent = true;
        };
        servers = {
          bashls.enable = true;
          tailwindcss.enable = true;
          yamlls.enable = true;
          nushell.enable = true;
          nushell.autostart = true;
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
    };
  };
}
