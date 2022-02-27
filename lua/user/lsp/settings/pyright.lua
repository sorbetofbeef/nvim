require'lspconfig'.pyright.setup{
  root_dir = function ()
    if vim.fn.findfile("main.py", vim.fn.getcwd()) then
      return vim.fn.getcwd()
    end
  end
}
