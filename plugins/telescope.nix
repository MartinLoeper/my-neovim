{ pkgs, ... }: {
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
        vim.keymap.set('n', '<leader>fg', function()
          builtin.live_grep({
            additional_args = function() return { "--hidden", "--glob", "!.git/*" } end
          })
          end, { desc = 'Telescope live grep' })
        vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = '[F]ind [B]uffers using Telescope' })
        vim.keymap.set('n', '<leader>fo', builtin.resume, { desc = "[Find] using Telescope [O]thers" })
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[F]ind [H]elp Tags using Telescope' })
        vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = 'Telescope grep current word or selection' })
        vim.keymap.set('n', '<leader>fif', builtin.current_buffer_fuzzy_find, { desc = 'Telescope find in current buffer' })
        vim.keymap.set('n', '<leader>fr', builtin.lsp_references, { desc = 'Telescope find lsp references' })
        vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = 'Telescope find diagnostics' })
        vim.keymap.set('n', '<leader>gd', builtin.lsp_definitions	, { desc = 'Telescope goto definition' })
        vim.keymap.set('n', '<leader>gi', builtin.lsp_implementations, { desc = 'Telescope goto implementation' })
        vim.keymap.set('n', '<leader>gb', builtin.git_branches, { desc = 'Telescope goto [B]ranch' })
        vim.keymap.set('n', '<leader>gw', telescope.extensions.git_worktree.create_git_worktree, { desc = '[G]oto Git Worktree [C]reation' })
        vim.keymap.set('n', '<leader>gc', telescope.extensions.git_worktree.git_worktrees, { desc = '[G]oto Git [W]orktree' })
        vim.keymap.set("n", "<leader>ft", function()
          require("telescope.builtin").live_grep({
            default_text = vim.fn.fnamemodify(vim.fn.expand("%"), ":t"), -- Get the current file name
          })
        end, { desc = "Find all references to [T]his file in the project" })

        telescope.setup {
          pickers = {
            current_buffer_fuzzy_find = {
              fuzzy = false,  -- Disable fuzzy matching
              case_mode = "ignore_case",  -- Options: "ignore_case", "respect_case", "smart_case"
            },
          },
    			extensions = {
    				["ui-select"] = {
    					require("telescope.themes").get_dropdown {
    						-- even more opts
    					}
    				},
            undo = {
              mappings = {
                i = {
                  ["<C-u>"] = require("telescope-undo.actions").restore,
                },
                n = {
                  ["y"] = require("telescope-undo.actions").yank_additions,
                  ["Y"] = require("telescope-undo.actions").yank_deletions,
                  ["u"] = require("telescope-undo.actions").restore,
                },
              },
            },
    			},
        }

        telescope.load_extension("ui-select")
        telescope.load_extension("workspaces")
        telescope.load_extension("yank_history")
        telescope.load_extension("undo")
        telescope.load_extension("git_worktree")
  '';
  type = "lua";
}
