-colortscheme tokyonight
require("tokyonight").setup({
	-- use the night style
	style = "night",
	transparent = true,
	-- disable italic for functions
	styles = {
		sidebars = "transparent",
		floats = "transparent",
	},
	sidebars = { "qf", "vista_kind", "terminal", "packer" },
	-- Change the "hint" color to the "orange" color, and make the "error" color bright red
	on_colors = function(colors)
		colors.hint = colors.orange
		colors.error = "#ff0000"
		colors.border = "#565f89" -- Set the window split line color!!
	end,
})

local colorscheme = "tokyonight"
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
	return
end

-- Other options
-- https://github.com/navarasu/onedark.nvim
