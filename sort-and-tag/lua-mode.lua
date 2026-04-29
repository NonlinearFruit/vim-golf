n=vim.fn
b=n.getline(1,"$")
s=n.sort(b)
for k=1,27,2 do n.setline(k,("[%02d] %s"):format(n.index(s,b[k])+1,b[k]))end
vim.cmd"x"

