" coc 插件配置（保留并强化，去掉了 coc-fzf / vim-visual-multi 等未启用项）
" 保留默认 coc_data_home（~/.config/coc），避免重新下载已装的 coc 扩展
let g:coc_config_home = g:other_config_root_path

" tab 触发补全或选择下一个。
" 行首 / 光标前是空白字符 → 返回 "\<TAB>"（配合 expandtab+softtabstop 插入 4 空格缩进）；
" 光标紧跟单词后 → 触发 coc 补全。
" 判断用 autoload 函数 common#functions#CheckBackSpace() 而非 s: 脚本函数或内联表达式：
" 1) <SID> 会在映射建立时固化成 <SNR>xxx_，配置重复 source 后函数 SID 变化，旧映射
"    指向已不存在的函数，行首按 Tab 报 E117: Unknown function；
" 2) vim 脚本里 '|' 是命令分隔符，内联写 || 会把映射 RHS 从第一个 '|' 处截断。
inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<c-n>" :
    \ common#functions#CheckBackSpace() ? "\<TAB>" :
    \ coc#refresh()
inoremap <silent><expr> <S-TAB>
    \ pumvisible() ? "\<C-p>" :
    \ "\<C-h>"
inoremap <silent><expr> <m-j>
    \ pumvisible() ? "\<C-n>" : "\<C-R>=coc#rpc#request('snippetNext', [])\<cr>"
inoremap <silent><expr> <m-k>
    \ pumvisible() ? "\<C-p>" : "\<C-R>=coc#rpc#request('snippetPrev', [])\<cr>"
inoremap <silent><expr> <down> pumvisible() ? "\<C-n>" : "\<down>"
inoremap <silent><expr> <up>   pumvisible() ? "\<C-p>" : "\<up>"

if common#functions#HasCocPlug('coc-snippets')
    let g:coc_snippet_next = '<m-j>'
    let g:coc_snippet_prev = '<m-k>'
endif

" 回车选中或扩展选中的补全
if exists('*complete_info')
    inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
    inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" diagnostic 跳转
nmap <silent> <M-j> <Plug>(coc-diagnostic-next)
nmap <silent> <M-k> <Plug>(coc-diagnostic-prev)
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" 跳转定义/类型/实现/引用
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <plug>(coc-type-definition)
nmap <silent> gi <plug>(coc-implementation)
nmap <silent> gr <plug>(coc-references)

" 重构/修复/重命名
nmap <silent> <leader>rf <Plug>(coc-refactor)
nmap <silent> <leader>qf <Plug>(coc-fix-current)
nmap <silent> <leader>rn <Plug>(coc-rename)

" 使用 K 悬浮显示定义
function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction
nnoremap <silent> K :call <SID>show_documentation()<CR>
" 签名帮助
nnoremap <silent> <leader>k :call CocActionAsync('showSignatureHelp')<CR>

" 格式化：统一走 config/format.vim 的 :Format / <leader>f（按 filetype 调外部格式化器）

" 函数/类文本对象（无 treesitter 时用 coc）
if !common#functions#HasPlug('nvim-treesitter')
    xmap if <Plug>(coc-funcobj-i)
    omap if <Plug>(coc-funcobj-i)
    xmap af <Plug>(coc-funcobj-a)
    omap af <Plug>(coc-funcobj-a)
    xmap ic <Plug>(coc-classobj-i)
    omap ic <Plug>(coc-classobj-i)
    xmap ac <Plug>(coc-classobj-a)
    omap ac <Plug>(coc-classobj-a)
endif

" CocList 相关（与原来一致，使用空格前缀）
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
nnoremap <silent> <space>o  :<C-u>CocList --auto-preview outline<cr>
nnoremap <silent> <space>O  :<C-u>CocList --auto-preview --interactive symbols<cr>
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
nnoremap <silent> <space>l  :<C-u>CocList<CR>
