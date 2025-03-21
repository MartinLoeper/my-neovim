{ pkgs, ... }: {
  plugin = pkgs.vimPlugins.windows-nvim;
  config = ''
    vim.o.winwidth = 10
    vim.o.winminwidth = 10
    vim.o.equalalways = false

    require('windows').setup({
      autowidth = {
       enable = false,
      },
      ignore = {
        buftype = { "quickfix" },
        filetype = { "NvimTree", "neo-tree", "undotree", "gundo" }
      }
    })

    local function cmd(command)
       return table.concat({ '<Cmd>', command, '<CR>' })
    end

    vim.keymap.set('n', '<C-w>z', cmd 'WindowsMaximize')
    vim.keymap.set('n', '<C-w>_', cmd 'WindowsMaximizeVertically')
    vim.keymap.set('n', '<C-w>|', cmd 'WindowsMaximizeHorizontally')
    vim.keymap.set('n', '<C-w>=', cmd 'WindowsEqualize')
  '';
  type = "lua";
}
