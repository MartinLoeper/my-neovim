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

     vim.keymap.set('n', '<leader>ts', function()
       local enabled = vim.g.copilot_enabled or true
       vim.g.copilot_enabled = not enabled
       print("Copilot " .. (not enabled and "enabled" or "disabled"))
     end, { desc = "Toggle Copilot" })

     -- make the suggestions italic s.t. the monaspace handwritten font is used
     -- see pending issue: https://github.com/zbirenbaum/copilot.lua/issues/324
     vim.api.nvim_set_hl(0, "CopilotSuggestion", { fg = "#555555", italic = true })
  '';
  type = "lua";
}

