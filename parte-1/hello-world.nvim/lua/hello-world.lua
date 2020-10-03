-- modulo hello-world
local M = {}

-- hello_world printa a string "Hello World!" na tela
function M.hello_world()
  print("Hello World Lua!")
end

function M.create_command()
  vim.cmd("command! -bang -nargs=* HelloWorld lua require('hello-world').hello_world()")
end

function M.init()
  M.create_command()
end

return M
