" 全局配置：目录/缓存/撤销等路径
" 说明：根路径由 init.vim 解析符号链接后写入 g:vim_root_path

" 告知 vim-plug 使用镜像格式的 URL（与现有 ~/.vim/plugged 安装保持一致，避免重装）
let g:plug_url_format = 'https://ghfast.top/https://github.com/%s.git'

" vim插件、缓存等数据根目录
let g:cache_root_path = $HOME . '/.cache/vim/'
" 插件安装目录（保留现有 ~/.vim/plugged 安装，避免重复下载）
let g:plugins_install_path = $HOME . '/.vim/plugged/'
" session 保存目录
let g:session_dir = g:cache_root_path . 'sessions/'
" 撤销记录目录
let g:undo_dir = g:cache_root_path . 'undo/'

let g:os   = systemlist('uname -s')[0]
let g:arch = systemlist('uname -m')[0]

" tmux配置目录
let g:tmux_config_path = $HOME . '/.tmux.conf'

" wiki笔记根目录
let g:vimwiki_path = $HOME . '/Documents/wiki/'
let g:quicknote_file = g:vimwiki_path . '/quicknote.md'
