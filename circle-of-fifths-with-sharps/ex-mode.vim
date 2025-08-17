gQ2d|%s/\s\+/\r/g|exe "1,13norm A  = \<esc>"|for i in range(1,13)|exe (28-i)."m".(14-i)."|-1j!"|endfor|$-1,$d|2s/  / /|wq
