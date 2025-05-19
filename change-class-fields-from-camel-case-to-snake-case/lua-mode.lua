local bufnr = vim.api.nvim_get_current_buf()
local content = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
local output = {}
for i, line in ipairs(content) do
  output[i] = string.gsub(line, "(%l)(%u)(.+):", function(l, u, o) return l.."_"..string.lower(u)..o..":" end)
end
for i, line in ipairs(output) do
  output[i] = string.gsub(line, "(%l)(%u)(.+):", function(l, u, o) return l.."_"..string.lower(u)..o..":" end)
end
vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, output)
vim.cmd.x()
