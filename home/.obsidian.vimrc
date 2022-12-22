imap kj <Esc>

nmap j gj
nmap k gk
nmap H ^
nmap L $

" Go back and forward with Ctrl+O and Ctrl+I
" (make sure to remove default Obsidian shortcuts for these to work)
exmap back obcommand app:go-back
nmap <C-o> :back
exmap forward obcommand app:go-forward
nmap <C-i> :forward

exmap surround_wiki surround [[ ]]
exmap surround_double_quotes surround " "
exmap surround_single_quotes surround ' '
exmap surround_brackets surround ( )
exmap surround_square_brackets surround [ ]
exmap surround_curly_brackets surround { }

" NOTE: must use 'map' and not 'nmap'
map [[ :surround_wiki
nunmap S
vunmap S
map S" :surround_double_quotes
map S' :surround_single_quotes
map Sb :surround_brackets
map S( :surround_brackets
map S) :surround_brackets
map Sr :surround_square_brackets
map S[ :surround_square_brackets
map S[ :surround_square_brackets
map SB :surround_curly_brackets
map S{ :surround_curly_brackets
map S} :surround_curly_brackets
