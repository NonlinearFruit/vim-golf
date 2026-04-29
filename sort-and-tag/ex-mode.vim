let s=sort(getline(1,'$'))
%s/\ze\u/\=printf("[%02d] ",index(s,getline('.'))+1)/
x
