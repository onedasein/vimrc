"""""""""""""""""""""""""""""""""""""""
"
" 一些通用或者懒加载的自定义函数放到这里
"""""""""""""""""""""""""""""""""""""""

function! common#functions#PlugHasLoaded(plugName) abort
    " 判断插件是否已经载入
    return (
       \ has_key(g:plugs, a:plugName) &&
       \ stridx(&rtp, g:plugs[a:plugName].dir) >= 0)
endfunction

" TODO 应该先判断g:plugs_order是否存在
function! common#functions#HasPlug(...) abort
    " 如果类型是列表，那么列表中的所有插件都要存在才可以
    " 其他情况如字符串，只需要存在一个即可
    " HasPlug("f", ["a", "b", "c"], "d", "e")
    " 需要f存在或者[a b c]都要存在或者d存在或者e存在

    if a:0 == 0
        return v:false
    endif

    " 如果有一个存在，那么就返回true
    for out_item in a:000
        " 如果类型是列表
        " 那么列表中的所有插件都要存在

        if type(out_item) == v:t_list

            let list_tag = v:true
            for item in out_item
                " 不存在
                if index(g:plugs_order, item) == -1
                    let list_tag = v:false
                    break
                endif
            endfor
            if list_tag
                return v:true
            endif

        " 否则，只需要检测是否存在
        elseif type(out_item) == v:t_string
            if index(g:plugs_order, out_item) > -1
                return v:true
            endif
        endif
    endfor


    " 插件列表中是否存在该插件
    " return (index(g:plugs_order, a:plugName) > -1 ? v:true : v:false)
endfunction

function! common#functions#HasInstall(plugName) abort
    " 判断插件是否已经安装在本地
    return (isdirectory(g:plugs[a:plugName].dir) ? v:true : v:false)
endfunction

function! common#functions#HasCocPlug(plugName) abort
    " 判断是否安装了coc插件
    if common#functions#HasPlug('coc.nvim') && has_key(g:, 'coc_global_extensions') &&
        \ index(g:coc_global_extensions, a:plugName) > -1
        return v:true
    else
        return v:false
    endif
endfunction

function! common#functions#CheckBackSpace() abort
    " 判断光标前是否为行首或空白字符（用于 coc 智能 Tab 映射：
    " 行首/空白后按 Tab 应插入缩进，而非触发补全）。
    " 必须用 autoload 全局函数名而不是脚本内 s: 函数：映射建立时 <SID> 会固化成
    " <SNR>xxx_ 名字，配置被重复 source 后函数换新脚本号，旧映射指向的函数已不存在，
    " 行首按 Tab 会报 E117: Unknown function: <SNR>xxx_check_back_space。
    let l:col = col('.') - 1
    return !l:col || getline('.')[l:col - 1] =~# '\s'
endfunction

function! common#functions#Wall() abort
    " 写入所有文件
    " 记录当前的tab以及window
    let tab = tabpagenr()
    let win = winnr()
    let seen = {}
    " 保存当前的buffer
    if !&readonly && expand("%") !=# ''
        let seen[bufnr('')] = 1
        write
    endif
    " 在每个标签页每个窗口执行
    tabdo windo if !&readonly && &buftype =~# '^\%(acwrite\)\=$' && expand('%') !=# '' && !has_key(seen, bufnr('')) | silent write | let seen[bufnr('')] = 1 | endif
    " 返回之前的tab和window
    execute 'tabnext '.tab
    execute win.'wincmd w'
endfunction

function! common#functions#MoveTabOrBuf(direction) abort
    " 移动buffer或者tab
    " 0 <- 1 ->

    let s:exclude_ft = ["coc-explorer", "vista"]
    if index(s:exclude_ft, &ft) != -1 | return | endif

    " 如果在floaterm中
    if &ft ==# "floaterm"
        if a:direction == 0
            exec "FloatermNext"
        else
            exec "FloatermPrev"
        endif

        return
    endif

    if tabpagenr('$') > 1
        call common#functions#moveTab(a:direction)
    else
        call common#functions#moveBuffer(a:direction)
    endif
endfunction

function! common#functions#moveTab(direction) abort
    if a:direction == 0
        exec 'tabprevious'
    elseif a:direction == 1
        exec 'tabnext'
    endif
endfunction

function! common#functions#moveBuffer(direction) abort
    if a:direction == 0
        exec 'bprevious'
    elseif a:direction == 1
        exec 'bnext'
    endif
endfunction

function! common#functions#OpenFileUsingSystemApp(filePath) abort
    " 使用系统应用打开当前文件
    exec 'silent !xdg-open ' . fnameescape(a:filePath) . ' > /dev/null'
endfunction

function! common#functions#ModeType() abort
    " 获得当前的模式
    " 返回n, i, v, R中的一种
    if mode() =~# '[nc]'
        return 'n'
    elseif mode() =~# '[it]'
        return 'i'
    elseif mode() =~# '[vVsS]'
        return 'v'
    elseif mode() ==# 'R'
        return 'R'
    endif
    return ''
endfunction

" TODO 更改为字典，if判断速度较慢
function! common#functions#ModeLabel() abort
    " 获得模式的标签
    " 如NORMAL INSERT VISUAL等
    let l:mode = common#functions#ModeType()
    if l:mode ==? 'n'
        return 'NORMAL'
    elseif l:mode ==? 'i'
        return 'INSERT'
    elseif l:mode ==? 'v'
        return 'VISUAL'
    elseif l:mode ==? 'R'
        return 'REPLACE'
    else
        return ''
    endif
endfunction

function! common#functions#ModeLabelWithColor() abort
    " 获得模式的标签，带颜色
    " 如NORMAL INSERT VISUAL等
    let l:mode = common#functions#ModeType()
    if l:mode ==? 'n'
        return 'NORMAL'
    elseif l:mode ==? 'i'
        return 'INSERT'
    elseif l:mode ==? 'v'
        return 'VISUAL'
    elseif l:mode ==? 'R'
        return 'REPLACE'
    else
        return ''
    endif
endfunction

function! common#functions#FileType() abort
    " 获得一些特殊文件的类型
    return &filetype ==? 'help'             ? ''  :
    \      &filetype ==? 'defx'             ? ' ' :
    \      &filetype ==? 'coc-explorer'     ? ' ' :
    \      &filetype ==? 'denite'           ? ' ' :
    \      &filetype ==? 'tagbar'           ? ' ' :
    \      &filetype ==? 'vista_kind'       ? ' ' :
    \      &filetype ==? 'vista'            ? ' ' :
    \      &filetype =~? '\v^mundo(diff)?$' ? ' ' :
    \      &filetype
endfunction

function! common#functions#ReadOnly() abort
    " 判断是否只读
    if &readonly
        return "  "
    else
        return ""
    endif
endfunction

function! common#functions#GitBranch() abort
    " 根据不同的插件获取git分支

    let l:git_branch = get(g:, 'coc_git_status', '')
    if l:git_branch != ''
        return strlen(l:git_branch) > 0 ? l:git_branch : ''
    elseif exists('fugitive#head')
        return fugitive#head(8)
    elseif exists('*gitbranch#name')
        return gitbranch#name()
    elseif exists('*vcs#info')
        return vcs#info('%b')
    endif
endfunction

function! common#functions#GitCount() abort
    " Git修改计数
    let l:git_count=get(b:, 'coc_git_status', '')
    return l:git_count

    if empty(l:git_count)
        if exists('*GitGutterGetHunkSummary')
            let [a,m,r] = GitGutterGetHunkSummary()
                return printf('+%d ~%d -%d', a, m, r)
        else
            return ''
        endif
    else
        return l:git_count
    endif
endfunction

function! common#functions#MethodOrFunction() abort
    " 当前的方法或者函数
    return get(b:, 'vista_nearest_method_or_function', '')
endfunction

function! common#functions#BufLineAndColInfo() abort
    " 获得当前buffer的行，列等信息
    return printf(' %d%% ☰ %d:%d', 100*line('.')/line('$'),  line('.'), col('.'))
endfunction

function! common#functions#getVisualSelection() abort
    " Why is this not a built-in Vim script function?!
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end] = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)
    if len(lines) == 0
        return ''
    endif
    let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][column_start - 1:]
    return join(lines, "\n")
endfunction

function! common#functions#CocError() abort
    if !common#functions#HasPlug('coc.nvim')
        return ""
    endif
    let error_sign = get(g:, 'coc_status_error_sign', has('mac') ? '❌ ' : 'E')
    let info = get(b:, 'coc_diagnostic_info', {})
    if empty(info)
        return ''
    endif
    let errmsgs = []
    if get(info, 'error', 0)
        call add(errmsgs, error_sign . info['error'])
    endif
    return join(errmsgs, ' ')
endfunction

function! common#functions#CocWarn() abort
    if !common#functions#HasPlug('coc.nvim')
        return ""
    endif
    let warning_sign = get(g:, 'coc_status_warning_sign')
    let info = get(b:, 'coc_diagnostic_info', {})
    if empty(info)
        return ''
    endif
    let warnmsgs = []
    if get(info, 'warning', 0)
        call add(warnmsgs, warning_sign . info['warning'])
    endif
    return join(warnmsgs, ' ')
endfunction

function! common#functions#CocFixes() abort
    if !common#functions#HasPlug('coc.nvim')
        return ""
    endif
    let b:coc_line_fixes = get(get(b:, 'coc_quickfixes', {}), line('.'), 0)
    return b:coc_line_fixes > 0 ? printf('%d ', b:coc_line_fixes) : ''
endfunction

function! common#functions#CocStatus() abort
    if !common#functions#HasPlug('coc.nvim')
        return ""
    endif
    return coc#status()
endfunction

function! common#functions#FormatBuffer() abort
    " 按 &filetype 选择外部格式化器，格式化整个 buffer。
    " 命令表由 config/format.vim 提供（g:format_cmd_by_ft），%s = 当前文件路径。
    let l:table = get(g:, 'format_cmd_by_ft', {})
    let l:ft    = &filetype
    let l:tpl   = get(l:table, l:ft, '')
    if empty(l:tpl)
        echohl WarningMsg
        echomsg '[format] 未配置格式化器：' . (empty(l:ft) ? '(无 filetype)' : l:ft)
        echohl None
        return
    endif

    " %s -> 当前文件路径（shellescape 防空格/特殊字符；注意内层必须用双引号，
    " 因为单引号字符串里的 '' 是转义引号，写 '%:p' 会被解析成 ':p'）
    let l:cmd = substitute(l:tpl, '%s', '\=shellescape(expand("%:p"))', 'g')
    let l:exe = split(l:cmd)[0]
    if !executable(l:exe)
        echohl WarningMsg
        echomsg '[format] 未安装：' . l:exe . '（已跳过）'
        echohl None
        return
    endif

    let l:input  = join(getline(1, '$'), "\n") . "\n"
    let l:output = systemlist(l:cmd, l:input)
    if v:shell_error != 0 || empty(l:output)
        echohl ErrorMsg
        echomsg '[format] 失败：' . l:exe . ' (exit ' . v:shell_error . ')'
        echohl None
        return
    endif

    " 写回：保持视图与光标，整次格式化算一个 undo 步骤
    let l:view = winsaveview()
    let l:last = line('$')
    silent keepjumps call setline(1, l:output)
    if len(l:output) < l:last
        silent! undojoin
        silent execute (len(l:output) + 1) . ',$delete _'
    endif
    call winrestview(l:view)
    echomsg '[format] ' . l:ft . ' -> ' . l:exe
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" leaf 终端 Markdown 实时预览（RivoLink/leaf，--watch 保存即刷新）
" 快捷键见 config/keymap.vim：<leader>md 开关，<leader>mD 打开后把焦点留在预览窗
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" 记住当前 leaf 预览窗口，供开关复用
let s:leaf_winid = 0

function! s:LeafIsPreviewWin(winid) abort
    " 判断窗口是否是本插件开的 leaf 终端窗口（优先用 job 可执行文件判定，
    " 退化为匹配 buffer 名，兼容没有 jobpid() 的场景）
    if a:winid <= 0 || !win_id2win(a:winid)
        return v:false
    endif
    if !has('terminal')
        return v:false
    endif
    let l:buf = winbufnr(a:winid)
    if getbufvar(l:buf, '&buftype') !=# 'terminal'
        return v:false
    endif
    if exists('*jobpid')
        let l:pid = jobpid(getbufvar(l:buf, '&channel'))
        if l:pid > 0
            return match(system('ps -o comm= -p ' . l:pid), 'leaf') >= 0
        endif
    endif
    return bufname(l:buf) =~# '\v<leaf>( |$)'
endfunction

function! common#functions#LeafPreviewClose() abort
    " 关闭 leaf 预览窗口；没有则返回 0
    if s:LeafIsPreviewWin(s:leaf_winid)
        silent! execute win_id2win(s:leaf_winid) . 'close!'
        let s:leaf_winid = 0
        return 1
    endif
    " 兜底：扫描所有窗口（例如 vim 重开、winid 失效）
    let l:closed = 0
    for l:w in getwininfo()
        if s:LeafIsPreviewWin(l:w.winid)
            silent! execute l:w.winnr . 'close!'
            let l:closed = 1
        endif
    endfor
    let s:leaf_winid = 0
    return l:closed
endfunction

function! common#functions#LeafPreviewToggle(...) abort
    " 开关式 leaf 预览。参数：'keepfocus' = 打开后焦点留在预览窗（默认回到编辑窗）
    let l:keepfocus = a:0 > 0 && a:1 ==# 'keepfocus'

    if s:LeafIsPreviewWin(s:leaf_winid)
        call common#functions#LeafPreviewClose()
        echomsg '[leaf] 预览已关闭'
        return
    endif

    if !executable('leaf')
        echohl WarningMsg
        echomsg '[leaf] 未找到 leaf 可执行文件（应位于 ~/.local/bin/leaf）'
        echohl None
        return
    endif

    let l:file = expand('%:p')
    if empty(l:file)
        echohl WarningMsg
        echomsg '[leaf] 当前 buffer 没有文件名，先 :w 保存'
        echohl None
        return
    endif
    if &modified
        silent! write
    endif

    " 注意：:terminal 不像 :! 那样走 shell 解析，单引号会被原样传给 leaf，
    " 所以这里不能用 shellescape()（它会生成 '...' 导致 leaf 报
    " "Not a valid file"）；改为把路径放进 bash -c 的双引号里，只转义 bash 特殊字符
    let l:escaped = escape(l:file, '\$`"')

    let l:width  = get(g:, 'leaf_preview_width', 90)
    let l:editor = win_getid()

    " 先切窗口、立刻记录 winid：中间任何 BufEnter 自动命令报错都不会让状态残留。
    " try 只包住"建窗口 + 起进程"这一段：其他自动命令（LeaderF/wakatime 等）的报错
    " 不该被当成启动失败而把已经开好的预览窗回收掉
    try
        execute 'vertical botright split | vertical resize ' . l:width
        let s:leaf_winid = win_getid()
        execute 'terminal ++curwin bash -c "leaf -w \"' . l:escaped . '\""'
    catch
        " 命令本身失败（例如 leaf 不在 PATH）时回收窗口，避免留下空终端
        if s:LeafIsPreviewWin(s:leaf_winid)
            silent! execute win_id2win(s:leaf_winid) . 'close!'
        endif
        let s:leaf_winid = 0
        echohl ErrorMsg
        echomsg '[leaf] 启动失败：' . v:exception
        echohl None
        return
    endtry

    " 以下步骤失败不影响预览本身，各自吞掉异常即可
    silent! setlocal nonumber norelativenumber nolist wrap

    " 进终端模式需要先切插入模式，否则显示空白
    silent! startinsert

    if !l:keepfocus
        " 焦点回编辑窗口；leaf 在后台继续 watch，:w 后自动刷新
        silent! call win_gotoid(l:editor)
    endif
    echomsg '[leaf] 预览已开启（保存自动刷新；' . (l:keepfocus ? '<Esc> 退出终端模式' : 'Ctrl+w h 回编辑窗') . '）'
endfunction
