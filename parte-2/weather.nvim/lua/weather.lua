-- Weather module for weather.nvim plugin
local win, buf
local M = {}

-- creates :Weather command
local function create_command()
  vim.cmd("command! -bang -nargs=0 Weather lua require('weather').create_window()")
end

function M.create_window()
  -- window size and pos
  local columns = vim.api.nvim_get_option("columns")
  local lines = vim.api.nvim_get_option("lines")
  local win_height = math.ceil(columns * 0.6 - 8)
  local win_width = math.ceil(lines * 0.3 - 6)
  local x_pos = 1
  local y_pos = columns - win_width

  local win_opts = {
    style = "minimal",
    relative = "editor",
    width = win_width,
    height = win_height,
    row = x_pos,
    col = y_pos,
  }

  -- create preview buffer and set local options
  buf = vim.api.nvim_create_buf(false, true)
  win = vim.api.nvim_open_win(buf, true, win_opts)

  -- create mapping to close buffer
  vim.api.nvim_buf_set_keymap(buf, "n", "q",
                              ":lua require('weather').close_window()<cr>",
                              {noremap = true, silent = true})

  local command = "curl https://wttr.in/?0"
  vim.api.nvim_call_function("termopen", {command})
end

-- closes floating window
function M.close_window()
  vim.api.nvim_win_close(win, true)
end

-- main function
function M.init()
  create_command()
end

return M
