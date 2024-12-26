---@class Utils
---@field strings util.strings
---@field tables util.tables
---@field path util.path
---@field render util.render
_G.Core = {
  strings = require 'utils.strings',
  tables = require 'utils.tables',
  path = require 'utils.path',
  render = require 'utils.render',
}

_G.Tables = require 'utils.tables'
_G.Path = require 'utils.path'
_G.Render = require 'utils.render'
_G.Strings = require 'utils.strings'