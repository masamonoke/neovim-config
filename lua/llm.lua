require("codecompanion").setup({
  strategies = {
    chat = {
      adapter = "ollama",
    },
    inline = {
      adapter = "ollama",
    },
    cmd = {
      adapter = "ollama",
    },
  },
  adapters = {
    ollama = function()
      return require("codecompanion.adapters").extend("ollama", {
        schema = {
          model = {
            default = "qwen3.8:27b",
          },
          num_ctx = {
            default = 32768,
          },
        },
      })
    end,
  },
  prompt_library = {
    ["Code Review"] = {
      strategy = "chat",
      description = "Review current changes against HEAD",

      opts = {
        short_name = "review",
        auto_submit = false,
      },

      prompts = {
        {
          role = "user",

          content = function()
            local result = vim.system({
              "git",
              "--no-pager",
              "diff",
              "--no-ext-diff",
              "--no-textconv",
              "--unified=5",
              "HEAD",
              "--",
            }, {
              cwd = vim.fn.getcwd(),
              text = true,
            }):wait()

            if result.code ~= 0 then
              error(
                "Cannot collect git diff:\n"
                .. (result.stderr or "Unknown Git error")
              )
            end

            local diff = result.stdout or ""

            if not diff:find("%S") then
              return [[
No tracked changes against HEAD were found.
Tell me there is nothing to review in this scope.
Do not invent findings.
]]
            end

            return [[
Act as a careful senior code reviewer.

Review the Git diff below for actionable defects introduced by
these changes.

<git_diff>
]] .. diff .. "\n</git_diff>"
          end,
        },
      },
    },
  },
})
