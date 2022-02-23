local wk = require("which-key")

wk.register({
  d = {
    name = "Database",
    u = {":DBUIToggle<CR>", "DB Toggle"},
    f = {":DBUIFindBuffer<CR>", "DB Find Buffer"},
    r = {":DBUIRenameBuffer<CR>", "DB Rename Buffer"},
    l = {":DBUILastQueryInfo<CR>", "DB Last Query Info"}
  }
}, wk.opts)

vim.g.db_ui_save_location='~/.config/db_ui'
