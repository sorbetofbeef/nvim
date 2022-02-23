local neorg = require('neorg')
neorg.setup {
  load = {
    ["core.defaults"] = {},
    ["core.norg.dirman"] = {
      config = {
        workspaces = {
          go = "~/docs/go",
          rust = "~/docs/rust",
          solidity = "~/docs/solidity",
          strapi = "~/docs/strapi",
          gambling_project = "~/docs/gambling-project",
        },
        index = "index.norg",
      },
    },
    ["core.norg.completion"] = {},
    ["core.intergrations.nvim-cmp"] = {},
    ["core.gtd.base"] = {},
  }
}
