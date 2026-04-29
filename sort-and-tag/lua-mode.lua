n=vim.fn
b=n.getline(1,"$")
s=n.sort(b)
for k,r in next,b do i=n.index(s,r)b[k]=i<14 and("[%02d] "..r):format(i+1)or r end
n.setline(1,b)
vim.cmd"x"

