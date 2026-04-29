n=vim.fn
b=n.getline(1,"$")
s=n.sort(b)
for k,r in next,s do s[r]=k end
for k,r in next,b do b[k]=r:find"_"and r or("[%02d] "..r):format(s[r])end
n.setline(1,b)
vim.cmd"x"

