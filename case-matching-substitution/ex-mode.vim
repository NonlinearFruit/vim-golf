let M={m,o->nr2char(char2nr(submatch(m))+o)}
%s/\v(l)(o)(r)(e)/\=M(1,-3).M(2,1).M(3,1).M(4,16)/gi
x
