local status_ok, go = pcall(require, "go")
if not status_ok then
  return
end

go.setup({
  filstruct = 'gopls',
  dap_debug = true,
  dap_debug_gui = true
})
