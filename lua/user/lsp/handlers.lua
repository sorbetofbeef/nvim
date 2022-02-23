local G = {}

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
G.setup = function()
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
    ]], false)
  end
end

local lsp_keymaps = function(bufnr)
  which_key.setup(wk.setup)

  which_key.register({
    a = {
      name = "LSP",
      -- GoTo's
      D = {"<cmd>lua vim.lsp.buf.declaration()<CR>", "GoTo Declaration" },
      d = {"<cmd>lua vim.lsp.buf.definition()<CR>", "GoTo Definition"},
      i = {"<cmd>lua vim.lsp.buf.implementation()<CR>", "GoTo Implementation"},
      -- Refactor
      A = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
      a = {"<cmd>Lspsaga code_action<cr>", "Code Action"},
      r = {"<cmd>Lspsaga rename<cr>", "Rename"},
      f = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "Format"},
      -- Diagnostics
      l = {"<cmd>Lspsaga show_line_diagnostics<cr>", "Line Diagnostics"},
      c = {"<cmd>Lspsaga show_cursor_diagnostics<cr>", "Cursor Diagnostics"},
      j = { "<cmd>lua vim.diagnostic.goto_next()<CR>", "Next Diagnostic"},
      k = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Prev Diagnostic"},
      -- Workspaces
      L = {"<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", "List Workspaces"},
      W = { "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", "Add Workspace"},
      w = { "<cmd>Telescope lsp_workspace_diagnostics<cr>", "Workspace Diagnostics"},
      R = { "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", "Remove Workspaces"},
      -- Search
      s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols"},
      S = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Workspace Symbols"},
      E = { "<cmd>Telescope lsp_document_diagnostics<cr>", "Document Diagnostics"},
      q = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "Quickfix"},
      -- Info
      n = { "<cmd>LspInfo<cr>", "LSP Info"},
      I = { "<cmd>LspInstallInfo<cr>", "Installer Info"},
    },
  }, wk.opts)

  -- Cycle through diagnostics
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-j>", "<cmd>Lspsaga diagnostic_jump_next<cr>", {noremap=true, silent=true})
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-k>", "<cmd>Lspsaga diagnostic_jump_prev<cr>", {noremap=true, silent=true})

  -- Saga menu scrolling
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-y>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<cr>", {noremap=true, silent=true})
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-e>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<cr>", {noremap=true, silent=true})

  -- Floating Info
  vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", {noremap = true, silent = true})
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-S-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", {noremap = true, silent = true})
end


G.on_attach = function(client, bufnr)

  if client.name == "tsserver" then
    client.resolved_capabilities.document_formatting = false
  end

  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  lsp_keymaps(bufnr)
  lsp_highlight_document(client)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

G.capabilities = cmp_nvim_lsp.update_capabilities(capabilities)


return G
