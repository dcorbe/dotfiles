-- blink.cmp (completion) - replaces the nvim-cmp stack.
-- LSP capabilities: blink's plugin file auto-registers them on vim.lsp.config('*')
-- for Neovim 0.11+; lsp.lua additionally passes them explicitly via its helper.

-- Track if completions are enabled (default: true) - toggled by <C-Space>,
-- same behavior as the old nvim-cmp config.
local enabled = true

-- No completion inside comments or strings (ports the old treesitter-capture
-- check). Node types vary by grammar, so match by name pattern.
local function in_comment_or_string()
  local ok, node = pcall(vim.treesitter.get_node)
  if not ok or not node then return false end
  local t = node:type()
  return t:match("comment") ~= nil or t:match("string") ~= nil
end

require("blink.cmp").setup({
  enabled = function()
    return enabled
  end,

  keymap = {
    -- 'enter' preset: <CR> accepts, <C-e> hides, <Up>/<Down> select.
    preset = "enter",
    ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
    ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
    ["<C-b>"] = { "scroll_documentation_up", "fallback" },
    ["<C-f>"] = { "scroll_documentation_down", "fallback" },
    -- Toggle completions on/off (old cmp behavior).
    ["<C-space>"] = {
      function(cmp)
        enabled = not enabled
        if enabled then cmp.show() else cmp.hide() end
        return true
      end,
    },
  },

  snippets = { preset = "luasnip" },

  sources = {
    -- No 'buffer': deliberately removed from the cmp config too.
    default = function()
      if in_comment_or_string() then return {} end
      return { "lsp", "path", "snippets" }
    end,
  },

  completion = {
    -- <CR> accepts the preselected first item (cmp confirm({select=true})).
    list = { selection = { preselect = true, auto_insert = false } },
    documentation = { auto_show = true },
    menu = {
      draw = {
        columns = {
          { "kind_icon" },
          { "label", "label_description", gap = 1 },
          { "source_name" },
        },
      },
    },
  },

  -- Replaces cmp-nvim-lsp-signature-help.
  signature = { enabled = true },

  -- Rust matcher when the prebuilt binary is available, warn + Lua fallback
  -- otherwise (vim.pack has no build hooks; the binary downloads at release
  -- tags, hence the ^1 version pin in pack.lua).
  fuzzy = { implementation = "prefer_rust_with_warning" },
})
