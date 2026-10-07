" ============================================================
" LSP 语法纠错 / 补全：coc.nvim
" ============================================================
" 「像 VSCode 一样报语法错」= VSCode 同源的 LSP 引擎 + 各语言服务器。
" coc.nvim 就是 Vim 上的这个引擎；本文件负责声明要装哪些语言服务器。
Plug 'neoclide/coc.nvim', { 'branch': 'release' }

" 自动安装的语言服务器扩展（装到 g:coc_data_home，默认 ~/.config/coc/extensions）
" 缺哪个装哪个，已装的不会重复下载；不要的直接删掉对应行即可。
" 想看更多可用的：:CocList marketplace
"
" 各扩展对应语言：
"   coc-tsserver     TypeScript / JavaScript（类型错 + 语法错）
"   coc-pyright      Python
"   coc-clangd       C / C++（用系统已装的 clangd）
"   coc-json         JSON
"   coc-yaml         YAML
"   coc-sh           Shell（自带 bash-language-server）
"   coc-vimlsp       Vim script
"   coc-lists        CocList 数据源（<space>a 诊断列表 / <space>l）
"   coc-snippets     片段（配合 <m-j>/<m-k>）
"   coc-diagnostic   光标所在行的悬浮诊断
"   coc-highlight    同名符号高亮 + 颜色预览
"   coc-marketplace  在 Vim 内浏览 / 安装更多扩展
"
" 注意：下面这个续行列表**不能写行尾 " 注释**——在续行的表达式里 " 会被当成
" 字符串起始，整个列表会解析失败并报 E696 Missing comma in List。
" 所以对照表只能像上面那样单独写成注释行。
let g:coc_global_extensions = [
    \ 'coc-tsserver',
    \ 'coc-pyright',
    \ 'coc-clangd',
    \ 'coc-json',
    \ 'coc-yaml',
    \ 'coc-sh',
    \ 'coc-vimlsp',
    \ 'coc-lists',
    \ 'coc-snippets',
    \ 'coc-diagnostic',
    \ 'coc-highlight',
    \ 'coc-marketplace',
    \ ]
