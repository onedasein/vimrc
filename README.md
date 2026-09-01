# vime 使用指南（Vim / Neovim）
> 本指南对应 ~/dotfiles 下的 vime 风格模块化配置：
> 由上游 fgheng/vime 项目改造而来，保留了你原有的
> tokyonight 主题 / LeaderF 检索 / gutentags 标签 / coc 补全 / airline 状态栏 等插件，
> 采用 vime 的 config/ + layers/ + plugins/ 分层结构。
> 入口：~/.vimrc -> ~/dotfiles/vimrc -> ./init.vim（Vim 与 Neovim 通用）。

---

## 1. 这是什么

vime 是一个结构化的 (Neo)Vim 配置，核心优势：

1. 结构简单明了：每个插件一个独立配置文件，互不干扰；
2. 增删配置容易：在 config/layers/ 中按图层组合插件，加一行 Plug 即可；
3. 低耦合：单个插件的配置文件可独立拿走复用；
4. 同时兼容 Vim 9+ 与 Neovim。

## 2. 安装与依赖

### 2.1 依赖清单（来自上游 README）

| 依赖 | 用途 | 本机状态 |
| --- | --- | --- |
| vim-plug（~/.vim/autoload/plug.vim） | 插件管理器 | 已装 |
| python3 + neovim 包 | (Neo)Vim 必须 | 已装（0.5.0） |
| nodejs / npm | coc 补全必须 | 已装（v26.5.0 / npm 11.17.0） |
| ripgrep（rg） | 内容检索（LeaderF/fzf 等） | 已装 |
| ctags | gutentags 生成标签 | 已装（/usr/bin/ctags） |
| tmux | tmux 插件（可选） | 已装 |
| neovim-remote（nvr） | LaTeX 反向搜索（可选） | 已装（2.5.1，~/.local/bin/nvr） |
| inkscape-figures | inkscape 绘图插入 LaTeX（可选） | 已装（python 包 inkscapefigures） |
| zathura | PDF 预览（可选） | 已装 |
| inkscape / rofi / xdotool | LaTeX 绘图/预览辅助（可选） | 已装 |
| latexmk / pdflatex（TeX Live） | vimtex 编译（必需） | 未装，见 10.1 |

> 注意：vimtex 编译还需要 TeX Live（latexmk/pdflatex 等），安装命令见第 10.1 节。

### 2.2 安装配置

- 上游方式：git clone https://github.com/fgheng/vime ~/.config/nvim
- 本机方式：配置就在 ~/dotfiles，~/.vimrc 已软链过去，无需 clone。

### 2.3 安装插件

打开 Vim/Neovim 执行：

    :PlugInstall    " 安装所有插件
    :PlugUpdate     " 更新插件
    :PlugClean      " 删除已不在列表中的插件

> 本机 16 个插件均已安装（~/.vim/plugged），执行 :PlugInstall 会显示 Already installed。
> 注意：config.vim 中设置了镜像 URL 格式 g:plug_url_format（ghfast.top 代理），
> 与现有安装一致，请勿删掉，否则 vim-plug 会误判并重新下载。

## 3. 目录结构

    ~/dotfiles/
    ├── init.vim                    # 入口：解析真实根路径、rtp、按序加载各模块
    ├── config.vim                  # 全局路径：缓存/会话/撤销/插件目录、插件镜像
    ├── vimrc -> ./init.vim         # 软链（兼容 $MYVIMRC 习惯）
    ├── autoload/common/functions.vim   # 通用函数库（HasPlug/Wall/MoveTabOrBuf…）
    ├── config/
    │   ├── base.vim                # 基础设置（缩进/行号/剪贴板/持久撤销/折叠…）
    │   ├── keymap.vim              # 与插件无关的全局快捷键
    │   ├── layers.vim              # 图层总开关（决定加载哪些插件组合）
    │   ├── layers/                 # lsp_coc / git / search_leaderf / theme / plugin_list
    │   ├── plugins/                # 每个插件一个配置文件（与插件同名）
    │   ├── other/                  # coc-settings.json 等插件用到的外部文件
    │   └── theme/                  # 主题、状态栏、标签栏
    ├── plugin/                     # 启动自动加载：alt / note / session
    ├── ftplugin/tex.vim            # 按文件类型生效的配置
    └── scripts/preview.sh          # 检索预览脚本

## 4. 插件管理

### 4.1 新增插件

1. 在 config/layers/plugin_list.vim（或对应图层文件）加一行：

       Plug 'user/repo'

2. 打开 Vim 执行 :PlugInstall；
3. 如需自定义配置，在 config/plugins/ 下新建与插件同名的文件
   （插件名含 .vim 时文件名为 名字.vim.vim，如 md-img-paste.vim.vim），
   在其中写配置和快捷键。

### 4.2 移除插件

把 Plug 行注释掉即可（config/plugins/ 下的配置文件可保留，不会加载）。
需要清理磁盘时执行 :PlugClean。

### 4.3 图层开关

config/layers.vim 中的 LoadScript 决定启用哪些图层：

    LoadScript layers/lsp_coc.vim        " LSP/补全（coc）
    LoadScript layers/git.vim            " git（fugitive）
    LoadScript layers/search_leaderf.vim " 检索（LeaderF + gutentags）
    LoadScript layers/theme.vim          " 主题（tokyonight）
    LoadScript layers/plugin_list.vim    " 其余常用插件

## 5. 快捷键速查（实际启用）

> <leader> 默认为反斜杠 \；<M-x> 表示 Alt+x。

### 5.1 基础 & 窗口

| 按键 | 作用 |
| --- | --- |
| Ctrl-w h / j / k / l | 在左/下/上/右侧打开新窗口（分屏） |
| Ctrl-h / j / k / l | 光标移动到左/下/上/右窗口（终端内也有效） |
| Ctrl-w o | 最大化当前窗口 |
| Alt-- / Alt-_ | 窗口上下尺寸变小 / 变大 |
| Alt-( / Alt-) | 窗口左右尺寸变小 / 变大 |
| Alt-q | 关闭当前 buffer（不关窗口） |
| jk | 插入模式下代替 Esc |
| Backspace | 取消搜索高亮 |
| Space Space | 保存当前文件 |
| Alt-x | 用系统默认应用打开当前文件 |
| leader tn / leader tc | 新建 / 关闭 tab |
| leader tt | 新建终端 |
| Alt-L / Alt-H | 当前 tab 右移 / 左移 |
| Alt-l / Alt-h | 上一个 / 下一个 tab（airline tabline） |
| F5 | 编译并运行 C/C++（g++ % -o %< && ./%<） |

> 可选项（默认注释在 config/keymap.vim）：q 关闭窗口（同时 Q 录制宏）、
> <CR> 折叠开关、9 跳到行尾。需要时取消注释即可。

### 5.2 文件树 NERDTree（F2）

| 按键 | 作用 |
| --- | --- |
| F2 | 打开/聚焦文件树 |
| j / k | 下一个 / 上一个节点 |
| h / l | 收起 / 展开节点（文件则打开） |
| L | 递归展开 |
| w / W | 水平 / 垂直分屏打开 |
| t | 新 tab 打开 |
| . | 显示/隐藏隐藏文件 |
| Backspace | 回到上级目录 |
| bb | 进入目录并切换 cwd（或打开文件） |
| yp | 复制当前节点完整路径 |
| J / K | 跳转到下一个 / 上一个兄弟节点 |
| q | 关闭文件树 |

### 5.3 函数列表 Tagbar（F3）

- F3：打开/关闭函数列表（C/C++/Python/JS 等，需 ctags；markdown 由 tagbar-markdown 提供大纲）

### 5.4 补全 / LSP（coc）

| 按键 | 作用 |
| --- | --- |
| Tab / Shift-Tab | 补全下一个 / 上一个，无下拉时按 Tab 触发补全 |
| Enter | 选中补全条目（可扩展则扩展） |
| gd / gy / gi / gr | 定义 / 类型定义 / 实现 / 引用 |
| Alt-j / Alt-k | 下一个 / 上一个错误；插入模式下选择补全/跳转 snippet |
| [g / ]g | 上一个 / 下一个诊断 |
| K | 查看光标处函数文档 |
| leader k | 查看参数帮助（signature help） |
| leader rn | 重命名变量/函数 |
| leader qf | 快速修复当前行诊断 |
| leader rf | 按 LSP 建议重构 |
| :Format | 格式化代码 |
| space a | CocList diagnostics |
| space o / space O | CocList outline / symbols |
| space c | CocList commands |
| space p | 恢复上次 CocList |
| space l | 打开 CocList |
| if/af/ic/ac | 函数/类文本对象（visual/operator 模式） |

> coc 扩展：在 config/layers/lsp_coc.vim 中取消注释 g:coc_global_extensions，
> 或直接 :CocInstall coc-json coc-snippets coc-lists ...

### 5.5 检索（LeaderF + gutentags）

| 按键 | 作用 |
| --- | --- |
| Alt-f | 搜索工程文件 |
| Alt-F | 搜索 HOME 下所有文件 |
| Alt-s | 用 rg 搜索工程内容 |
| Alt-b | 搜索 buffer |
| Alt-c | 搜索命令 |
| Alt-t / Alt-T | 当前文件标签 / 全部文件标签 |
| Alt-r | 最近打开的文件（MRU） |
| Alt-w | 搜索窗口 |
| ? | 模糊搜索当前打开 buffer 的内容 |

- gutentags 会自动为项目生成 ctags（缓存于 ~/.cache/tags），配合 gd/gr 等跳转；
  手动更新：:GutentagsUpdate。

### 5.6 Git（fugitive）

| 按键 | 作用 |
| --- | --- |
| leader gw | 添加当前文件到 index（Gwrite） |
| leader gc | 提交（Git commit） |
| leader gr | 恢复当前文件到上个版本（Gread） |
| leader gl | 提交日志（Git log） |
| leader gg | Git 状态 |
| leader gd | 查看差异（Gvdiffsplit） |
| leader gb | Git blame |

### 5.7 注释（nerdcommenter）

| 按键 | 作用 |
| --- | --- |
| leader cc | 注释/取消注释 |
| leader cu | 取消注释 |
| leader cs | 美观块注释 |
| leader ci | 注释/取消注释（切换） |
| leader cm | 最简注释 |
| leader cl | 按行注释 |
| leader cb | 块注释 |
| leader ca | 切换注释符号 |
| leader cA | 行尾注释并进入插入模式 |
| leader c$ | 从光标注释到行尾 |

### 5.8 终端（floaterm）

| 按键 | 作用 |
| --- | --- |
| F4 | 打开/关闭浮动终端 |
| Alt-= | 开关浮动终端 |
| Alt-+ | 新建浮动终端 |
| 终端内 Alt-h / Alt-l | 上一个 / 下一个浮动终端 |
| 终端内 Esc | 退出终端模式回到 Normal |

### 5.9 折叠

默认启用语法折叠（foldmethod=syntax，初始全部展开）：

| 按键 | 作用 |
| --- | --- |
| zc / zo | 关闭 / 打开光标下折叠 |
| zC / zO | 递归关闭 / 打开 |
| za / zA | 切换 / 递归切换 |
| zm / zM | 逐层 / 全部关闭 |
| zr / zR | 逐层 / 全部打开 |
| zj / zk | 跳到下一个 / 上一个折叠 |

### 5.10 笔记 / 会话 / 杂项

- :Note 要记录的想法 —— 追加一行带时间戳的笔记到 ~/Documents/wiki/quicknote.md
- :NoteOpen —— 打开快速笔记文件
- leader mp —— 浏览器实时预览当前 markdown（markdown-preview.nvim；:MarkdownPreview 开、:MarkdownPreviewStop 关）
- 退出 Vim 自动保存会话（~/.cache/vim/sessions/session_0.vim，滚动保留最近 3 份）
- :h 中文帮助（vimcdoc）

## 6. 主题与显示

- 主题：edge（style=default、斜体、透明背景），配置文件：config/theme/theme.vim
  （原 tokyonight 配置保留在注释中，方便对比/换回，见第 11 章）
- cursorline 高亮当前行；第 80 列竖线 colorcolumn 默认关闭（需要时在 theme.vim 取消注释）
- set list + listchars：显示制表符、行尾 ¬、尾随空格 ·
- 状态栏：airline（Powerline 字体、tabline、窗口号、coc 状态）
- 补全弹窗高度 pumheight=20，Neovim 下 pumblend=20 半透明

## 7. 自定义指南

1. 改快捷键：与插件无关的改 config/keymap.vim；插件相关的改对应 config/plugins/<插件>.vim；
2. 换主题：改 config/theme/theme.vim（改 colorscheme 与主题变量即可）；
3. 加 coc 扩展：config/layers/lsp_coc.vim 的 g:coc_global_extensions 取消注释并增删；
4. 加/减插件：见第 4 节；
5. 改状态栏：airline 配置在 config/plugins/vim-airline.vim；想换 lightline 就
   在 config/layers/plugin_list.vim 加 Plug 'itchyny/lightline.vim' 并启用
   config/plugins/lightline.vim.vim（仓库有示例）。

## 8. 常见问题（FAQ）

- 首次启动提示找不到主题：先 :PlugInstall 再重开（主题随插件安装）。
- :PlugInstall 提示 Invalid URI / 要重装：确认 config.vim 里的
  g:plug_url_format = 'https://ghfast.top/https://github.com/%s.git' 未被删除
  （你的插件是用该镜像装的）。
- Neovim 里找不到 plug#begin：init.vim 已加入 runtimepath+=~/.vim，插件仍装在
  ~/.vim/plugged，无需重新下载。
- tmux 插件：上游仅在 tmux 内启动时才加载；本配置未启用 tmux 插件，需要时在
  config/layers/plugin_list.vim 按上游 README 添加。
- coc 没提示：检查 :CocInstall 是否装了对应语言扩展（如 coc-clangd、coc-json、
  coc-python）；运行 :CocConfig 查看 coc-settings.json（本配置在 config/other/）。
- 撤销历史丢了：本配置开启持久撤销，历史存于 ~/.cache/vim/undo/。
- F1-F4 功能键错乱（变成粘贴/Ex/Replace/插入）：Windows Terminal 发送 ESC O P/Q/R/S（SS3），
  与本机 terminfo 记录的 ESC[11;*~ 不一致；config/base.vim 已强制 t_k1-t_k4 为 SS3 形式，
  修改后需完全重启 Vim。
- vim 和 nvim 同一文件高亮颜色不一致：两个编辑器已统一为同一份 tokyonight 配色与同一份
  C/C++ 语法文件（~/dotfiles/syntax/，源自 vim 9.1）；剩余观感差异几乎都是真彩色渲染问题，
  检查 :echo &termguicolors（应为 1）、终端 $COLORTERM=truecolor、tmux 需加 RGB 覆盖。
- 打开 tex 提示 latexmk is not executable：TeX Live 还没装，见 10.1 安装命令。
- vimtex 提示版本不支持：本配置已将 vimtex 固定到 v2.15（见 10.6），
  兼容 Vim 9.1 / nvim 0.9.5；以后升级编辑器后可去掉 tag 参数换最新版。

## 9. 与上游 vime 的差异

| 功能 | 上游 vime | 本配置 |
| --- | --- | --- |
| 检索 | fzf / clap / coc-lists | LeaderF（保留原设置）+ gutentags |
| 主题 | edge | tokyonight（保留原设置） |
| 状态栏 | lightline | airline（保留原设置） |
| 文件树 | 可选多种 | NERDTree |
| 起始页/session | vim-startify + session | 仅自动保存 session（无起始页） |
| 快速跳转 | easymotion / clever-f | 未启用 |
| 多光标 | vim-visual-multi | 未启用 |
| 笔记 | vimwiki | 未启用（:Note 快速笔记可用） |
| LaTeX | vimtex | 已启用（vimtex + zathura，见第 10 节） |
| 文档生成 | vim-doge | 未启用 |
| 调试 | vimspector | 已启用（默认按键） |

需要把上游的某项功能搬进来时，照第 4 节加插件即可，快捷键可参考上游 README 保持习惯一致。

---

## 10. LaTeX 工作流（vimtex + zathura）

### 10.1 安装 TeX Live（唯一待办）

vimtex 编译依赖 latexmk / pdflatex，系统还没装。执行（体积约 1~2GB）：

    sudo apt-get install -y texlive-latex-base texlive-latex-extra texlive-xetex texlive-fonts-recommended latexmk

装完后打开 tex 文件，vimtex 自动接管编译。

### 10.2 已就位的部分

- 插件：vimtex、tex-conceal 已安装（config/layers/latex.vim）
- 配置：config/plugins/vimtex.vim（zathura 预览、latexmk 编译、TOC、inkscape 绘图、退出自动清理）
- 反向检索：~/.config/zathura/zathurarc（synctex 已开启）
- 文件类型配置：ftplugin/tex.vim（tw=80、自动换行、拼写 en、conceallevel=2）

### 10.3 常用快捷键（vimtex 默认）

| 按键 | 作用 |
| --- | --- |
| \ll | 编译（continuous mode：之后每次 :w 保存自动重新编译并刷新 PDF） |
| \lk（或再次 \ll） | 停止 continuous mode |
| \lv | 打开 PDF；已打开时向前搜索（定位到当前光标位置） |
| \le | 打开/关闭编译报错与警告（quickfix） |
| \lc | 清理编译产生的多余文件 |
| \lt | 打开目录 TOC（Enter 跳转、Space 翻页、q 关闭） |
| \li | 查看项目信息 |
| \lm | 查看 vimtex 内置映射 |
| % | 在 \begin/\end 等定界符之间跳转 |
| Ctrl-i | 插入模式下创建 inkscape 图形并插入（需 inkscape-figures） |

### 10.4 反向检索（PDF -> Vim）

zathura 中按 Ctrl+鼠标左键，跳回 Vim 中对应代码位置：

- 用 gvim 打开文档（推荐），或用 vim --servername VIM 启动后使用
  （zathurarc 中 synctex-editor-command 已配置为 gvim --remote-silent +%l %f）；
- 用 Neovim 时，把 zathurarc 里那行换成 nvr --remote-silent +%l %f（nvr 已装）。

### 10.5 只想当 PDF 阅读器？

zathura 本身就是独立 PDF 阅读器，不依赖 vimtex：

    zathura 文档.pdf

在 tex 文件里直接打开对应 PDF（不编译）也可以：

    :!zathura %:r.pdf &

### 10.6 兼容性说明

当前 vimtex 新版（master）要求 Vim 9.2 / Neovim 0.12.4+，本机是 Vim 9.1 / nvim 0.9.5，
因此本配置把 vimtex **固定到 v2.15**（config/layers/latex.vim 里的 tag 参数），
该版本在 Vim 9.1 与 Neovim 0.9.5 上均已验证可用（b:vimtex 正常初始化）。
config/plugins/vimtex.vim 中的 g:vimtex_version_check = 0 保留作为双保险；
以后升级了 Vim/Neovim，去掉 tag 参数即可换回最新版。

### 10.7 zathura 阅读器速查（zathura 0.5.4 默认键位）

缩放 / 页面适应：

| 按键 | 作用 |
| --- | --- |
| a / s | best-fit（整页适应窗口）/ width（按宽度适应）切换 |
| + / - / = | 放大 / 缩小 / 回到原始 100% |
| zI / zO / z0 | 放大 / 缩小 / 还原 |
| 数字 + = | 缩放到指定百分比，如 150= 即 150% |
| Ctrl+滚轮 | 鼠标缩放 |
| 按住中键拖动 | 平移文档 |

翻页 / 滚动：

| 按键 | 作用 |
| --- | --- |
| J / K 或 PgDn / PgUp | 下一页 / 上一页 |
| h j k l 或方向键 | 左 / 下 / 上 / 右滚动 |
| space / Shift-space / Backspace | 整页向下 / 向上 |
| Ctrl-d / Ctrl-u | 半页向下 / 向上 |
| t / Ctrl-f / Ctrl-b | 整页向下 / 向上 |
| gg / G / nG | 第一页 / 最后一页 / 第 n 页（如 50G） |
| P | 吸附到当前页 |
| H / L | 当前页顶部 / 底部 |
| Ctrl-o / Ctrl-i | 跳转历史后退 / 前进 |

搜索：/ 正向、? 反向、n / N 下一个 / 上一个。

模式与视图：Tab 打开目录索引（索引内 k/j 移动、l 展开、L 全部展开、h 收起、H 全部收起、Enter/space 打开）；d 双页；F5 演示模式；F11 全屏；Ctrl-m 输入栏；Ctrl-n 状态栏。

文档操作：o 打开；R 重新加载；r 旋转 90 度；Ctrl-r 反色（夜间阅读）；f 跟随链接；F 显示链接目标；c 复制链接；mX 设置快速标记、'X 跳转；q 退出。

命令模式（按 : 进入）：open <文件>、close、write [!]、info、print、offset <n>、
bmark / blist / bdelete（书签）、exec <命令>（$FILE/$PAGE/$DBUS 变量）、export、dump。

自定义：~/.config/zathura/zathurarc 中用 set 改选项、map 改按键，详见 man zathurarc；完整手册 man zathura。

---

## 11. 更换主题与配色

### 11.1 主题由哪几个文件决定

| 文件 | 作用 |
| --- | --- |
| config/layers/theme.vim | 主题插件列表（要装哪个主题就在这里加 Plug） |
| config/theme/theme.vim | 真彩色/tmux 修复、光标与显示设置、colorscheme 行、主题专属变量 |
| config/plugins/tokyonight-vim.vim | tokyonight 专属变量（style/italic/transparent） |
| config/plugins/vim-airline.vim | 状态栏主题（g:airline_theme） |

### 11.2 换一个现成主题（以 gruvbox 为例）

1. 在 config/layers/theme.vim 中加一行：

       Plug 'morhetz/gruvbox'

2. 打开 Vim 执行 :PlugInstall；
3. 编辑 config/theme/theme.vim：
   - 注释掉 tokyonight 的三行变量与 colorscheme tokyonight；
   - 改为 colorscheme gruvbox（可按需加主题变量，如 let g:gruvbox_contrast_dark = 'hard'）；
4. 状态栏配色：在 config/plugins/vim-airline.vim 中加 let g:airline_theme = 'gruvbox'；
5. 重启 Vim（或 :source ~/dotfiles/init.vim 后再 :colorscheme gruvbox）。
   vim 与 nvim 共用同一套配置，改一次两边同时生效。

### 11.3 先临时试试（不写死配置）

主题插件装好后，在任意会话里执行 :colorscheme gruvbox 即可立即预览；
满意了再按 11.2 写进配置。

### 11.4 自定义配色（微调某个高亮组）

colorscheme 之后用 :hi 覆盖个别组的颜色（写在 config/theme/theme.vim 的
colorscheme 行之后即可，重启保留）：

    hi Comment guifg=#6b7089 gui=italic
    hi LineNr  guifg=#3b4261 guibg=NONE
    hi Visual  guibg=#3d59a1

- 查某个词属于哪个组：光标放到词上，执行
  :echo synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
- 列出当前所有高亮组：:hi
- 颜色预览：:hi Keyword guifg=#ff00ff

### 11.5 常用主题参考（vime layers/theme.vim 里都列过）

edge（当前默认）、tokyonight、gruvbox / gruvbox-material、onedark、nord、sonokai、
one、ayu、moonfly、srcery、everforest（forest-night 仓库已改名）、PaperColor 等。

### 11.6 注意事项

- 换主题后状态栏（airline）可能还是旧配色：记得设置 g:airline_theme；
- 部分主题有专属变量（gruvbox 的 contrast、sonokai 的 style 等），在其插件配置里设置；
- tokyonight 的透明背景靠 g:tokyonight_transparent_background = 1；其他主题若想透明，
  可加 hi Normal guibg=NONE；
- C/C++ 语法文件在 ~/dotfiles/syntax/（源自 vim 9.1），与主题无关，换主题不受影响；
- 两个编辑器共用配置，改一处两边生效。
