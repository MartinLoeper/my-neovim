{ pkgs, lib, ... }: {

  imports = [
    ./plugins/lsp/jsonls.nix
    ./plugins/lsp/luals.nix
    ./plugins/lsp/javals.nix
    ./plugins/lsp/markdownls.nix
  ];

  home.packages = [
    pkgs.ripgrep
    pkgs.nodejs # requried by copilot plugin
  ];

  home.activation.ensureCacheNvim = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p "$HOME/.cache/nvim"
  '';

  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
      extraLuaConfig = ''
        vim.opt.relativenumber = true
        vim.keymap.set("n", "<Space>", "<Nop>", { silent = true, remap = false })
        vim.g.mapleader = " "

        -- configure clipboard s.t. yanky can access it
        vim.opt.clipboard = "unnamed,unnamedplus"

        -- more space for the line numbers
        vim.opt.numberwidth = 6

        vim.keymap.set('n', '<leader>w', vim.cmd.write, { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', '<leader>q', ':q<CR>', { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', '<leader>sh', ':split<CR>', { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', '<leader>sv', ':vsplit<CR>', { noremap = true, silent = true })

        vim.keymap.set('n', '<leader>to', ':tabonly<CR>', { noremap = true, silent = true }) -- Close all other tabs
        vim.keymap.set('n', '<leader>tc', ':tabclose<CR>', { noremap = true, silent = true }) -- Close current tab
        vim.keymap.set('n', '<leader>tp', ':tabp<CR>', { noremap = true, silent = true })    -- Previous tab
        vim.keymap.set('n', '<leader>tn', ':tabn<CR>', { noremap = true, silent = true })    -- Next tab

        vim.keymap.set('n', '<leader>tf', function()
          local cwd = vim.loop.cwd() -- Get the current working directory
          vim.cmd("!zellij run -x " .. vim.fn.shellescape("50%", 1) .. " --width " .. vim.fn.shellescape("50%", 1) .. " -y " .. vim.fn.shellescape("40%", 1) .. " --height " .. vim.fn.shellescape("60%", 1) .. string.format(" -n 'Terminal: [%s]' -f -c --cwd '%s' -- zsh", cwd, cwd))
        end, { noremap = true, silent = true })

        vim.keymap.set('n', '<Alt-f>', function() vim.cmd("!zellij action toggle-floating-panes") end)
        vim.keymap.set('n', '<Leader>tt', function()
            local cwd = vim.loop.cwd() -- Get the current working directory
            vim.cmd(string.format("!zellij action new-tab -l default -c %s",  cwd))
          end, { noremap = true, silent = true })
        -- format whole file
        vim.api.nvim_set_keymap('n', '<Leader>gq', 'gggqG', { noremap = true, silent = true })

        -- make goto definition use lsp
        vim.api.nvim_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { noremap = true, silent = true })
        -- we use telescope for goto definition
        --vim.api.nvim_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })

        -- fill location list with lsp diagnostics
        vim.api.nvim_set_keymap("n", "<leader>dq", "<cmd>lua vim.diagnostic.setloclist()<CR>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", "<leader>dn", "<cmd>lua vim.diagnostic.goto_next()<CR>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", "<leader>dp", "<cmd>lua vim.diagnostic.goto_prev()<CR>", { noremap = true, silent = true })

        -- open file chooser
        vim.keymap.set("n", "<leader>-", function()
          require("yazi").yazi()
        end)

        vim.opt.smartindent = true
        vim.opt.autoindent = true

        vim.opt.foldmethod = "indent"  -- Use indentation levels for folding
        vim.opt.foldlevel = 99         -- Start with all folds open
        vim.opt.foldenable = true      -- Enable folding
        vim.opt.foldnestmax = 3        -- Maximum nested fold levels

        -- we set sensible defaults if there is no .editorconfig file
        vim.api.nvim_create_autocmd("BufEnter", {
          pattern = "*",
          callback = function()
            if vim.fn.filereadable(vim.fn.getcwd() .. "/.editorconfig") == 0 then
              vim.o.tabstop = 2
              vim.o.shiftwidth = 2
              vim.o.expandtab = true  -- Converts tabs to spaces
            end
          end
        })

        vim.opt.cursorline = true
      '';
      plugins = [
        (import ./plugins/web-devicons.nix { inherit pkgs; })
        (import ./plugins/nvim-tree/nvim-tree.nix { inherit pkgs; })
        (import ./plugins/zen-mode.nix { inherit pkgs; })
        (import ./plugins/unimpaired.nix { inherit pkgs; })
        (import ./plugins/lspkind.nix { inherit pkgs; })
        (import ./plugins/git/fugative.nix { inherit pkgs; })
        (import ./plugins/git/neogit.nix { inherit pkgs; })
        (import ./plugins/cmp/cmp-cmdline.nix { inherit pkgs; })
        (import ./plugins/cmp/cmp-cmdline-history.nix { inherit pkgs; })
        (import ./plugins/cmp/cmp-buffer.nix { inherit pkgs; })
        (import ./plugins/cmp/cmp-path.nix { inherit pkgs; })
        (import ./plugins/which-key.nix { inherit pkgs; })
        (import ./plugins/twilight.nix { inherit pkgs; })
        (import ./plugins/catppuccin.nix { inherit pkgs; })
        (import ./plugins/windows.nix { inherit pkgs; })
        (import ./plugins/beacon.nix {
          lua = pkgs.lua;
          fetchFromGitHub = pkgs.fetchFromGitHub;
          neovimUtils = pkgs.neovimUtils;
        })
        (import ./plugins/lualine/lualine-codecompanion.nix {
          lua = pkgs.lua;
          fetchFromGitHub = pkgs.fetchFromGitHub;
          neovimUtils = pkgs.neovimUtils;
        })
        (import ./plugins/workspaces.nix {
          lua = pkgs.lua;
          fetchFromGitHub = pkgs.fetchFromGitHub;
          neovimUtils = pkgs.neovimUtils;
        })
        (import ./plugins/sessions.nix {
          lua = pkgs.lua;
          fetchFromGitHub = pkgs.fetchFromGitHub;
          neovimUtils = pkgs.neovimUtils;
        })
        (import ./plugins/lualine/copilot-lualine.nix { inherit pkgs; })
        (import ./plugins/todo-comments.nix { inherit pkgs; })
        (import ./plugins/copilot.nix { inherit pkgs; })
        (import ./plugins/yanky.nix { inherit pkgs; })
        (import ./plugins/telescope-ui-select.nix { inherit pkgs; })
        (import ./plugins/telescope.nix { inherit pkgs; })
        (import ./plugins/fidget.nix { inherit pkgs; })
        (import ./plugins/harpoon.nix { inherit pkgs; })
        (import ./plugins/surround.nix { inherit pkgs; })
        (import ./plugins/treesitter.nix { inherit pkgs; })
        (import ./plugins/treesitter-textobjects.nix { inherit pkgs; })
        (import ./plugins/treesitter-textsubjects.nix { inherit pkgs; })
        (import ./plugins/toggleterm.nix { inherit pkgs; })
        (import ./plugins/competitest.nix { inherit pkgs; })
        (import ./plugins/git/gitsigns.nix { inherit pkgs; })
        (import ./plugins/indent-blankline.nix { inherit pkgs; })
        (import ./plugins/yazi.nix { inherit pkgs; })
        (import ./plugins/bufferline.nix { inherit pkgs; })
        (import ./plugins/conform.nix { inherit pkgs; })
        (import ./plugins/zellij.nix { inherit pkgs; })
        (import ./plugins/lspsaga.nix { inherit pkgs; })
        (import ./plugins/cmp/cmp-nvim-lsp.nix { inherit pkgs; })
        (import ./plugins/neominimap.nix {
          lua = pkgs.lua;
          fetchFromGitHub = pkgs.fetchFromGitHub;
          neovimUtils = pkgs.neovimUtils;
        })
        (import ./plugins/cmp/cmp-vsnip.nix { inherit pkgs; })
        (import ./plugins/cmp/vim-vsnip.nix { inherit pkgs; })
        (import ./plugins/cmp/vim-vsnip-integ.nix { inherit pkgs; })
        (import ./plugins/cmp/cmp.nix { inherit pkgs; })
        (import ./plugins/outline.nix { inherit pkgs; })
        (import ./plugins/lualine/lualine.nix { inherit pkgs; })
        (import ./plugins/lazygit.nix { inherit pkgs; })
        (import ./plugins/comment.nix { inherit pkgs; })
        (import ./plugins/noice.nix { inherit pkgs; })
        (import ./plugins/lsp/lspconfig.nix { inherit pkgs; })
        (import ./plugins/codecompanion/codecompanion.nix { inherit pkgs; })
        (import ./plugins/render-markdown.nix { inherit pkgs; })
        (import ./plugins/telescope-lsp-handlers.nix { inherit pkgs; })
        (import ./plugins/startify.nix { inherit pkgs; })
        (import ./plugins/cmp/friendly-snippets.nix { inherit pkgs; })
        (import ./plugins/overseer.nix { inherit pkgs; })
        (import ./plugins/direnv.nix { inherit pkgs; })

        pkgs.vimPlugins.nui-nvim # leetcode dep
        pkgs.vimPlugins.plenary-nvim # leetcode dep
        (import ./plugins/leetcode.nix { inherit pkgs; })
      ];
    };
  };
}

