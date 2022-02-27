require("lspconfig").grammarly.setup {
  root_dir = function()
    if vim.fn.filewritable("*.md") then
      return vim.fn.getcwd()
    end
  end
}
