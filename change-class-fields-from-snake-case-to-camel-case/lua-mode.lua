local bufnr = vim.api.nvim_get_current_buf()
local content = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
local output = {}
for i, line in ipairs(content) do
  output[i] = string.gsub(line, "_(%a)", function(match) return string.upper(match) end)
end
vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, output)
vim.cmd.x()
