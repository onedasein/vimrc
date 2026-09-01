" 其余插件
Plug 'yianwillis/vimcdoc'
Plug 'vim-airline/vim-airline'
Plug 'preservim/nerdtree'
Plug 'preservim/tagbar'
Plug 'lvht/tagbar-markdown'
Plug 'ferrine/md-img-paste.vim'
Plug 'voldikss/vim-floaterm'
Plug 'preservim/nerdcommenter'
Plug 'Yggdroot/indentLine'
Plug 'frazrepo/vim-rainbow'
Plug 'puremourning/vimspector'
" markdown 浏览器实时预览（:MarkdownPreview 懒加载）
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown'], 'on': 'MarkdownPreview' }
