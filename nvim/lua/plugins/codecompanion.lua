return {
  "olimorris/codecompanion.nvim",

  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "j-hui/fidget.nvim",
  },

  opts = {
    adapters = {
      acp = {
        claude_code = function()
          return require("codecompanion.adapters").extend("claude_code", {
            env = {
              CLAUDE_CODE_OAUTH_TOKEN = "CLAUDE_CODE_OAUTH_TOKEN",
            },
          })
        end,
      },
    },

    strategies = {
      chat = {
        adapter = "claude_code",
      },
      inline = {
        adapter = "claude_code",
      },
      cmd = {
        adapter = "claude_code",
      }
    },

    opts = {
      log_level = "DEBUG",
    },
  },

  init = function()
    require("plugins.codecompanion.fidget-spinner"):init()
  end,
};
