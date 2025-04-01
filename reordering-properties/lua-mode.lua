o = {}
b = {}
for _, line in pairs(vim.api.nvim_buf_get_lines(0,0,-1,false)) do
  if string.sub(line,1,1) == " " then
    table.insert(b, line)
  else
    table.sort(b, function(a,b) return string.len(a)<string.len(b) end)
    for _, value in pairs(b) do
      table.insert(o,value)
    end
    table.insert(o,line)
    b = {}
  end
end
vim.api.nvim_buf_set_lines(0,0,-1,false,o)
vim.cmd.x()

