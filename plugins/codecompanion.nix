{ pkgs, ... }: {
  plugin = pkgs.vimPlugins.codecompanion-nvim;
  config = ''
    require("codecompanion").setup({
       adapters = {
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
