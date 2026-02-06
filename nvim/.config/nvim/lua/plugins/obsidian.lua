return {
  "obsidian-nvim/obsidian.nvim",
  version = "3.14.7", -- recommended, use latest release instead of latest commit
  -- lazy = true,
  ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = vim.env.OBSIDIAN_VAULT_PATH and {
  --   "BufReadPre " .. vim.env.OBSIDIAN_VAULT_PATH .. "/*.md",
  --   "BufNewFile " .. vim.env.OBSIDIAN_VAULT_PATH .. "/*.md",
  -- } or { "BufReadPre *.md", "BufNewFile *.md" },
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",

    -- see above for full list of optional dependencies ☝️
  },
  ---@module 'obsidian'
  --
  ---@type obsidian.config.ClientOpts
  opts = {
    legacy_commands = false,
    workspaces = {
      {
        name = "My vault",
        path = vim.env.OBSIDIAN_VAULT_PATH,
      },
    },
    daily_notes = {
      -- Optional, if you keep daily notes in a separate directory.
      folder = "daily-notes",
      -- Optional, if you want to change the date format for the ID of daily notes.
      date_format = "%Y-%m-%d",
      -- Optional, if you want to change the date format of the default alias of daily notes.
      alias_format = "%B %-d, %Y",
      -- Optional, default tags to add to each new daily note created.
      default_tags = { "daily-notes" },
      -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
      template = nil,
    },
    completion = {
      blink = true,
    },
    picker = {
      name = "snacks.pick",
    },

    -- see below for full list of options 👇
  },
  -- Optional, for templates (see below).
  templates = {
    folder = ".zk/templates/",
    date_format = "%Y-%m-%d",
    time_format = "%H:%M",
    -- A map for custom variables, the key should be the variable and the value a function
    substitutions = {},
  },
}
