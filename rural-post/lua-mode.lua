b = vim.api.nvim_buf_get_lines(0, 0, -1, false)
for i, l in ipairs(b) do
  b[i] = string.gsub(l, ".+ (%d+)", function(c)
    return c
  end)
end
vim.api.nvim_buf_set_lines(0, 0, -1, false, b)
vim.cmd.x()
