" 退出 vim 时自动保存 session（滚动保存 session_0/1/2）
if !common#functions#HasPlug('dashboard-nvim') && !common#functions#HasPlug('vim-startify')
    function! s:SaveSession() abort
        if !isdirectory(g:session_dir)
            call mkdir(g:session_dir, 'p')
        endif
        let l:sessions = [g:session_dir . '/session_0.vim',
                    \ g:session_dir . '/session_1.vim',
                    \ g:session_dir . '/session_2.vim']
        if filereadable(l:sessions[1])
            call rename(l:sessions[1], l:sessions[2])
        endif
        if filereadable(l:sessions[0])
            call rename(l:sessions[0], l:sessions[1])
        endif
        exec "mksession! " . l:sessions[0]
    endfunction
    augroup vime_session_group
        autocmd!
        autocmd VimLeavePre * call s:SaveSession()
    augroup END
endif
