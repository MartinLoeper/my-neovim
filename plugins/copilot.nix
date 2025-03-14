{ pkgs, ... }: {
  plugin = pkgs.vimPlugins.copilot-lua;
  config = ''
     require("copilot").setup({
       suggestion = { 
         enabled = true, 
         auto_trigger = true,
         keymap = {
           accept = "<S-Tab>",
           accept_word = "<M-Tab>",
         },
       },
       panel = { enabled = false, auto_refresh = true },
    })

    local toggleCopilot = function()
      local copilot = require("copilot")
      local client = require("copilot.client")
      -- toggle global variable for stop condition
      -- first toggle sets the none existing variable to true
      vim.g.copilot_enabled = not vim.g.copilot_enabled
      -- stop or start copilot
      local noti = require("notify")
      local noti_opts = { title = "Copilot", icon = "", timeout = 1000, hide_from_history = true }
      if vim.g.copilot_enabled then
        -- spin up lsp from scratch ang get client setup and attached
        copilot.setup()
        client.setup()
        noti("ON", "info", noti_opts)
      else
        -- detatch first to prevent lsp spamming it's own notifications when teardown is called
        client.buf_detach()
        -- destroy microsoft XD
        client.teardown()
        noti("OFF", "error", noti_opts)
      end
    end

    vim.api.nvim_create_user_command("ToggleCopilot", toggleCopilot, { range = false })
    vim.keymap.set("n", "<leader>ts", "<cmd>ToggleCopilot<cr>", { desc = " Toggle Copilot" })

     -- make the suggestions italic s.t. the monaspace handwritten font is used
     -- see pending issue: https://github.com/zbirenbaum/copilot.lua/issues/324
     vim.api.nvim_set_hl(0, "CopilotSuggestion", { fg = "#555555", italic = true })
  '';
  type = "lua";
}

