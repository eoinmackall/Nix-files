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
          #config = ''
          #  require('nvim-treesitter-legacy.config').setup {
          #    highlight = { enable = true },
          #  }
          #'';
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
       
    initLua = ''
      vim.g.mapleader = ' '
      
      vim.opt.number = true
      vim.opt.shiftwidth = 4
      vim.opt.expandtab = true
      vim.opt.tabstop = 4
      vim.opt.clipboard:append("unnamedplus")

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "*", 
        callback = function()
          -- Completely disable insert-mode indent triggers
          vim.opt_local.indentkeys = ""
          vim.opt_local.cinkeys = ""
        end,
      })
      
      -- Neo-tree keymap
      vim.keymap.set('n', '\\', ':Neotree toggle<CR>', { noremap = true, silent = true })
     
       -- Telescope Mappings
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>f', builtin.find_files, { desc = 'Search Files' })
      vim.keymap.set('n', '<leader>g', builtin.live_grep, { desc = 'Search Grep' })
      vim.keymap.set('n', '<leader><space>', builtin.buffers, { desc = 'Search Buffers' })

      -- Exit terminal mode with double Escape
      vim.keymap.set('t', '<Esc><Esc>', [[<C-\><C-n>]], { noremap = true, silent = true })
 
      -- Window navigation with Ctrl + hjkl
      vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Navigate left' })
      vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Navigate down' })
      vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Navigate up' })
      vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Navigate right' }) 
      
    '';
  };
}

