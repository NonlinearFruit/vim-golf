n=vim.fn
for i=1,8 do n.setline(i,n.getline(i):gsub("(%d)(%d)",function(j,k)return(j=="1"and 0 or 1)..(k=="1"and 0 or 1)end).."")end
vim.cmd"x"
