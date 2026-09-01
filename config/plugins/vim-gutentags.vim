" gutentags：自动管理 ctags
let g:gutentags_modules = ['ctags']
let g:gutentags_ctags_executable = '/usr/bin/ctags'
let g:gutentags_project_root = ['.git','.svn','.project','.root']
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags
if !isdirectory(s:vim_tags)
    silent! call mkdir(s:vim_tags)
endif
let g:gutentags_ctags_extra_args = ['-e', '--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--kinds-C=+px']
let g:gutentags_ctags_extra_args += ['--kinds-C++=+px']
