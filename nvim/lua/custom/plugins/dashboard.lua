return {
   "nvimdev/dashboard-nvim",
   event = "VimEnter",
   opts = function()
      local opts = {
         theme = "doom",
         hide = {
            -- this is taken care of by lualine
            -- enabling this messes up the actual laststatus setting after loading a file
            statusline = false,
         },
         config = {
            -- stylua: ignore
            center = {
               { action = "Telescope find_files", desc = " Find file", icon = " ", key = "f" },
               { action = "ene | startinsert", desc = " New file", icon = " ", key = "n" },
               { action = "Telescope oldfiles", desc = " Recent files", icon = " ", key = "r" },
               { action = "Telescope live_grep", desc = " Find text", icon = " ", key = "g" },
               { action = 'lua require("telescope").telescope.config_files()', desc = " Config", icon = " ", key = "c" },
               { action = 'lua require("persistence").load()', desc = " Restore Session", icon = " ", key = "s" },
               { action = "Lazy", desc = " Lazy", icon = "󰒲 ", key = "l" },
               { action = "qa", desc = " Quit", icon = " ", key = "q" },
            },
         },
      }

      for _, button in ipairs(opts.config.center) do
         button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
         button.key_format = "  %s"
      end

      -- close Lazy and re-open when the dashboard is ready
      if vim.o.filetype == "lazy" then
         vim.cmd.close()
         vim.api.nvim_create_autocmd("User", {
            pattern = "DashboardLoaded",
            callback = function()
               require("lazy").show()
            end,
         })
      end

      return opts
   end,
}
