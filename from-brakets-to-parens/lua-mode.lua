c = vim.api.nvim_buf_get_lines(0, 0, -1, false)
for i, line in ipairs(c) do
  c[i] = string.gsub(line, "([^%[%]])([%[%]])([%[%]]?)", function(a,b,c)
    s = a..", "
    if b == "[" then
      s = a.."("..c
    elseif c ~= "[" then
      s = a..")"..c
    end
    return s
  end)
end
vim.api.nvim_buf_set_lines(0, 0, -1, false, c)
vim.cmd.x()
