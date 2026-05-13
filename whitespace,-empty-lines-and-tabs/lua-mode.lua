n=vim.fn
b=n.getline(1,"$")
table.remove(b,4)
table.remove(b,2)
for i, c in ipairs(b) do b[i]=c:gsub("%s+$",""):gsub("\t","  ")end
vim.api.nvim_buf_set_lines(0, 0, -1, 0, b)
vim.cmd"x"
