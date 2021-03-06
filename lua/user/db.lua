local wk = require("which-key")
local wk_conf = require("user.whichkey")

wk.register({
  d = {
    name = "Database",
    u = {":DBUIToggle<CR>", "DB Toggle"},
    f = {":DBUIFindBuffer<CR>", "DB Find Buffer"},
    r = {":DBUIRenameBuffer<CR>", "DB Rename Buffer"},
    l = {":DBUILastQueryInfo<CR>", "DB Last Query Info"}
  }
}, wk_conf.opts)

vim.g.db_ui_save_location='~/.config/db_ui'
