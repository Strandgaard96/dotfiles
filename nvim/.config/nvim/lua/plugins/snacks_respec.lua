return {
  -- lazy.nvim
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        matcher = {
          fuzzy = true, -- use fuzzy matching
          smartcase = true, -- use smartcase
          ignorecase = true, -- use ignorecase
          sort_empty = false, -- sort results when the search string is empty
          filename_bonus = true, -- give bonus for matching file names (last part of the path)
          file_pos = true, -- support patterns like `file:line:col` and `file:line`
          -- the bonusses below, possibly require string concatenation and path normalization,
          -- so this can have a performance impact for large lists and increase memory usage
          cwd_bonus = false, -- give bonus for matching files in the cwd
          frecency = false, -- frecency bonus
          history_bonus = false, -- give more weight to chronological order
        },
        formatters = {
          text = {
            ft = nil, ---@type string? filetype for highlighting
          },
          file = {
            filename_first = false, -- display filename before the file path
            truncate = 80, -- truncate the file path to (roughly) this length
            filename_only = false, -- only show the filename
            icon_width = 2, -- width of the icon (in characters)
            git_status_hl = true, -- use the git status highlight group for the filename
          },
          selected = {
            show_always = false, -- only show the selected column when there are multiple selections
            unselected = true, -- use the unselected icon for unselected items
          },
          severity = {
            icons = true, -- show severity icons
            level = false, -- show severity level
            ---@type "left"|"right"
            pos = "left", -- position of the diagnostics
          },
        },
      },
    },
    -- stylua: ignore
  },
}
