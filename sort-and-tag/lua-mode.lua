v=vim.api
f=v.nvim_buf_get_lines
b=f(0,0,-1,0)
s=f(0,0,-1,0)
table.sort(s)
for k,r in pairs(s)do s[r]=k end
for i,r in ipairs(b)do b[i]=r:find"_"and r or("[%02d] "..r):format(s[r])end
v.nvim_buf_set_lines(0,0,-1,0,b)
vim.cmd.x()

