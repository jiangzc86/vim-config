" 使vimrc在保存时自动生效
autocmd! bufwritepost .vimrc source $HOME/.vimrc
set clipboard=unnamed
" vundle 环境设置
set rtp+=~/.vim/bundle/Vundle.vim

"################################### 插件管理 ###################################
" vundle 管理的插件列表必须位于 vundle#begin() 和 vundle#end() 之间
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'tomasr/molokai'
Plugin 'Lokaltog/vim-powerline'
"Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'fatih/vim-go'
Plugin 'SirVer/ultisnips'
Plugin 'ervandew/supertab'
Plugin 'Valloric/YouCompleteMe'
Plugin 'tenfyzhong/CompleteParameter.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'jstemmer/gotags'
Plugin 'majutsushi/tagbar'
Plugin 'ap/vim-buftabline'
" Plugin 'fholgado/minibufexpl.vim'
Plugin 'morhetz/gruvbox'
Plugin 'blueshirts/darcula'
"Plugin 'Yggdroot/LeaderF'
Plugin 'mileszs/ack.vim'
Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plugin 'junegunn/fzf.vim'
Plugin 'inkarkat/vim-mark'
Plugin 'romainl/vim-qf'
Plugin 'tpope/vim-commentary'
" Plugin 'mhinz/vim-startify'
Plugin 'tpope/vim-obsession'
" Plugin 'xolox/vim-misc'
" Plugin 'xolox/vim-session'
call vundle#end()
" 插件列表结束


" p粘贴时不改写缓冲区内容, P行为不变
xnoremap p pgvy

"################################### 主题 ###################################
set mmp=2000 					"设置parser能用的最大Memory
filetype off
filetype plugin indent on
filetype plugin on
let mapleader=";"
set background=dark
set t_Co=256
set term=xterm-256color
set termencoding=utf-8
let g:rehash256 = 1
let g:molokai_original = 1
let g:solarized_termtrans = 1
let g:solarized_contrast = 'high'
let g:solarized_termcolors=256
let g:CSApprox_attr_map = { 'bold' : 'bold', 'italic' : '', 'sp' : '' }
" colorscheme solarized
" colorscheme molokai
" colorscheme darcula
colorscheme gruvbox
let g:gruvbox_contrast_dark='hard'
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

"################################### 设置外观 ###################################
set number                      "显示行号
"set showtabline=0               "隐藏顶部标签栏
set guioptions-=r               "隐藏右侧滚动条
set guioptions-=L               "隐藏左侧滚动条
set guioptions-=b               "隐藏底部滚动条
"set cursorline                  "突出显示当前行
"set cursorcolumn                "突出显示当前列
set langmenu=zh_CN.UTF-8        "显示中文菜单
" 变成辅助 -------------------------------------
syntax enable
syntax on                       "开启语法高亮
set nowrap                      "设置代码不折行
"set fileformat=unix             "设置以unix的格式保存文件
set cindent                     "设置C样式的缩进格式
set tabstop=4                   "一个 tab 显示出来是多少个空格，默认 8
set shiftwidth=4                "每一级缩进是多少个空格
set backspace+=indent,eol,start "set backspace&可以对其重置
set showmatch                   "显示匹配的括号
set scrolloff=5                 "距离顶部和底部5行
set laststatus=2                "命令行为两行
" 其他杂项 -------------------------------------
set mouse=a                     "启用鼠标
set selection=exclusive
set selectmode=mouse,key
set matchtime=5
set ignorecase                  "忽略大小写
set incsearch
set hlsearch                    "高亮搜索项
nnoremap <F3> :noh<CR>
"nnoremap <F3> :set hlsearch!<CR>
set noexpandtab                 "不允许扩展table
set whichwrap+=<,>,h,l
set autoread

map <space> <c-d>

"################################### 窗口分割 ###################################
" 指定屏幕上可以进行分割布局的区域
set splitbelow               " 允许在下部分割布局
set splitright               " 允许在右侧分隔布局

" 组合快捷键：
nnoremap <C-J> <C-W><C-J>    " 组合快捷键：- Ctrl-j 切换到下方的分割窗口
nnoremap <C-K> <C-W><C-K>    " 组合快捷键：- Ctrl-k 切换到上方的分割窗口
nnoremap <C-L> <C-W><C-L>    " 组合快捷键：- Ctrl-l 切换到右侧的分割窗口
nnoremap <C-H> <C-W><C-H>    " 组合快捷键：- Ctrl-h 切换到左侧的分割窗口

"################################### ACK.vim ###################################
nnoremap <leader>a :Ack!<space>
nnoremap <leader>A :Ack!<space>--ignore "*test.go" --go<space>
let g:ackprg = 'ag --nogroup --nocolor --column'
let g:ackhighlight = 1

"################################### qf-vim ###################################
"设置quickfix窗口最大/最小高度
au FileType qf call AdjustWindowHeight(3, 20)
function! AdjustWindowHeight(minheight, maxheight)
	exe max([min([line("$"), a:maxheight]), a:minheight]) . "wincmd _"
endfunction

function! GetBufferList()
  redir =>buflist
  silent! ls!
  redir END
  return buflist
endfunction

function! ToggleList(bufname, pfx)
  let buflist = GetBufferList()
  for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
    if bufwinnr(bufnum) != -1
      exec(a:pfx.'close')
      return
    endif
  endfor
  if a:pfx == 'l' && len(getloclist(0)) == 0
      echohl ErrorMsg
      echo "Location List is Empty."
      return
  endif
  let winnr = winnr()
  exec(a:pfx.'open')
  if winnr() != winnr
    wincmd p
  endif
endfunction

" toggle location list window
nmap <silent> <leader>l :call ToggleList("Location List", 'l')<CR>
" toggle quickfix window
nmap <silent> <leader>q :call ToggleList("Quickfix List", 'c')<CR>

"################################### vim-go ###################################
let g:go_auto_type_info = 1 		"自动显示变量信息
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_function_arguments = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_variable_declarations = 1
let g:go_highlight_variable_assignments = 1
let g:go_highlight_format_strings = 1
set autowrite                 		"编译前自动保存
set updatetime=100                 	"刷新时间
let g:go_auto_sameids = 1 			"自动高亮显示相同变量
let g:go_fmt_command = "goimports"  "自动格式化
let g:go_test_timeout="100s"
"自动格式化代码
"autocmd BufWritePost,FileWritePost *.go silent %!goimports -local aliyun
"显示下一个编译错误
map <C-n> :cnext<CR>
"显示前一个编译错误
map <C-m> :cprevious<CR>
"关闭错误提示窗口
nnoremap <leader>c :cclose<CR>
"编译文件
autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
"测试覆盖率
autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
"运行文件
autocmd FileType go nmap <leader>r  <Plug>(go-run)
"运行测试文件
autocmd FileType go nmap <leader>t  <Plug>(go-test)
"快捷键：显示当前文件中的所有函数
nnoremap <leader>d :GoDecls<CR>
"快捷键：显示当前目录下所有文件的函数
nnoremap <leader>D :GoDeclsDir<CR>
"显示函数信息
autocmd FileType go nmap <Leader>i <Plug>(go-info)

" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

"在*.go与*_test.go文件之间切换
autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')

"################################### YouCompleteme ###################################
"youcompleteme  默认tab  s-tab 和 ultisnips 冲突
" YCM-UltiSnip  ------------------------------
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:ycm_key_invoke_completion = '<C-a>'
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_min_num_of_chars_for_completion = 1
let g:ycm_min_num_identifier_candidate_chars = 1
let g:ycm_seed_identifiers_with_syntax=1	" 开启语义补全
let g:ycm_complete_in_comments = 1			"在注释输入中也能补全
let g:ycm_complete_in_strings = 1			"在字符串输入中也能补全
"设置在下面几种格式的文件上屏蔽ycm
let g:ycm_filetype_blacklist = {
      \ 'tagbar' : 1,
      \ 'nerdtree' : 1,
      \}
set completeopt-=preview
"let g:ycm_add_preview_to_completeopt = 1	" 预览函数
"let g:ycm_autoclose_preview_window_after_insertion = 1	" 退出插入模式后自动关闭预览窗口
"let g:ycm_autoclose_preview_window_after_completion = 1
inoremap <silent><expr> ( complete_parameter#pre_complete("()") 	" 在YCM补全函数后继续补全参数
"smap <c-j> <Plug>(complete_parameter#goto_next_parameter)
"imap <c-j> <Plug>(complete_parameter#goto_next_parameter)
"smap <c-k> <Plug>(complete_parameter#goto_previous_parameter)
"imap <c-k> <Plug>(complete_parameter#goto_previous_parameter)
let g:complete_parameter_use_ultisnips_mapping = 0 					" CompleteParameter 采用和ultisnips一样的按键

"################################### SuperTab ###################################
let g:SuperTabDefaultCompletionType = "<c-n>"


"################################### UltiSnip ###################################
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-k>"
let g:UltiSnipsJumpBackwardTrigger="<c-j>"
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetDirectories=['MyUltiSnips']
let g:UltiSnipsListSnippets="<c-l>"


"################################### NERDTree ###################################
autocmd VimLeave * NERDTreeTabsClose
autocmd VimLeave * NERDTreeClose

" 打开/关闭Nerdtree
map <F4> :NERDTreeToggle<cr>
autocmd BufEnter * lcd %:p:h " 
" Automatically quit vim if NERDTree is last and only buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif 

" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType")  && b:NERDTreeType == "primary") | q | endif

"let g:nerdtree_tabs_open_on_console_startup=1 " 在console的vim上自动打开nerdtree
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ "Unknown"   : "?"
    \ }

function! NERDTreeToggleInCurDir()
  " If NERDTree is open in the current buffer
  "if (exists("t:NERDTreeBufName") && bufwinnr(t:NERDTreeBufName) != -1)
  "  exe ":NERDTreeClose"
  "else
  if (expand("%:t") != '')
    exe ":NERDTreeFind"
  else
    exe ":NERDTreeToggle"
  endif
  "endif
endfunction

" 在NERDTree显示当前打开文件
nnoremap <leader>f :call NERDTreeToggleInCurDir()<cr>
function! AutoNERDTreeFindInCurDir()
  " If NERDTree is open in the current buffer
  "if (exists("t:NERDTreeBufName") && bufwinnr(t:NERDTreeBufName) != -1)
  "  exe ":NERDTreeClose"
  "else
  if (expand("%:t") != '')
    exe ":NERDTreeFind<c-l><cr>"
  else
    exe ":NERDTreeToggle"
  endif
  "endif
endfunction
"autocmd BufWinEnter NERDTreeFind
"autocmd BufWinEnter * AutoNERDTreeFindInCurDir

"################################### CtrlP ###################################
" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

set wildignore+=*/tmp/*,*.so,*.swp,*.zip " 忽略部分文件，加速ctrlp打开速度
let g:ctrlp_user_command = ['.git/', 'git ls-files --cached --others  --exclude-standard %s'] " 加速ctrlp打开速度

"################################### Tagbar ###################################
" 打开/关闭Tagbar
nmap <F8> :TagbarToggle<CR>
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }

"################################### TabLine ###################################
" 快速导航到第几个buffer
nmap <leader>1 <Plug>BufTabLine.Go(1)
nmap <leader>2 <Plug>BufTabLine.Go(2)
nmap <leader>3 <Plug>BufTabLine.Go(3)
nmap <leader>4 <Plug>BufTabLine.Go(4)
nmap <leader>5 <Plug>BufTabLine.Go(5)
nmap <leader>6 <Plug>BufTabLine.Go(6)
nmap <leader>7 <Plug>BufTabLine.Go(7)
nmap <leader>8 <Plug>BufTabLine.Go(8)
nmap <leader>9 <Plug>BufTabLine.Go(9)
nmap <leader>0 <Plug>BufTabLine.Go(10)
nmap <leader>! <Plug>BufTabLine.Go(11)
nmap <leader>@ <Plug>BufTabLine.Go(12)
nmap <leader># <Plug>BufTabLine.Go(13)
nmap <leader>$ <Plug>BufTabLine.Go(14)
nmap <leader>% <Plug>BufTabLine.Go(15)
nmap <leader>^ <Plug>BufTabLine.Go(16)
nmap <leader>& <Plug>BufTabLine.Go(17)
nmap <leader>* <Plug>BufTabLine.Go(18)
nmap <leader>( <Plug>BufTabLine.Go(19)
nmap <leader>) <Plug>BufTabLine.Go(20)
nmap <leader><leader>1 <Plug>BufTabLine.Go(21)
nmap <leader><leader>2 <Plug>BufTabLine.Go(22)
nmap <leader><leader>3 <Plug>BufTabLine.Go(23)
nmap <leader><leader>4 <Plug>BufTabLine.Go(24)
nmap <leader><leader>5 <Plug>BufTabLine.Go(25)
nmap <leader><leader>6 <Plug>BufTabLine.Go(26)
nmap <leader><leader>7 <Plug>BufTabLine.Go(27)
nmap <leader><leader>8 <Plug>BufTabLine.Go(28)
nmap <leader><leader>9 <Plug>BufTabLine.Go(29)
nmap <leader><leader>0 <Plug>BufTabLine.Go(30)
nmap <leader><leader>! <Plug>BufTabLine.Go(31)
nmap <leader><leader>@ <Plug>BufTabLine.Go(32)
nmap <leader><leader># <Plug>BufTabLine.Go(33)
nmap <leader><leader>$ <Plug>BufTabLine.Go(34)
nmap <leader><leader>% <Plug>BufTabLine.Go(35)
nmap <leader><leader>^ <Plug>BufTabLine.Go(36)
nmap <leader><leader>& <Plug>BufTabLine.Go(37)
nmap <leader><leader>* <Plug>BufTabLine.Go(38)
nmap <leader><leader>( <Plug>BufTabLine.Go(39)
nmap <leader><leader>) <Plug>BufTabLine.Go(40)
noremap <silent> <Plug>BufTabLine.Go(-1) :exe 'b'.get(buftabline#user_buffers(),-1,'')<cr>
nmap <leader>- <Plug>BufTabLine.Go(-1)

set hidden
" 前一个buffer
nnoremap <leader>k :bnext<CR>
"nnoremap <C-k> :bnext<CR>
nnoremap <F6> :bnext<CR>
" 后一个buffer
nnoremap <leader>j :bprev<CR>
"nnoremap <C-j> :bprev<CR>
nnoremap <F5> :bprev<CR>
" 删除最后一个buffer
"nnoremap <leader>l :bd#<CR>

let g:buftabline_numbers=2 		"显示buffer序号
"let g:buftabline_separators=1 	"显示buffer分隔符
let g:buftabline_plug_max=40

" 关闭当前buffer
nmap <F7> <Plug>Kwbd

"################################### fzf ###################################
" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

function! s:find_git_root()
  return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction

command! ProjectFiles execute 'Files' s:find_git_root()
" 在project中搜索文件
nnoremap <leader>H :ProjectFiles<CR>
" 在当前目录中搜索文件
nnoremap <leader>h :Files<CR>
" 搜索文件内容
nnoremap <leader>g :Ag<space>

"################################### LeaderF ###################################
"let g:Lf_ShortcutF = '<C-P>'
"let g:Lf_RootMarkers = ['.project', '.project2']
"let g:Lf_WorkingDirectoryMode = 'Ac'
"let g:Lf_ShowRelativePath=0

"################################### vim-mark ###################################
let g:mwDefaultHighlightingPalette = 'maximum' 	" 设置颜色
let g:mwDefaultHighlightingNum = 9 				" 最大mark数
" 清除所有mark
nnoremap <leader>, :MarkClear<CR>

"################################### Ag ###################################
" 带目录的搜索
command! -bang -nargs=+ -complete=dir Rag call fzf#vim#ag_raw(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)


xnoremap <C-x> gc


"
""################################### vim-session ###################################
"let g:session_autoload = 'no'
"let g:session_autosave = 'no'
"nnoremap <leader>s :SaveSession<space>
"nnoremap <leader>o :OpenSession<space>

"" Don't save hidden and unloaded buffers in sessions.
"set sessionoptions-=buffers

