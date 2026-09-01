" LeaderF 配置（保留原 gtags 配置 + 增强）
highlight Lf_hl_rgHighlight guifg=#FFFF00 guibg=NONE ctermfg=yellow ctermbg=NONE
highlight Lf_hl_match gui=bold guifg=Red cterm=bold ctermfg=21
highlight Lf_hl_matchRefine  gui=bold guifg=Magenta cterm=bold ctermfg=201

" 原配置
let g:Lf_RootMarkers = ['.git', '.svn', '.project', '.root']
let g:Lf_GtagsAutoGenerate = 1
let g:Lf_GtagsAutoUpdate = 1
let g:Lf_StlSeparator = { 'left': "\ue0b0", 'right': "\ue0b2" }
let g:Lf_WindowHeight = 0.3
let g:Lf_HideHelp = 1
let g:Lf_ShowRelativePath = 1

" 增强
let g:Lf_NoChdir = 1
let g:Lf_UseCache = 0
let g:Lf_UseVersionControlTool = 0
let g:Lf_IgnoreCurrentBufferName = 1
let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewInPopup = 1
let g:Lf_PreviewResult = {'Function': 0, 'BufTag': 0 }

" 快捷键
nnoremap <M-f> :LeaderfFile<CR>
nnoremap <M-F> :LeaderfFile $HOME<CR>
nnoremap <M-s> :Leaderf rg<CR>
nnoremap <M-b> :LeaderfBuffer<CR>
nnoremap <M-c> :LeaderfCommand<CR>
nnoremap <M-t> :LeaderfBufTag<CR>
nnoremap <M-T> :LeaderfBufTagAll<CR>
nnoremap ?     :LeaderfLineAll<CR>
nnoremap <M-r> :LeaderfMru<CR>
nnoremap <M-w> :LeaderfWindow<CR>
