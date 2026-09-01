" NERDTree 配置
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDChristmasTree = 1

if common#functions#HasPlug('nerdtree-git-plugin')
    let g:NERDTreeGitStatusIndicatorMapCustom = {
        \ "Modified"  : "✹",
        \ "Staged"    : "✚",
        \ "Untracked" : "✭",
        \ "Renamed"   : "➜",
        \ "Unmerged"  : "═",
        \ "Deleted"   : "✖",
        \ "Dirty"     : "✗",
        \ "Clean"     : "✔︎",
        \ 'Ignored'   : '☒',
        \ "Unknown"   : "?"
        \ }
endif

let g:plug_window = 'noautocmd vertical topleft new'
let NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeChDirMode = 2

function! s:NERDTreeCustomCROpen(node) abort
    let l:newRoot = a:node.GetSelected()
    if l:newRoot.path.isDirectory
        call b:NERDTree.changeRoot(l:newRoot)
    else
        call l:newRoot.activate({'reuse': 'all', 'where': 'p'})
    endif
endfunction

function! NERDTreeYankCurrentNode(node)
    let l:s = a:node.GetSelected()
    if l:s != {}
        call setreg('"', l:s.path.str())
    endif
endfunction

" 常用快捷键
map <F2> :NERDTreeFocus<CR>
let g:NERDTreeMapOpenSplit = "w"
let g:NERDTreeMapOpenVSplit = "W"
let g:NERDTreeMapActivateNode = 'l'
let g:NERDTreeMapOpenRecursively = 'L'
let g:NERDTreeMapCloseDir = 'h'
let g:NERDTreeMapToggleHidden = '.'
let g:NERDTreeMapUpdirKeepOpen = '<backspace>'
let g:NERDTreeMapOpenInTab = 't'
let g:NERDTreeMapJumpNextSibling = 'J'
let g:NERDTreeMapJumpPrevSibling = 'K'

augroup vime_nerdtree_group
    autocmd!
    autocmd BUFENTER * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
    autocmd BufEnter * if bufname('#') =~# "^NERD_tree_" && winnr('$') > 1 | b# | endif
    autocmd FileType nerdtree nmap <buffer> <CR> bb
    autocmd VimEnter * call NERDTreeAddKeyMap({
        \ 'key': 'bb',
        \ 'callback': function('<SID>NERDTreeCustomCROpen'),
        \ 'quickhelpText': 'go to dir and change cwd to it or open a file',
        \ 'scope': 'Node',
        \ 'override': 1,
        \ })
    autocmd VimEnter * call NERDTreeAddKeyMap({
            \ 'key': 'yp',
            \ 'callback': 'NERDTreeYankCurrentNode',
            \ 'quickhelpText': 'put full path of current node into the default register',
            \ 'scope': 'Node',
            \ 'override': 1,
            \ })
augroup END
