c,s,n=0,0,vim.fn
for i=1,15 do h,r=n.getline(i):match"(#+)(.*)"s=s+1 if h=="#"then c,s=c+1,0 end n.setline(i,c..(h=="#"and""or"."..s)..r)end
vim.cmd"x"
