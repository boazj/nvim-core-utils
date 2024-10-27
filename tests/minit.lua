#!/usr/bin/env -S nvim -l

local function project_path()
  local path = debug.getinfo(2, 'S').source:sub(2)
  return vim.fn.fnamemodify(path:match '(.*/)', ':h:h:p')
end

local project = project_path()
local tests = project .. '/tests'

vim.env.LAZY_STDPATH = project .. '/.tests'
load(vim.fn.system 'curl -s https://raw.githubusercontent.com/folke/lazy.nvim/main/bootstrap.lua')()

-- Setup lazy.nvim
require('lazy.minit').setup {
  rocks = {
    enabled = false,
  },
  spec = {
    { dir = project },
    'nvim-lua/plenary.nvim',
    {
      'echasnovski/mini.test',
      opts = {
        collect = {
          find_files = function()
            return vim.fn.globpath(tests, '**/*_spec.lua', true, true)
          end,
        },
      },
    },
    opts = {
      notify = false,
    },
  },
}
