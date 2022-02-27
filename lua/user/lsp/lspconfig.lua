local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
	return
end

local status_handlers_ok, handlers = pcall(require, "user.lsp.handlers")
if not status_handlers_ok then
  return
end


local servers = {'grammarly', 'pyright', 'rust_analyzer', 'tsserver', 'html', 'cssls', 'jsonls', 'bashls', 'eslint', 'efm', 'yamlls', 'gopls'}
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = handlers.on_attach,
    capabilities = handlers.capabilities,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

