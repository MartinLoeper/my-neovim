{ pkgs, ... }: {
  plugin = pkgs.vimPlugins.codecompanion-nvim;
  config = ''
    require("codecompanion").setup({
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
  '';
  type = "lua";
}
