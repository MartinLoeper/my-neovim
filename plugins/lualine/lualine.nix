{ pkgs, ... }: {
  plugin = pkgs.vimPlugins.lualine-nvim;
  config = ''
    		local mode = {
    			"mode",
    			fmt = function(s)
    				local mode_map = {
    					["NORMAL"] = "N",
    					["O-PENDING"] = "N?",
    					["INSERT"] = "I",
    					["VISUAL"] = "V",
    					["V-BLOCK"] = "VB",
    					["V-LINE"] = "VL",
    					["V-REPLACE"] = "VR",
    					["REPLACE"] = "R",
    					["COMMAND"] = "!",
    					["SHELL"] = "SH",
    					["TERMINAL"] = "T",
    					["EX"] = "X",
    					["S-BLOCK"] = "SB",
    					["S-LINE"] = "SL",
    					["SELECT"] = "S",
    					["CONFIRM"] = "Y?",
    					["MORE"] = "M",
    				}
    				return mode_map[s] or s
    			end,
    		}

    		local function codecompanion_adapter_name()
    			local chat = require("codecompanion").buf_get_chat(vim.api.nvim_get_current_buf())
    			if not chat then
    				return nil
    			end

    			return " " .. chat.adapter.formatted_name
    		end

    		local function codecompanion_current_model_name()
    			local chat = require("codecompanion").buf_get_chat(vim.api.nvim_get_current_buf())
    			if not chat then
    				return nil
    			end

    			return chat.settings.model
    		end

        require('lualine').setup {
          sections = {
            lualine_f = { 'filename' },
            lualine_p = {
              'lsp_progress'
            },
            lualine_x = { 'copilot' ,'encoding', 'fileformat', 'filetype' },
          },
          disabled_filetypes = {
            'NvimTree', 'NvimTree_1'
          },
          extensions = {
            {
              filetypes = { "codecompanion" },
              sections = {
                lualine_a = {
                  mode,
                },
                lualine_b = {
                  codecompanion_adapter_name,
                },
                lualine_c = {
                  codecompanion_current_model_name,
                },
                lualine_x = {},
                lualine_y = {
                  require('lualine-codecompanion')
                },
                lualine_z = {
                  "location",
                },
              },
            },
          },
        }
  '';
  type = "lua";
}
