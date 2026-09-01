" Tagbar 配置
if common#functions#HasPlug('tagbar')
    let g:tagbar_width = 35

    " 自定义切换：未打开则打开；已打开则在「聚焦窗口」和「关闭」之间切换
    " （修复原 vime 版本 a:bufnr 赋值报 E461 的 bug；
    "   tagbar 缓冲区名带序号后缀，按 filetype=tagbar 检测；
    "   win_findbuf 返回窗口 ID，需用 win_getid/win_gotoid 比较与跳转）
    function! Tagbar_Toggle()
        let l:tagbuf = 0
        for l:buf in getbufinfo()
            if getbufvar(l:buf.bufnr, '&ft') ==# 'tagbar'
                let l:tagbuf = l:buf.bufnr
                break
            endif
        endfor
        let l:tagwins = l:tagbuf > 0 ? win_findbuf(l:tagbuf) : []
        if !empty(l:tagwins)
            if win_getid() == l:tagwins[0]
                TagbarClose
            else
                call win_gotoid(l:tagwins[0])
            endif
        else
            TagbarOpen
        endif
    endfunction
    nnoremap <F3> :call Tagbar_Toggle()<CR>
endif
