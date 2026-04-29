%s/^/\=line('.')
sor /\d*/
%s/\ze\u/\=printf("[%02d] ",line('.'))
sor n
%s/\d*
x
