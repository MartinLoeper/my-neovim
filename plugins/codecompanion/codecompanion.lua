require("codecompanion").setup({
  display = {
    chat = {
      intro_message = "",
      show_settings = false,
      show_token_count = true,
      start_in_insert_mode = false,
      window = {
        position = "right",
      },
    }
  },
  strategies = {
    chat = {
      adapter = "anthropic",
      model = "claude-3-5-sonnet-20241022",
    },
    inline = {
      adapter = "anthropic",
      model = "claude-3-5-sonnet-20241022",
    },
  },
  adapters = {
    anthropic = function()
      return require("codecompanion.adapters").extend("anthropic", {
        env = {
          api_key = "cmd: cat /home/mloeper/.config/sops-nix/secrets/anthropic-api-key"
        },
      })
    end,
    openai = function()
      return require("codecompanion.adapters").extend("openai", {
        env = {
          api_key = "cmd: cat /home/mloeper/.config/sops-nix/secrets/openai-api-key"
        },
      })
    end,
  },
})

vim.keymap.set({ "n", "v" }, "<C-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<Leader>c", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })
vim.cmd([[cab cc CodeCompanion]])
vim.cmd([[cab ccc CodeCompanionChat]])
