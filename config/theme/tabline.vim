" 自定义 tabline（有状态栏插件则跳过）
if common#functions#HasPlug('vim-crystalline')
    \ || common#functions#HasPlug('lightline.vim')
    \ || common#functions#HasPlug('vim-airline')
    \ || common#functions#HasPlug('lualine.nvim')
    finish
endif
set showtabline=2
