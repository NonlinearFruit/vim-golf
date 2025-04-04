local first = string.gmatch(vim.api.nvim_buf_get_lines(0, 0, 1, false)[1], "[^ ]+")
local second = string.gmatch(vim.api.nvim_buf_get_lines(0, 2, 3, false)[1], "[^ ]+")
local output = {}
for a in first do
  local b = second()
  if a == "Sol" then
    table.insert(output, a.." = "..b)
  else
    table.insert(output, a.."  = "..b)
  end
end
vim.api.nvim_buf_set_lines(0, 0, -1, false, output)
vim.cmd.x()

