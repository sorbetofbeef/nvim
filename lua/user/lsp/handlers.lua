local M = {}

local cmp_status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_status_ok then
  return
end

local which_status_ok, which_key = pcall(require, "which-key")
if not which_status_ok then
  return
end

local wk_status_ok, wk = pcall(require, "user.whichkey")
if not wk_status_ok then
  return
end

-- TODO: backfill this to template
M.setup = function()
  local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  local config = {
    -- disable virtual text
    virtual_text = false,
    -- show signs
    signs = {
      active = signs,
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
    experimental = {
      ghost_text = true,
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })
end

local function lsp_highlight_document(client)
  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec(
      [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
      false
    )
  end
end


local function lsp_keymaps(bufnr)
  -- map(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  -- map(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  -- map(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  -- map(bufnr, "n", "gj", "<cmd>Lspsaga diagnostic_jump_next<cr>", opts)
  -- map(bufnr, "n", "gk", "<cmd>Lspsaga diagnostic_jump_prev<cr>", opts)

  vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", {noremap = true, silent = true})

  wk.opts.buffer = bufnr

  which_key.register({
    a = {
      name = "LSP",
      D = {"<cmd>lua vim.lsp.buf.declaration()<CR>", "GoTo Declaration" },

      d = {"<cmd>lua vim.lsp.buf.definition()<CR>", "GoTo Definition"},

      i = {"<cmd>lua vim.lsp.buf.implementation()<CR>", "GoTo Implementation"},

      r = {"<cmd>Lspsaga rename<cr>", "Rename"},

      a = {"<cmd>Lspsaga code_action<cr>", "Code Action"},

      A = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },

      k = {"<cmd>lua vim.lsp.buf.signature_help()<CR>", "Show Signature Help"},

      l = {"<cmd>Lspsaga show_line_diagnostics<cr>", "Show Line Diagnostics"},

      c = {"<cmd>Lspsaga show_cursor_diagnostics<cr>", "Show Cursor Diagnostics"},
    },

    ["j"] = {
      "<cmd>Lspsaga diagnostic_jump_next<cr>",
      "Next Diagnostic",
    },

    ["k"] = {
      "<cmd>Lspsaga diagnostic_jump_prev<cr>",
      "Prev Diagnostic",
    },

    ["<C-y>"] = {"<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<cr>", "Saga Scroll Up"},

    ["<C-e>"] = {"<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<cr>", "Saga Scroll Down"},


  }, wk.opts)
  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end


M.on_attach = function(client, bufnr)
  if client.name == "tsserver" then
    client.resolved_capabilities.document_formatting = false
  end
  lsp_keymaps(bufnr)
  lsp_highlight_document(client)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

M.capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

which_key.setup(wk.setup)

return M
