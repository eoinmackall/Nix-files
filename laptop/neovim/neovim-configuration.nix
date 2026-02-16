{config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      {
      plugin = gruvbox-material;
      type = "lua";
      config = ''
      vim.g.gruvbox_material_background = 'hard'
      vim.g.gruvbox_material_foreground = 'original'
      vim.cmd.colorscheme 'gruvbox-material'
      '';
      }
      {
      plugin = lualine-nvim;
      type = "lua";
      config = ''
        require('lualine').setup()
	'';
      }
      {
      plugin = (nvim-treesitter.withPlugins (plugins: with plugins; [
      lua
      vim
      nix
      python
      julia
      ]));
      type = "lua";
      config = ''
        require('nvim-treesitter.configs').setup {
	highlight = { enable = true},
      }
      '';
      }
      {
        plugin = which-key-nvim;
	type = "lua";
	config = ''
	   require("which-key").setup {
           -- You can put your specific settings here
             timeoutlen = 300, 
        } 
        '';
      }

      nui-nvim
      plenary-nvim
      nvim-web-devicons
      {
        plugin = neo-tree-nvim;
        type = "lua";
	config = ''
	  require("neo-tree").setup({
	    close_if_last_window=true,
	    window = {
	      width = 30,
	    },
	  })
	'';
      }
      telescope-nvim
    ];

       
    extraLuaConfig = ''
      vim.g.mapleader = ' '
      
      vim.opt.number = true
      vim.opt.shiftwidth = 4
      vim.opt.expandtab = true
      vim.opt.tabstop = 4
      vim.opt.smartindent = false
      vim.opt.clipboard:append("unnamedplus")

      -- Neo-tree keymap
      vim.keymap.set('n', '\\', ':Neotree toggle<CR>', { noremap = true, silent = true })
     
     
       -- Telescope Mappings
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>f', builtin.find_files, { desc = 'Search Files' })
      vim.keymap.set('n', '<leader>g', builtin.live_grep, { desc = 'Search Grep' })
      vim.keymap.set('n', '<leader><space>', builtin.buffers, { desc = 'Search Buffers' })

      '';
  };
}
