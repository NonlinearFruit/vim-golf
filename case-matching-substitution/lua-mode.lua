content = vim.api.nvim_buf_get_lines(0, 0, -1, false)
for i, line in ipairs(content) do
  content[i] = string.gsub(line, "([Ll])([Oo])([Rr])([Ee])([Mm])", function(l, o, r, e, m)
    local ipsum = "I"
    if l == "l" then
      ipsum = "i"
    end
    if o == "o" then
      ipsum = ipsum.."p"
    else
      ipsum = ipsum.."P"
    end
    if r == "r" then
      ipsum = ipsum.."s"
    else
      ipsum = ipsum.."S"
    end
    if e == "e" then
      ipsum = ipsum.."u"
    else
      ipsum = ipsum.."U"
    end
    ipsum = ipsum..m
    return ipsum
  end)
end
vim.api.nvim_buf_set_lines(0, 0, -1, false, content)
vim.cmd.x()
