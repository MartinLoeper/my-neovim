{ pkgs, ... }: {
  plugin = pkgs.vimPlugins.codecompanion-nvim;
  config = ''
    require("codecompanion").setup({
      display = {
        chat = {
          intro_message = "We Vibe-Coding today huh??! Leggo!! AI doing its best 🚀",
          show_settings = true,
          show_token_count = true,
          start_in_insert_mode = true,
        }
      },
      strategies = {
        chat = {
          adapter = "anthropic",
        },
        inline = {
          adapter = "anthropic",
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
  '';
  type = "lua";
}
