{ config, lib, ... }:

let
  cfg = config.programs.managed-neovim;
in
{
  options = {
    programs.managed-neovim.enable = lib.mkEnableOption {
      description = "Enable my managed nixneovim configuration";
      example = true;
      default = false;
    };
  };
  config = lib.mkIf cfg.enable {
    programs.nixvim = {
      enable = true;
      globals.mapleader = ",";
      
      clipboard.providers.wl-copy.enable = true;

      options = {
        number = true;
        relativenumber = true;
        shiftwidth = 2;
      };
      
      colorschemes.rose-pine.enable = true;

      keymaps = [
        {
          action = "<cmd>CHADopen<CR>";
          key = "<C-m>";
          options = {
            silent = true;
          };
        }
      ]; 

      plugins = {
        lualine.enable = true;
        chadtree.enable = true;
        telescope.enable = true;
        barbecue.enable = true;
        coq-thirdparty.enable = true;
        cursorline.enable = true;
        fidget.enable = true;
        nix-develop.enable = true;
        bufferline.enable = true;
        which-key.enable = true;
	treesitter.enable = true;

        coq-nvim = {
          enable = true;
          alwaysComplete = true;
          autoStart = true;
          installArtifacts = true;
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
        
        harpoon = {
          enable = true;
          enableTelescope = true;
          keymaps.addFile = "<leader>a";
        };
  
        lsp = {
          enable = true;
          keymaps = {
            silent = true;
            diagnostic = {
              "<leader>k" = "goto_prev";
              "<leader>j" = "goto_next";
            };
  
            lspBuf = {
              gd = "definition";
              K = "hover";
            };
          };
          servers = {
            bashls.enable = true;
            clangd.enable = true;
            gopls.enable = true;
            rust-analyzer.enable = true;
            rust-analyzer.installCargo = true;
            rust-analyzer.installRustc = true;
            zls.enable = true;
            nil_ls.enable = true;
          };
        };
      };
    };
  };
}

