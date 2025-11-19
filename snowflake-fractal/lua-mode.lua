a="X X   X X         X X   X X"
b=" X     X           X     X"
c="   X X               X X"
d="    X                 X"
e="         X X   X X"
f="          X     X"
g="            X X"
vim.api.nvim_buf_set_lines(0,0,-1,false,{
a,
b,
a,
c,
d,
c,
a,
b,
a,
e,
f,
e,
g,
"             X",
g,
e,
f,
e,
a,
b,
a,
c,
d,
c,
a,
b,
a})
vim.cmd.x()
