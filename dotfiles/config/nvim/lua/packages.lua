-- run :PackerSync
require('packer').startup(function()
	use 'wbthomason/packer.nvim'

	use 'tomasr/molokai'
	use 'gruvbox-community/gruvbox'
	use 'arcticicestudio/nord-vim'
	use 'nanotech/jellybeans.vim'
	use 'jnurmine/Zenburn'
	use 'dracula/vim'

	use 'scrooloose/nerdtree'
	use 'sheerun/vim-polyglot'
	use 'nvim-treesitter/nvim-treesitter'
	use {
		'goolord/alpha-nvim',
		requires = { 'kyazdani42/nvim-web-devicons' },
		config = function ()
			require'alpha'.setup(require'alpha.themes.startify'.opts)
			local startify = require("alpha.themes.startify")
			startify.section.mru_cwd.val = { { type = "padding", val = 0 } }
			startify.section.bottom_buttons.val = {
				startify.button("e", "new file", ":ene <bar> startinsert <cr>"),
				startify.button("v", "neovim config", ":e ~/.config/nvim/init.lua<cr>"),
				startify.button("q", "quit nvim", ":qa<cr>"),
			}
			-- access alpha from keymap
			--vim.api.nvim_set_keymap('n', '<c-n>', ":Alpha<cr>", { noremap = true })
		end
	}
end)
