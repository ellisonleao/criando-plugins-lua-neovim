-- Weather module for weather.nvim plugin
local win, buf
local M = {}

-- creates :Weather command
local function create_command()
  vim.cmd("command! -nargs=0 Weather lua require('weather').create_window()")
end

M.create_window = function()
  -- window size and pos
  local columns = vim.api.nvim_get_option("columns")
  local lines = vim.api.nvim_get_option("lines")
  local win_width = math.ceil(columns * 0.3 - 10)
  local win_height = math.ceil(lines * 0.3 - 6)
  local x_pos = 1
  local y_pos = columns - win_width

  local win_opts = {
    style = "minimal",
    relative = "editor",
    width = win_width,
    height = win_height,
    row = x_pos,
    col = y_pos,
    border = "single",
  }

  -- create preview buffer and set local options
  buf = vim.api.nvim_create_buf(false, true)
  win = vim.api.nvim_open_win(buf, true, win_opts)

  -- create mapping to close buffer
  vim.keymap.set("n", "q", function()
    vim.api.nvim_win_close(win, true)
  end, { noremap = true, silent = true, buffer = buf })

  local command = "curl https://wttr.in/?0"
  vim.fn.termopen(command)
end

-- plugin entrypoint
M.setup = function()
  create_command()
end

return M
