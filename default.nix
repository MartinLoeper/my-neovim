{ pkgs, lib, ... }: {

  # TODO: install nvim
  # TODO: install neovide
  # TODO: install vimPlugins.CopilotChat-nvim OR BETTER: https://github.com/yetone/avante.nvim
  # zbirenbaum/copilot.lua
  # TODO: install vimPlugins.nvim-treesitter
  # TODO: install vimPlugins.nvim-remote-containers
  # TODO: install vimPlugins.nvim-lspconfig
  # TODO: actions-preview.nvim
  # barbecue.nvim + SmiteshP/nvim-navic
  # j-hui/fidget.nvim
  # opt: lewis6991/hover.nvim
  # consider: https://git.sr.ht/~whynothugo/lsp_lines.nvim
  # opt: antosha417/nvim-lsp-file-operations
  # ray-x/lsp_signature.nvim
  # zeioth/garbage-day.nvim
  # chrisgrieser/nvim-dr-lsp
  # soulis-1256/eagle.nvim
  # opt: https://github.com/folke/lazydev.nvim
  # askfiy/lsp_extra_dim
  # nvimdev/lspsaga.nvim
  # filipdutescu/renamer.nvim
  # folke/trouble.nvim
  # try replicate the setup from:
  # https://www.reddit.com/r/neovim/comments/1hyradp/monaspacenvim_mix_and_match_monaspace_fonts_in/
  # esp. monaspace font
  # https://github.com/nvim-neo-tree/neo-tree.nvim
  # folke/todo-comments.nvim
  # ms-jpq/coq_nvim J
  # https://github.com/mistweaverco/kulala.nvim
  # https://github.com/toppair/peek.nvim
  # https://github.com/nvim-telescope/telescope.nvim
  # theme:
  # https://github.com/rafamadriz/neon ????? dark
  # https://github.com/Mofiqul/vscode.nvim ??
  # https://github.com/marko-cerovac/material.nvim Deep ocean
  # https://github.com/nvimdev/dashboard-nvim
  # https://github.com/romgrk/barbar.nvim
  # https://github.com/David-Kunz/jester
  # git support?? https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#git
  # terminal support??
  # https://github.com/pwntester/octo.nvim
  # formatter like https://github.com/lukas-reineke/lsp-format.nvim
  # https://github.com/akinsho/toggleterm.nvim
  # https://github.com/kevinhwang91/nvim-ufo
  # https://github.com/sontungexpt/url-open
  # even more utils: https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#utility
  # https://github.com/sindrets/diffview.nvim
  # opt: https://github.com/p00f/godbolt.nvim
  # TODO: spell checking
  # TODO: fuzzzy search in command mode
  # TODO: make function key work as ctrl when pressed -> use keyd utility
  # TODO: mason as lsp etc manager
  # TODO: bufferline for tabs
  # TODO: minimap.vim
  # TODO: friendly-snippets
  # TODO: vim-indentwise
  # TODO: make diagnostics work for buffers which are not open, see: https://github.com/artemave/workspace-diagnostics.nvim

  home.packages = [
    pkgs.ripgrep
    pkgs.nodejs # requried by copilot plugin
  ];

  home.activation.ensureCacheNvim = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p "$HOME/.cache/nvim"
  '';

  # read about motions: https://www.barbarianmeetscoding.com/boost-your-coding-fu-with-vscode-and-vim/moving-blazingly-fast-with-the-core-vim-motions/
  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
      extraConfig = ''
        set number relativenumber
      '';
      extraLuaConfig = ''
        vim.keymap.set("n", "<Space>", "<Nop>", { silent = true, remap = false })
        vim.g.mapleader = " "

        -- more space for the line numbers
        vim.opt.numberwidth = 6

        -- replaced by nvim-tree-lua
        -- vim.api.nvim_set_keymap('n', '<leader>e', ':Ex<CR>', { noremap = true, silent = true })

        -- zoom in neovide when in neovide
        if vim.g.neovide == true then
          vim.api.nvim_set_keymap("n", "<C-=>", ":lua vim.g.neovide_scale_factor = math.min(vim.g.neovide_scale_factor + 0.1,  2.0)<CR>", { silent = true })
          vim.api.nvim_set_keymap("n", "<C-->", ":lua vim.g.neovide_scale_factor = math.max(vim.g.neovide_scale_factor - 0.1,  0.1)<CR>", { silent = true })
          vim.api.nvim_set_keymap("n", "<C-+>", ":lua vim.g.neovide_transparency = math.min(vim.g.neovide_transparency + 0.05, 1.0)<CR>", { silent = true })
          vim.api.nvim_set_keymap("n", "<C-_>", ":lua vim.g.neovide_transparency = math.max(vim.g.neovide_transparency - 0.05, 0.0)<CR>", { silent = true })
          vim.api.nvim_set_keymap("n", "<C-0>", ":lua vim.g.neovide_scale_factor = 0.5<CR>", { silent = true })
          vim.api.nvim_set_keymap("n", "<C-)>", ":lua vim.g.neovide_transparency = 0.9<CR>", { silent = true })
        end

        vim.api.nvim_set_keymap('n', '<leader>w', ':w<CR>', { noremap = true, silent = true })
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

        -- remap tab to ctrl tab in insert mode
        vim.api.nvim_set_keymap('i', '<C-Tab>', '<Tab>', { noremap = true, silent = true })

        vim.opt.smartindent = true
        vim.opt.autoindent = true

        local cmp = require'cmp'
        local lspkind = require('lspkind')

        -- add copilot symbol
        local lspkind = require("lspkind")
        lspkind.init({
          symbol_map = {
            Copilot = "",
          },
        })
        vim.api.nvim_set_hl(0, "CmpItemKindCopilot", {fg ="#6CC644"})

        local function replace_keys(str)
          return vim.api.nvim_replace_termcodes(str, true, true, true)
        end

        local types = require('cmp.types')

        cmp.setup({
          completion = {
            autocomplete = {
              types.cmp.TriggerEvent.TextChanged,
            },
          },
          formatting = {
            fields = { "kind", "abbr", "menu" },
            format = function(entry, vim_item)
              local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
              local strings = vim.split(kind.kind, "%s", { trimempty = true })
              kind.kind = " " .. (strings[1] or "") .. " "
              kind.menu = "    (" .. (strings[2] or "") .. ")"

              return kind
            end,
          },
          mapping = {
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.abort(),
            ['<CR>'] = cmp.mapping.confirm({ select = false, behavior = cmp.ConfirmBehavior.Replace }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
            ['<Tab>'] = cmp.mapping(function(fallback)
              if vim.call('vsnip#available', 1) ~= 0 then
                vim.fn.feedkeys(replace_keys('<Plug>(vsnip-jump-next)'), ''')
              elseif cmp.visible() then
                cmp.select_next_item()
              else
                fallback()
              end
            end, { 'i', 's' }),
            ['<C-j>'] = cmp.mapping(function(fallback)
              if vim.call('vsnip#available', 1) ~= 0 then
                vim.fn.feedkeys(replace_keys('<Plug>(vsnip-jump-next)'), ''')
              elseif cmp.visible() then
                cmp.select_next_item()
              else
                fallback()
              end
            end, { 'i', 's' }),
            ['<C-k>'] = cmp.mapping(function(fallback)
              if vim.call('vsnip#available', -1) ~= 0 then
                vim.fn.feedkeys(replace_keys('<Plug>(vsnip-jump-prev)'), ''')
              elseif cmp.visible() then
                cmp.select_prev_item()
              else
                fallback()
              end
            end, { 'i', 's' }),
          },
          snippet = {
            -- REQUIRED - you must specify a snippet engine
            expand = function(args)
              vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            end,
          },
          window = {
            -- completion = cmp.config.window.bordered(),
            -- documentation = cmp.config.window.bordered(),
          },
          sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'vsnip' }, -- For vsnip users.
            { name = 'nvim_lsp_signature_help' },
            { name = 'path' },
          }, {
            { name = 'buffer' },
          })
        })

        -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline({ '/', '?' }, {
          mapping = cmp.mapping.preset.cmdline(),
          sources = {
            { name = 'buffer' }
          }
        })

        -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline(':', {
          mapping = cmp.mapping.preset.cmdline(),
          sources = cmp.config.sources({
            { name = 'path' },
            { name = 'cmdline' },
            { name = 'cmdline_history' }
          }),
          matching = { disallow_symbol_nonprefix_matching = false }
        })

        vim.opt.foldmethod = "indent"  -- Use indentation levels for folding
        vim.opt.foldlevel = 99         -- Start with all folds open
        vim.opt.foldenable = true      -- Enable folding
        vim.opt.foldnestmax = 3        -- Maximum nested fold levels

        if vim.fn.filereadable(vim.fn.getcwd() .. "/.editorconfig") == 0 then
          vim.o.tabstop = 2 
          vim.o.shiftwidth = 2
          vim.o.expandtab = true  -- Converts tabs to spaces
        end
      '';
      plugins = [
        (import ./plugins/zen-mode.nix { inherit pkgs; })
        (import ./plugins/unimpaired.nix { inherit pkgs; })
        (import ./plugins/lspkind.nix { inherit pkgs; })
        (import ./plugins/fugative.nix { inherit pkgs; })
        (import ./plugins/cmp/cmp-cmdline.nix { inherit pkgs; })
        (import ./plugins/cmp/cmp-cmdline-history.nix { inherit pkgs; })
        (import ./plugins/cmp/cmp-lsp-signature-help.nix { inherit pkgs; })
        (import ./plugins/cmp/cmp-buffer.nix { inherit pkgs; })
        (import ./plugins/cmp/cmp-path.nix { inherit pkgs; })
        (import ./plugins/lualine/lualine-lsp-progress.nix { inherit pkgs; })
        (import ./plugins/which-key.nix { inherit pkgs; })
        (import ./plugins/twilight.nix { inherit pkgs; })
        (import ./plugins/catppuccin.nix { inherit pkgs; })
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
        (import ./plugins/lualine/copilot-lualine.nix { inherit pkgs; })
        (import ./plugins/todo-comments.nix { inherit pkgs; })
        (import ./plugins/copilot.nix { inherit pkgs; })
        (import ./plugins/autosave.nix { inherit pkgs; })
        (import ./plugins/telescope-ui-select.nix { inherit pkgs; })
        (import ./plugins/telescope.nix { inherit pkgs; })
        (import ./plugins/fidget.nix { inherit pkgs; })
        (import ./plugins/harpoon.nix { inherit pkgs; })
        (import ./plugins/treesitter.nix { inherit pkgs; })
        (import ./plugins/treesitter-textobjects.nix { inherit pkgs; })
        (import ./plugins/treesitter-textsubjects.nix { inherit pkgs; })
        {
          plugin = pkgs.vimPlugins.gitsigns-nvim;
          config = ''
            require('gitsigns').setup{
              current_line_blame = true,
              numhl = true,
              on_attach = function(bufnr)
                local gitsigns = require('gitsigns')

                local function map(mode, l, r, opts)
                  opts = opts or {}
                  opts.buffer = bufnr
                  vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation
                map('n', ']c', function()
                  if vim.wo.diff then
                    vim.cmd.normal({']c', bang = true})
                  else
                    gitsigns.nav_hunk('next')
                  end
                end)

                map('n', '[c', function()
                  if vim.wo.diff then
                    vim.cmd.normal({'[c', bang = true})
                  else
                    gitsigns.nav_hunk('prev')
                  end
                end)

                -- Actions
                map('n', '<leader>hs', gitsigns.stage_hunk)
                map('n', '<leader>hr', gitsigns.reset_hunk)

                map('v', '<leader>hs', function()
                  gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
                end)

                map('v', '<leader>hr', function()
                  gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
                end)

                map('n', '<leader>hS', gitsigns.stage_buffer)
                map('n', '<leader>hR', gitsigns.reset_buffer)
                map('n', '<leader>hp', gitsigns.preview_hunk)
                map('n', '<leader>hi', gitsigns.preview_hunk_inline)

                map('n', '<leader>hb', function()
                  gitsigns.blame_line({ full = true })
                end)

                map('n', '<leader>hd', gitsigns.diffthis)

                map('n', '<leader>hD', function()
                  gitsigns.diffthis('~')
                end)

                map('n', '<leader>hQ', function() gitsigns.setqflist('all') end)
                map('n', '<leader>hq', gitsigns.setqflist)

                -- Toggles
                map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
                map('n', '<leader>td', gitsigns.toggle_deleted)
                map('n', '<leader>tw', gitsigns.toggle_word_diff)

                -- Text object
                map({'o', 'x'}, 'ih', gitsigns.select_hunk)
              end
            }
          '';
          type = "lua";
        }
        pkgs.vimPlugins.yazi-nvim
        pkgs.vimPlugins.nvim-notify
        {
          plugin = pkgs.vimPlugins.indent-blankline-nvim;
          config = ''
            require("ibl").setup()
          '';
          type = "lua";
        }
        {
          plugin = pkgs.vimPlugins.bufferline-nvim;
          config = ''
            vim.opt.termguicolors = true
            require("bufferline").setup{
              highlights = require("catppuccin.groups.integrations.bufferline").get(),
              options = {
                diagnostics = "nvim_lsp",
                offsets = {
                  {
                      filetype = "NvimTree",
                      text = "File Explorer",
                      highlight = "Directory",
                      separator = true -- use a "true" to enable the default, or set your own character
                  }
                }
              }
            }
          '';
          type = "lua";
        }
        {
          # note: use gq{motion} to format buffer content -> sometimes not working...
          # saving always works if the formatter is set below...
          plugin = pkgs.vimPlugins.conform-nvim;
          config = ''
            require("conform").setup({
              formatters_by_ft = {
                terraform = { "terraform_fmt" },
                nix = { "nixfmt" }
              },
              format_on_save = {
                timeout_ms = 500,
                lsp_format = "fallback",
              },
            })
          '';
          type = "lua";
        }
        {
          plugin = pkgs.vimPlugins.nvim-lsp-notify;
          config = ''
            require('lsp-notify').setup({
              notify = require('notify'),
            })
          '';
          type = "lua";
        }
        {
          plugin = pkgs.vimPlugins.zellij-nav-nvim;
          config = ''
            require("zellij-nav").setup()

            vim.keymap.set("n", "<c-h>", "<cmd>ZellijNavigateLeftTab<cr>",  { desc = "navigate left or tab"  })
            vim.keymap.set("n", "<c-j>", "<cmd>ZellijNavigateDown<cr>",  { desc = "navigate down" })
            vim.keymap.set("n", "<c-k>", "<cmd>ZellijNavigateUp<cr>",    { desc = "navigate up" })
            vim.keymap.set("n", "<c-l>", "<cmd>ZellijNavigateRightTab<cr>", { desc = "navigate right or tab" })
          '';
          type = "lua";
        }
        {
          plugin = pkgs.vimPlugins.remote-nvim-nvim;
          config = ''
            require("remote-nvim").setup()
          '';
          type = "lua";
        }
        {
          plugin = pkgs.vimPlugins.nvim-tree-lua;
          config = ''
                require("nvim-tree").setup({
                  sort = {
                    sorter = "case_sensitive",
                  },
                  view = {
                    width = 30,
                  },
                  renderer = {
                    group_empty = true,
                  },
                  filters = {
                    dotfiles = false,
                  },
                  update_focused_file = {
                    enable = true,         -- Enable automatic focusing
                    update_cwd = true,     -- Update the current working directory to match the file
                    ignore_list = {}       -- Files to ignore
            },
                })
                vim.api.nvim_set_keymap('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
          '';
          type = "lua";
        }
        (import ./plugins/neominimap.nix {
          lua = pkgs.lua;
          fetchFromGitHub = pkgs.fetchFromGitHub;
          neovimUtils = pkgs.neovimUtils;
        })
        # unfortunately blocked by: https://github.com/gbprod/yanky.nvim/issues/213
        # {
        #   plugin = pkgs.vimPlugins.yanky-nvim;
        #   config = ''
        #     require("yanky").setup{
        #       ring = {
        #         history_length = 100,
        #         storage = "shada",
        #         sync_with_numbered_registers = true,
        #         cancel_event = "update",
        #         ignore_registers = { "_" },
        #         update_register_on_cycle = false,
        #         permanent_wrapper = nil,
        #       },
        #       system_clipboard = {
        #         sync_with_ring = true,
        #       },
        #       ring = {
        #         ignore_registers = { "_", "+", "*" },
        #       },
        #       highlight = {
        #         on_put = true,
        #         on_yank = true,
        #         timer = 300,
        #       },
        #     }
        #     require("telescope").load_extension("yank_history")
        #
        #     vim.keymap.set({"n","x"}, "p", "<Plug>(YankyPutAfter)")
        #     vim.keymap.set({"n","x"}, "P", "<Plug>(YankyPutBefore)")
        #     vim.keymap.set({"n","x"}, "gp", "<Plug>(YankyGPutAfter)")
        #     vim.keymap.set({"n","x"}, "gP", "<Plug>(YankyGPutBefore)")
        #
        #     vim.keymap.set("n", "<M-p>", "<Plug>(YankyPreviousEntry)")
        #     vim.keymap.set("n", "<leader>fy", function()
        #       require("telescope").extensions.yank_history.yank_history()
        #     end, { noremap = true, silent = true, desc = "Open Yank History with Telescope" })
        #   '';
        #   type = "lua";
        # }
        {
          plugin = pkgs.vimPlugins.nvim-web-devicons;
          config = ''
            require'nvim-web-devicons'.setup()
          '';
          type = "lua";
        }
        {
          plugin = pkgs.vimPlugins.lspsaga-nvim;
          config = ''
            require('lspsaga').setup({
              lightbulb = {
                enable = false, -- Disable the light bulb feature
              },
            })
          '';
          type = "lua";
        }
        pkgs.vimPlugins.cmp-nvim-lsp
        { plugin = pkgs.vimPlugins.cmp-vsnip; }
        pkgs.vimPlugins.vim-vsnip
        pkgs.vimPlugins.vim-vsnip-integ
        # pkgs.vimPlugins.ultisnips
        { plugin = pkgs.vimPlugins.nvim-cmp; }
        (import ./plugins/navbuddy.nix { inherit pkgs; })
        (import ./plugins/lualine/lualine.nix { inherit pkgs; })
        (import ./plugins/leetcode.nix { inherit pkgs; })
        (import ./plugins/lazygit.nix { inherit pkgs; })
        (import ./plugins/comment.nix { inherit pkgs; })
        (import ./plugins/noice.nix { inherit pkgs; })
        (import ./plugins/lspconfig.nix { inherit pkgs; })
        (import ./plugins/codecompanion.nix { inherit pkgs; })
        (import ./plugins/render-markdown.nix { inherit pkgs; })
        pkgs.vimPlugins.nui-nvim # leetcode dep
        pkgs.vimPlugins.plenary-nvim # leetcode dep
        {
          plugin = pkgs.vimPlugins.telescope-lsp-handlers-nvim;
          config = ''
            require('telescope').load_extension('lsp_handlers')

            vim.api.nvim_set_keymap('n', '<leader>fc', '<cmd>lua vim.lsp.buf.code_action()<CR>', { noremap = true, silent = true })
          '';
          type = "lua";
        }
        {
          plugin = pkgs.vimPlugins.vim-startify;
          config = "let g:startify_change_to_vcs_root = 0";
        }
      ];
    };
  };
}

