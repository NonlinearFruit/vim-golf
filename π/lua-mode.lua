vim.cmd(vim.iter(vim.api.nvim_buf_get_lines(0, 0, -1, false)):join("\n"))
vim.api.nvim_buf_set_lines(0, 0, -1, false, {vim.api.nvim_exec2("echo Pi()", {output = true}).output, "π"})
vim.opt.fixeol = false
vim.cmd.x()
