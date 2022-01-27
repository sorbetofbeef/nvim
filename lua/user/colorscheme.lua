local nightfox = require("nightfox")

nightfox.setup({
  fox = "nightfox", -- Which fox style should be applied
  transparent = false, -- Disable setting the background color
  alt_nc = true, -- Non current window bg to alt color see `hl-NormalNC`
  terminal_colors = true, -- Configure the colors used when opening :terminal
  styles = {
    comments = "italic", -- Style that is applied to comments: see `highlight-args` for options
    functions = "italic", -- Style that is applied to functions: see `highlight-args` for options
    keywords = "NONE", -- Style that is applied to keywords: see `highlight-args` for options
    strings = "italic", -- Style that is applied to strings: see `highlight-args` for options
    variables = "NONE", -- Style that is applied to variables: see `highlight-args` for options
  },
  inverse = {
    match_paren = true, -- Enable/Disable inverse highlighting for match parens
    visual = true, -- Enable/Disable inverse highlighting for visual selection
    search = true, -- Enable/Disable inverse highlights for search highlights
  },
  colors = {}, -- Override default colors
  hlgroups = {}, -- Override highlight groups
})

nightfox.load("dawnfox")




-- !! CATPPUCCIN !! --
-- local catppuccin = require("catppuccin")
--
-- -- configure it
-- catppuccin.setup({
--
--   transparent_background = false,
--   term_colors = true,
--
--   styles = {
--     comments = "italic",
--     functions = "italic",
--     keywords = "NONE",
--     strings = "italic",
--     variables = "NONE",
--   },
--
--   integrations = {
--     treesitter = true,
--
--     native_lsp = {
--       enabled = true,
--
--       virtual_text = {
--         errors = "italic",
--         hints = "italic",
--         warnings = "italic",
--         information = "italic",
--       },
--
--       underlines = {
--         errors = "underline",
--         hints = "underline",
--         warnings = "underline",
--         information = "underline",
--       },
--     },
--
--     lsp_trouble = false,
--     cmp = true,
--     lsp_saga = true,
--     gitgutter = false,
--     gitsigns = true,
--     telescope = true,
--
--     nvimtree = {
--       enabled = true,
--       show_root = false,
--       transparent_panel = true,
--     },
--
--     which_key = true,
--
--     indent_blankline = {
--       enabled = true,
--       colored_indent_levels = true,
--     },
--
--     dashboard = true,
--     neogit = false,
--     vim_sneak = false,
--     fern = false,
--     barbar = false,
--     bufferline = true,
--     markdown = true,
--     lightspeed = false,
--     ts_rainbow = false,
--     hop = false,
--     notify = true,
--     telekasten = true,
--   }
-- })
-- vim.cmd[[colorscheme catppuccin]]

-- !! MATERIAL !! --
-- vim.g.material_style = 'lighter'
--
-- require('material').setup({
--
-- 	contrast = {
-- 		sidebars = true, -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
-- 		floating_windows = false, -- Enable contrast for floating windows
-- 		line_numbers = true, -- Enable contrast background for line numbers
-- 		sign_column = true, -- Enable contrast background for the sign column
-- 		cursor_line = true, -- Enable darker background for the cursor line
-- 		non_current_windows = true, -- Enable darker background for non-current windows
-- 		popup_menu = false, -- Enable lighter background for the popup menu
-- 	},
--
-- 	italics = {
-- 		comments = true, -- Enable italic comments
-- 		keywords = false, -- Enable italic keywords
-- 		functions = true, -- Enable italic functions
-- 		strings = true, -- Enable italic strings
-- 		variables = false -- Enable italic variables
-- 	},
--
-- 	contrast_filetypes = { -- Specify which filetypes get the contrasted (darker) background
-- 		"terminal", -- Darker terminal background
-- 		"packer", -- Darker packer background
-- 		"qf" -- Darker qf list background
-- 	},
--
-- 	high_visibility = {
-- 		lighter = false, -- Enable higher contrast text for lighter style
-- 		darker = false, -- Enable higher contrast text for darker style
-- 	},
--
-- 	disable = {
-- 		borders = false, -- Disable borders between verticaly split windows
-- 		background = false, -- Prevent the theme from setting the background (NeoVim then uses your teminal background)
-- 		term_colors = false, -- Prevent the theme from setting terminal colors
-- 		eob_lines = false -- Hide the end-of-buffer lines
-- 	},
--
-- 	custom_highlights = {} -- Overwrite highlights with your own
-- })
--
-- vim.cmd("colorscheme material")
