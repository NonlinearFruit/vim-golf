local bufnr = vim.api.nvim_get_current_buf()
local content = vim.api.nvim_buf_get_lines(0, 0, -1, false)
local sortedContent = vim.api.nvim_buf_get_lines(0, 0, -1, false)
table.sort(sortedContent, function(a ,b) return a < b end)
local index = {}
for k,v in pairs(sortedContent) do
   index[v]=k
end
local output = {}
for i, line in ipairs(content) do
  if line == "____________________" then
    output[i] = line
  else
    local count = index[line]
    if count < 10 then
      count = "0"..count
    end
    output[i] = "["..count.."] "..line
  end
end
vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, output)
vim.cmd.x()

