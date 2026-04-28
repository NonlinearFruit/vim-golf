b = vim.api.nvim_buf_get_lines(0, 0, -1, 0)
for i, c in ipairs(b) do b[i] = c:gsub("([Ll])([Oo])([Rr])([Ee])([Mm])", function(l, o, r, e, m) return (l == "l" and "i" or "I")..(o == "o" and "p" or "P")..(r == "r" and "s" or "S")..(e == "e" and "u" or "U")..m end) end
vim.api.nvim_buf_set_lines(0, 0, -1, 0, b)
vim.cmd.x()
