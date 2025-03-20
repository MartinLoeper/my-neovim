{ pkgs, ... }: {
  # INFO: primagen apparently abandoned his plugin, so we use a fork
  plugin = (pkgs.vimPlugins.git-worktree-nvim.overrideAttrs (oldAttrs: {
    src = pkgs.fetchFromGitHub {
      owner = "polarmutex";
      repo = "git-worktree.nvim";
      rev = "3ad8c17a3d178ac19be925284389c14114638ebb";
      sha256 = "sha256-fnqJqQTNei+8Gk4vZ2hjRj8iHBXTZT15xp9FvhGB+BQ=";
    };
  }));
  config = ''
    local Hooks = require("git-worktree.hooks")
    local config = require('git-worktree.config')
    local update_on_switch = Hooks.builtins.update_current_buffer_on_switch

    Hooks.register(Hooks.type.SWITCH, function (path, prev_path)
      vim.notify("Moved from " .. prev_path .. " to " .. path)
      update_on_switch(path, prev_path)
    end)

    Hooks.register(Hooks.type.DELETE, function ()
      vim.cmd(config.update_on_change_command)
    end)
  '';
  type = "lua";
}
