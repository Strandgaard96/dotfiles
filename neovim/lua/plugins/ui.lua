return {

	-- icons
	{ "kyazdani42/nvim-web-devicons", lazy = true },

	-- ui components
	{ "MunifTanjim/nui.nvim", lazy = true },

	{
		"goolord/alpha-nvim",
		dependencies = { "kyazdani42/nvim-web-devicons" },
		event = "VimEnter",
		opts = function()
			local dashboard = require("alpha.themes.dashboard")
			-- ASCII TEXT: https://github.com/glepnir/dashboard-nvim/wiki/Ascii-Header-Text
			local logo = [[
⠀⠀⢰⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⠆⠀⠀
⠀⣄⠈⠻⣷⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⣿⠏⠀⣀⠀
⠀⠘⣿⣦⡈⠻⠀⣄⠀⠀⠀⠀⠀⢀⣴⢸⠟⣡⣴⡿⠃⠀
⠐⣶⣌⡻⢿⠰⣄⠻⣷⣦⡀⢀⣴⣿⠟⣠⣸⡿⢛⣡⡴⠂
⠠⣈⠻⢿⡆⣀⠻⣷⡬⢋⣴⠹⢋⣵⡿⠟⠀⣶⣿⠟⢁⡀
⠀⠹⣷⣤⡁⠸⣿⡎⣴⡿⢋⡄⡿⢋⣴⡿⠀⢩⣴⣿⠏⠀
⠠⣤⣌⠙⠇⢷⣦⡁⢛⣴⡿⠃⣰⠟⣫⣴⠇⠼⠛⣁⣠⠄
⠀⠹⠿⣷⡆⢈⡙⠃⡿⣫⡾⢇⢁⣾⠿⢋⡄⣴⣾⡿⠋⠀
⠀⠳⣶⣌⡁⠸⢿⠀⣾⢟⣵⠎⠈⣤⣾⡿⠐⢉⣥⡶⠂⠀
⠀⠠⣬⣙⠳⠸⣦⢈⣵⠟⣡⡞⠘⣋⣥⡶⠠⠿⢛⣁⠀⠀
⠀⠀⠙⠿⢿⡀⣌⢘⡵⢟⣫⡄⠼⢟⣫⠅⣴⡿⠛⠁⠀⠀
⠀⠀⠀⠰⣶⣦⡌⣨⠶⢛⡩⢠⡾⣿⡋⢀⣷⡶⠂⠀⠀⠀
⠀⠀⠀⠀⢠⣭⢡⡴⢞⣻⢅⡷⠿⡛⢁⣩⣥⠄⠀⠀⠀⠀
⠀⠀⠀⠀⠀⣠⣵⠾⠟⠁⠐⠛⠛⠐⣛⣛⡁⠀⠀⠀⠀⠀
⠀⠀⠀⠠⠚⠉⠁⠀⠀⠀⠀⠀⠀⠀⠈⠉⠛⠂⠀⠀⠀⠀
      ]]

			dashboard.section.header.val = vim.split(logo, "\n")
			dashboard.section.buttons.val = {
				dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
				dashboard.button("n", " " .. " New file", ":ene <BAR> startinsert <CR>"),
				dashboard.button("r", " " .. " Recent files", ":Telescope oldfiles <CR>"),
				dashboard.button("g", " " .. " Find text", ":Telescope live_grep <CR>"),
				dashboard.button("p", "P" .. " Open projects", ":Telescope projects <CR>"),
				dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
				dashboard.button("l", "L " .. " Lazy", ":Lazy<CR>"),
				dashboard.button("q", " " .. " Quit", ":qa<CR>"),
			}
			for _, button in ipairs(dashboard.section.buttons.val) do
				button.opts.hl = "AlphaButtons"
				button.opts.hl_shortcut = "AlphaShortcut"
			end
			dashboard.section.footer.opts.hl = "Type"
			dashboard.section.header.opts.hl = "AlphaHeader"
			dashboard.section.buttons.opts.hl = "AlphaButtons"
			dashboard.opts.layout[1].val = 8
			return dashboard
		end,
		config = function(_, dashboard)
			-- close Lazy and re-open when the dashboard is ready
			if vim.o.filetype == "lazy" then
				vim.cmd.close()
				vim.api.nvim_create_autocmd("User", {
					pattern = "AlphaReady",
					callback = function()
						require("lazy").show()
					end,
				})
			end

			require("alpha").setup(dashboard.opts)

			vim.api.nvim_create_autocmd("User", {
				pattern = "LazyVimStarted",
				callback = function()
					local stats = require("lazy").stats()
					local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
					dashboard.section.footer.val = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
					pcall(vim.cmd.AlphaRedraw)
				end,
			})
		end,
	},
