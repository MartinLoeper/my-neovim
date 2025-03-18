{ pkgs, ... }: {
  plugin = pkgs.vimPlugins.fidget-nvim;
  config = ''
    require("fidget").setup {
      progress = {
        poll_rate = 0,                -- How and when to poll for progress messages
        suppress_on_insert = false,   -- Suppress new messages while in insert mode
        ignore_done_already = false,  -- Ignore new tasks that are already complete
        ignore_empty_message = false, -- Ignore new tasks that don't contain a message
        clear_on_detach =             -- Clear notification group when LSP server detaches
          function(client_id)
            local client = vim.lsp.get_client_by_id(client_id)
            return client and client.name or nil
          end,
        notification_group =          -- How to get a progress message's notification group key
          function(msg) return msg.lsp_client.name end,
        ignore = {},                  -- List of LSP servers to ignore

        -- Options related to how LSP progress messages are displayed as notifications
        display = {
          render_limit = 16,          -- How many LSP messages to show at once
          done_ttl = 3,               -- How long a message should persist after completion
          done_icon = "✔",            -- Icon shown when all LSP progress tasks are complete
          done_style = "Constant",    -- Highlight group for completed LSP tasks
          progress_ttl = math.huge,   -- How long a message should persist when in progress
          progress_icon =             -- Icon shown when LSP progress tasks are in progress
            { "dots" },
          progress_style =            -- Highlight group for in-progress LSP tasks
            "WarningMsg",
          group_style = "Title",      -- Highlight group for group name (LSP server name)
          icon_style = "Question",    -- Highlight group for group icons
          priority = 30,              -- Ordering priority for LSP notification group
          skip_history = true,        -- Whether progress notifications should be omitted from history
          format_message =            -- How to format a progress message
            require("fidget.progress.display").default_format_message,
          format_annote =             -- How to format a progress annotation
            function(msg) return msg.title end,
          format_group_name =         -- How to format a progress notification group's name
            function(group) return tostring(group) end,
          overrides = {               -- Override options from the default notification config
            rust_analyzer = { name = "rust-analyzer" },
          },
        },

        -- Options related to Neovim's built-in LSP client
        lsp = {
          progress_ringbuf_size = 0,  -- Configure the nvim's LSP progress ring buffer size
          log_handler = false,        -- Log `$/progress` handler invocations (for debugging)
        },
      },
      notification = {
        override_vim_notify = true,
        window = {
          winblend = 0,
        },
      }
    }

    -- hide the cmd bar at the bottom
    -- noice does the same when it is in charge for handling messages
    vim.opt.cmdheight = 0
    vim.opt.laststatus = 0
  '';
  type = "lua";
}
