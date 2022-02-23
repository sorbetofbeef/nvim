local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
	return
end

local status_ok, handlers = pcall(require, "user.lsp.handlers")
if not status_ok then
  return
end


local servers = {'pyright', 'rust_analyzer', 'tsserver', 'html', 'cssls', 'jsonls', 'bashls', 'eslint', 'efm', 'yamlls', 'gopls'}
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = handlers.on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end
