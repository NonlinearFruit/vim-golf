v=vim.api
f=v.nvim_buf_get_lines
b=f(0,0,-1,0)
s=f(0,0,-1,0)
table.sort(s,function(a,b)return a<b end)
for k,r in pairs(s)do s[r]=k end
for i,r in ipairs(b)do b[i]=r:sub(1,1)=="_"and r or string.format("[%02d] %s",s[r],r)end
v.nvim_buf_set_lines(0,0,-1,0,b)
vim.cmd.x()

