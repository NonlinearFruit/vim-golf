local bufnr = vim.api.nvim_get_current_buf()
local content = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
local output = {}
local count = 0
local subcount = 0
for i, line in ipairs(content) do
  local second = string.sub(line, 2, 2)
  if second == "#" then
    subcount = subcount + 1
    output[i] = count.."."..subcount..string.sub(line,3,-1)
  else
    count = count + 1
    output[i] = count..string.sub(line,2,-1)
    subcount = 0
  end
end
vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, output)
vim.cmd.x()
