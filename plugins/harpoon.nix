{ pkgs, ... }: {
  plugin = pkgs.vimPlugins.harpoon2;
  config = ''
    local harpoon = require("harpoon")
    harpoon:setup({
      global_settings = {
        -- note: use :w do exit and close
        save_on_toggle = true,
      }
    })

    vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { noremap = true, silent = true })
    vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { noremap = true, silent = true })

    vim.keymap.set("n", "<Leader>j", function() harpoon:list():select(1) end)
    vim.keymap.set("n", "<Leader>k", function() harpoon:list():select(2) end)
    vim.keymap.set("n", "<Leader>l", function() harpoon:list():select(3) end)
    vim.keymap.set("n", "<Leader>;", function() harpoon:list():select(4) end)

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set("n", "<M-j>", function() harpoon:list():prev() end, { noremap = true, silent = true })
    vim.keymap.set("n", "<M-k>", function() harpoon:list():next() end, { noremap = true, silent = true })

    -- highlight the current file in harpoon buffer list
    local harpoon_extensions = require("harpoon.extensions")
    harpoon:extend(harpoon_extensions.builtins.highlight_current_file())
  '';
  type = "lua";
}
