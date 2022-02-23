local luadev = require("lua-dev").setup({
  lspconfig = {
    cmd = {"/home/me/.local/share/nvim/lsp_servers/sumneko_lua/extension/server/bin/lua-language-server"}
  },
})

local lspconfig = require('lspconfig')
lspconfig.sumneko_lua.setup(luadev)
