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

    -- make the suggestions italic s.t. the monaspace handwritten font is used
    -- see pending issue: https://github.com/zbirenbaum/copilot.lua/issues/324
    vim.api.nvim_set_hl(0, "CopilotSuggestion", { fg = "#555555", italic = true })
  '';
  type = "lua";
}

