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
          key = "<C-s>";
          action = ":w<CR>";
        }
	{
          key = "<leader>m";
          action = "<cmd>CHADopen<CR>";
	  options.silent = true;
        }
	{
          key = "<leader>sg";
          action = "<cmd>Telescope fd<CR>";
	  options.silent = true;
        }
	{
          key = "<leader>sf";
          action = "<cmd>Telescope find_files<CR>";
	  options.silent = true;
        }  
	{
          key = "<leader>gf";
          action = "<cmd>Telescope git_files<CR>";
	  options.silent = true;
        }
	{
          key = "<leader>t";
          action = "<cmd>FloatermToggle<CR>";
	  options.silent = true;
        }
      ];

      plugins = {
        
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
	floaterm.enable = true;
	indent-blankline.enable = true;
	lsp-format.enable = true;
	
	lualine = {
	  enable = true;
	  globalstatus = true;
	};

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
              "<C-k>" = "signature_help";
              "<leader>rn" = "rename";
              "<leader>ca" = "code_action";
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

