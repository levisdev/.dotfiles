return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = {
      {
        "<leader>E",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = LazyVim.root() })
        end,
        desc = "Explorer NeoTree (Root Dir)",
      },
      {
        "<leader>e",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
        end,
        desc = "Explorer NeoTree (cwd)",
      },
    },
    opts = {
      auto_clean_after_session_restore = true,
      hide_root_node = true,
      default_component_configs = {
        file_size = {
          enabled = false,
        },
        type = {
          enabled = false,
        },
        last_modified = {
          enabled = false,
        },
      },
      window = {
        width = 25,
        mappings = {
          ["l"] = "open",
          ["h"] = "close_node",
        },
      },
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_hidden = false,
          hide_by_name = {
            "node_modules",
          },
          hide_by_pattern = {
            "*.exe",
          },
        },
      },
    },
  },

  {
    "CRAG666/code_runner.nvim",
    keys = {
      { "<C-b>", "<Cmd>RunCode<Cr>", desc = "Code Runner" },
    },
    opts = {
      mode = "float",
      startinsert = true,
      float = {
        border = "rounded",
      },
    },
  },
}
