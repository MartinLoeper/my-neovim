{ pkgs, ... }: {
  plugin = pkgs.vimPlugins.toggleterm-nvim;
  config = ''
    require("toggleterm").setup({
      open_mapping = [[<c-\>]]
    })

    local trim_spaces = true
    vim.keymap.set("v", "<space>ss", function()
        require("toggleterm").send_lines_to_terminal("single_line", trim_spaces, { args = vim.v.count })
    end)

    function _G.set_terminal_keymaps()
      local opts = {buffer = 0}
      vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
    end

    vim.cmd('autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()')
  '';
  type = "lua";
}

