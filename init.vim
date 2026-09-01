" ============================================================
" vime-style entry (init.vim) — vimrc -> ./init.vim
" ============================================================

" 配置根目录：解析符号链接，指向真实位置（避免 $MYVIMRC 停留在 ~/.vimrc）
let g:vim_root_path         = fnamemodify(resolve(expand('<sfile>')), ':h') . '/'
let g:config_root_path      = g:vim_root_path . 'config/'
let g:plugins_config_root_path = g:config_root_path . 'plugins/'
let g:other_config_root_path   = g:config_root_path . 'other/'
let g:scripts_root_path        = g:vim_root_path . 'scripts/'

" 让配置根目录进入 runtimepath，使 autoload/plugin/ftplugin 生效
execute 'set runtimepath+=' . fnameescape(g:vim_root_path)
" 让 ~/.vim 进入 rtp（保证 vim-plug 的 autoload/plug.vim 在 nvim 下也能找到）
execute 'set runtimepath+=~/.vim'

" 定义载入配置命令
command! -nargs=1 LoadScript exec 'source ' . g:config_root_path . '<args>'

" 载入用户全局配置（目录/缓存/撤销等路径）— config.vim 位于仓库根目录
exec 'source ' . g:vim_root_path . 'config.vim'

" 载入基础配置
LoadScript base.vim

" vim-plug 载入插件
call plug#begin(get(g:, 'plugins_install_path', '~/.vim/plugged'))
LoadScript layers.vim
call plug#end()

" 载入快捷键配置
LoadScript keymap.vim

" 载入主题配置
LoadScript theme/theme.vim
LoadScript theme/statusline.vim
LoadScript theme/tabline.vim

" 依据插件名字载入对应的插件配置
function! s:source_config(plugName) abort
    let l:config_path = g:plugins_config_root_path . a:plugName . '.vim'
    if filereadable(l:config_path)
        exec 'source' fnameescape(l:config_path)
    endif
endfunction

for [plugName, _] in items(g:plugs)
    if common#functions#HasInstall(plugName)
        call s:source_config(plugName)
    endif
endfor
