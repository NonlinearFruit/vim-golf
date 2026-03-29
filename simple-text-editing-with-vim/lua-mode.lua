l = vim.api.nvim_buf_get_lines(0, 0, -1, false)
l[5] = l[4]
l[9] = l[8]
l[13] = l[12]
vim.api.nvim_buf_set_lines(0, 0, -1, false, l)
vim.cmd.x()
