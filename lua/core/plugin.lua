local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugin.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
	-- Required Basic Plugins
	use({ "wbthomason/packer.nvim" }) -- Have packer manage itself
	use({ "nvim-lua/plenary.nvim" })
	use("nvim-lua/popup.nvim")
	-- Highlighter
	use("nvim-treesitter/nvim-treesitter")
	use("folke/tokyonight.nvim")
	use("windwp/nvim-autopairs") -- Autopairs, integrates with both cmp and treesitter
	use("numToStr/Comment.nvim") -- Easily comment stuff
	use("kyazdani42/nvim-web-devicons")
	use("kyazdani42/nvim-tree.lua")
	use("hrsh7th/nvim-cmp") -- The completion plugin
	use("hrsh7th/cmp-buffer") -- buffer completions
	use("hrsh7th/cmp-path") -- path completions
	use("hrsh7th/cmp-cmdline") -- cmdline completions
	use("saadparwaiz1/cmp_luasnip") -- snippet completions
	use("hrsh7th/cmp-nvim-lsp")
	use("L3MON4D3/LuaSnip") --snippet engine
	use("rafamadriz/friendly-snippets") -- a bunch of snippets to use
	use("lewis6991/gitsigns.nvim")

	use("neovim/nvim-lspconfig") -- enable LSP
	use("williamboman/nvim-lsp-installer") -- simple to use language server installer
	-- use "tamago324/nlsp-settings.nvim" -- language server settings defined in json for
	use({
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
	})
	use("jose-elias-alvarez/null-ls.nvim")
	use("nvim-telescope/telescope.nvim")
	use({
		"nvim-telescope/telescope-fzf-native.nvim",
		run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
	})
	use("JoosepAlviste/nvim-ts-context-commentstring")

	use("lewis6991/gitsigns.nvim")
	use("feline-nvim/feline.nvim")
	use("NvChad/nvim-colorizer.lua")

	-- snippets

	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
