{ pkgs, ... }: {
  home.username = "vscode";
  home.homeDirectory = "/home/vscode";
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

        vim.keymap.set('n', '<leader>z', function()
          local cwd = vim.loop.cwd() -- Get the current working directory
          vim.cmd("!zellij run -x " .. vim.fn.shellescape("50%", 1) .. " --width " .. vim.fn.shellescape("50%", 1) .. " -y " .. vim.fn.shellescape("40%", 1) .. " --height " .. vim.fn.shellescape("60%", 1) .. string.format(" -n 'Terminal: [%s]' -f -c --cwd '%s' -- zsh", cwd, cwd))
        end, { noremap = true, silent = true })

        vim.keymap.set('n', '<Alt-f>', function() vim.cmd("!zellij action toggle-floating-panes") end)

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
            ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
            ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.abort(),
            ['<CR>'] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
            ['<Tab>'] = cmp.mapping(function(fallback)
              if vim.call('vsnip#available', 1) ~= 0 then
                vim.fn.feedkeys(replace_keys('<Plug>(vsnip-jump-next)'), ''')
              elseif cmp.visible() then
                cmp.select_next_item()
              else
                fallback()
              end
            end, { 'i', 's' }),
            ['<S-Tab>'] = cmp.mapping(function(fallback)
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
              -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
              -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
              -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
              -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
            end,
          },
          window = {
            -- completion = cmp.config.window.bordered(),
            -- documentation = cmp.config.window.bordered(),
          },
          sources = cmp.config.sources({
            { name = "copilot", group_index = 2 },
            { name = 'nvim_lsp' },
            { name = 'vsnip' }, -- For vsnip users.
            { name = 'nvim_lsp_signature_help' },
            -- { name = 'luasnip' }, -- For luasnip users.
            -- { name = 'ultisnips' }, -- For ultisnips users.
            -- { name = 'snippy' }, -- For snippy users.
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
      '';
      plugins = [
        pkgs.vimPlugins.lspkind-nvim
        pkgs.vimPlugins.cmp-cmdline
        pkgs.vimPlugins.cmp-cmdline-history
        pkgs.vimPlugins.cmp-nvim-lsp-signature-help
        pkgs.vimPlugins.cmp-buffer
        pkgs.vimPlugins.lualine-lsp-progress
        pkgs.vimPlugins.which-key-nvim
        pkgs.vimPlugins.vim-gitgutter
        pkgs.vimPlugins.yazi-nvim
        pkgs.vimPlugins.nvim-notify
        {
          plugin = pkgs.vimPlugins.harpoon2;
          config = ''
            local harpoon = require("harpoon")
            harpoon:setup()

            vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { noremap = true, silent = true })
            vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { noremap = true, silent = true })

            -- vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
            -- vim.keymap.set("n", "<C-t>", function() harpoon:list():select(2) end)
            -- vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end)
            -- vim.keymap.set("n", "<C-s>", function() harpoon:list():select(4) end)

            -- Toggle previous & next buffers stored within Harpoon list
            vim.keymap.set("n", "<C-P>", function() harpoon:list():prev() end, { noremap = true, silent = true })
            vim.keymap.set("n", "<C-N>", function() harpoon:list():next() end, { noremap = true, silent = true })
          '';
          type = "lua";
        }
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
          plugin = pkgs.vimPlugins.copilot-lua;
          config = ''
            require("copilot").setup({
              suggestion = { 
                enabled = true, 
                auto_trigger = true,
                keymap = {
                  accept = "<M-l>",
                  accept_word = "<M-Tab>",
                },
              },
              panel = { enabled = true, auto_refresh = true },
            })

            -- make the suggestions italic s.t. the monaspace handwritten font is used
            -- see pending issue: https://github.com/zbirenbaum/copilot.lua/issues/324
            vim.api.nvim_set_hl(0, "CopilotSuggestion", { fg = "#555555", italic = true })
          '';
          type = "lua";
        }
        {
          plugin = pkgs.vimPlugins.copilot-cmp;
          config = ''
            require("copilot_cmp").setup()
          '';
          type = "lua";
        }
        pkgs.vimPlugins.copilot-lualine
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
        {
          plugin = pkgs.vimPlugins.nvim-treesitter.withAllGrammars;
          config = ''
            require'nvim-treesitter.configs'.setup {
              sync_install = false,
              auto_install = false,

              highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
              }
            }'';
          type = "lua";
        }
        pkgs.vimPlugins.minimap-vim
        {
          plugin = pkgs.vimPlugins.nvim-lspconfig;
          config = ''
            local nvim_lsp = require('lspconfig')

            -- nvim-cmp supports additional completion capabilities
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
            local navbuddy = require("nvim-navbuddy")

            local servers = { 'terraformls', 'gopls', 'hyprls', 'nil_ls' }
            for _, lsp in ipairs(servers) do
              nvim_lsp[lsp].setup {
                capabilities = capabilities,
                on_attach = function(client, bufnr)                    
                  navbuddy.attach(client, bufnr)
                end
              }
            end

            local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
            function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
              opts = opts or {}
              opts.border = opts.border or border
              return orig_util_open_floating_preview(contents, syntax, opts, ...)
            end
          '';
          type = "lua";
        }
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
        {
          plugin = pkgs.vimPlugins.telescope-nvim;
          config = ''
            local telescope = require('telescope')
            local builtin = require('telescope.builtin')
            local utils = require('telescope.utils')

            _G.project_files = function()
                local _, ret, _ = utils.get_os_command_output({ 'git', 'rev-parse', '--is-inside-work-tree' }) 
                if ret == 0 then 
                    builtin.git_files() 
                else
                    builtin.find_files()
                end 
            end 

            vim.keymap.set('n', '<leader>fa', ':lua require"telescope.builtin".find_files({ hidden = true })<CR>', {noremap=true})
            vim.keymap.set('n', '<leader>ff', '<cmd>lua project_files()<CR>', {noremap=true})
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
            vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
            vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
            vim.keymap.set('n', '<leader>fh', builtin.man_pages, { desc = 'Telescope man pages' })
            vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = 'Telescope grep current word or selection' })
            vim.keymap.set('n', '<leader>fif', builtin.current_buffer_fuzzy_find, { desc = 'Telescope find in current buffer' })
            vim.keymap.set('n', '<leader>fr', builtin.lsp_references, { desc = 'Telescope find lsp references' })
            vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = 'Telescope find diagnostics' })
            vim.keymap.set('n', '<leader>gd', builtin.lsp_definitions	, { desc = 'Telescope goto definition' })
            vim.keymap.set('n', '<leader>gi', builtin.lsp_implementations, { desc = 'Telescope goto implementation' })

            vim.keymap.set('i', '<C-v>', '<cmd>Copilot panel<CR>', {noremap=true})

            telescope.setup {
              pickers = {
                current_buffer_fuzzy_find = {
                  fuzzy = false,  -- Disable fuzzy matching
                  case_mode = "ignore_case",  -- Options: "ignore_case", "respect_case", "smart_case"
                },
              },
            }
          '';
          type = "lua";
        }
        (import ./plugins/navbuddy.nix { inherit pkgs; })
        (import ./plugins/gruvbox.nix { inherit pkgs; })
        (import ./plugins/lualine.nix { inherit pkgs; })
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
        {
          plugin = pkgs.callPackage ./plugins/monaspace.nix { };
          config = ''
            require('monaspace').setup()
          '';
          type = "lua";
        }
      ];
    };
  };
}

