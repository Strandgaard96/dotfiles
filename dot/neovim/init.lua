local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.runtimepath:prepend(lazypath)

require("config.base") -- Standard VIM settings, loaded before all the plugins.

require("lazy").setup("plugins", {
	git = {
		-- defaults for the `Lazy log` command
		-- log = { "-10" }, -- show the last 10 commits
		log = { "--since=3 days ago" }, -- show commits from the last 3 days
		timeout = 120, -- kill processes that take more than 2 minutes
		url_format = "https://github.com/%s.git",
		-- lazy.nvim requires git >=2.19.0. If you really want to use lazy with an older version,
		-- then set the below to false. This is should work, but is NOT supported and will
		-- increase downloads a lot.

		-- This needs to be set to false for older git versions!!!!! Eg remote clusters
		filter = true,
	},
	ui = {
		border = "rounded",
	},
})
require("config.maps") -- Most key mappings
require("config.colorscheme") -- Set colorscheme
-- Borders for LspInfo winodw
require("lspconfig.ui.windows").default_options.border = "single"
