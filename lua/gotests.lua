local fn = vim.fn
local exists = fn.exists

local M = {}

local function gotests()
  if exists('g:loaded_vim_gotests') == true then
    return
  end

  vim.g.loaded_vim_gotests = 1

  if exists('g:gotests_bin') == 0 or not vim.g.gotests_bin then
    vim.g.gotests_bin = 'gotests'
  end

  if exists('g:gotests_template_dir') == 0 or not vim.g.gotests_template_dir then
    vim.g.gotests_template_dir = ''
  end
end

local function setup_commands()
  local cmds = {
    {
      name = 'GoTests',
      cmd = function(range)
        require('gotests.autoload').tests(range.line1, range.line2)
      end,
      opt = {
        range = true,
      }
    },
    {
      name = 'GoTestsAll',
      cmd = "lua require('gotests.autoload').alltests()",
      opt = {}
    },
  }

  for _, cmd in ipairs(cmds) do
    vim.api.nvim_create_user_command(
      cmd.name,
      cmd.cmd,
      cmd.opt
    )
  end
end

function M.setup()
  gotests()
  setup_commands()
end

return M
