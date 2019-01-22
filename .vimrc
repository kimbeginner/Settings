

set nocompatible              " be iMproved, required
filetype off                  " required

"set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
"
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}
" " All of your Plugins must be added before the following line
"Gitae's plugin
Plugin 'The-NERD-tree'
Plugin 'taglist-plus'
Plugin 'cscope_plus.vim'
Plugin 'Source-Explorer-srcexpl.vim'
Plugin 'AutoComplPop'
Plugin 'altercation/vim-colors-solarized'
Plugin 'nanotech/jellybeans.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
"Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'JazzCore/ctrlp-cmatcher'
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just
" :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to
"auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
syntax on
"-----------------------------------------------------------------------"
"" color scheme
"-----------------------------------------------------------------------"
colorscheme jellybeans

"-----------------------------------------------------------------------"
"" ctags database path
"-----------------------------------------------------------------------"
if filereadable("./tags")
    set tag=./tags;
endif
"-----------------------------------------------------------------------"
"" NERDTree 
"-----------------------------------------------------------------------"
map <F8> :NERDTreeToggle<CR>
let g:NERDTreeWinSize = 40

"-----------------------------------------------------------------------"
"" Tag List
"-----------------------------------------------------------------------"
nmap <F7> :TlistToggle<CR>
"let Tlist_Inc_Winwidth = 0
let Tlist_Use_Right_Window = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_Auto_Open = 0
let s:auto_width = 0
let Tlist_WinWidth=60
"-----------------------------------------------------------------------"
"" CScope
"-----------------------------------------------------------------------"
set csto=0 "cscope DB search first
set cst "cscope DB tag DB search
set csverb

"deffinetion
nmap <c-g><c-g> :cs find g <c-r>=expand("<cword>")<cr><cr>
nmap <s-g><s-g> :vert scs find g <c-r>=expand("<cword>")<cr><cr>
"called
nmap <c-c><c-c> :cs find c <c-r>=expand("<cword>")<cr><cr>
nmap <s-c><s-c> :cs find c <c-r>=expand("<cword>")<cr><cr>
"text
nmap <c-t><c-t> :cs find t <c-r>=expand("<cword>")<cr><cr>
nmap <s-t><s-t> :cs find t <c-r>=expand("<cword>")<cr><cr>

"map <F5> :!cscope -Rb<CR>:cs reset<CR><CR>

function! LoadCscope()
    let db = findfile("cscope.out", ".;")
    if (!empty(db))
        let path = strpart(db, 0, match(db, "/cscope.out$"))
        set nocscopeverbose " suppress 'duplicate connection' error
        exe "cs add " . db . " " . path
        set cscopeverbose
    endif
endfunction
au BufEnter /* call LoadCscope()

"cs add cscope.out    "~/.vim/plugin/cscope_map.vim에 이 코드가 있음
"cs add cscpoe.out
"-----------------------------------------------------------------------"
"vim-airline
"-----------------------------------------------------------------------"
let g:airline#extensions#tabline#enabled = 1              " vim-airline 버퍼 목록 켜기
let g:airline#extensions#tabline#fnamemod = ':t'          " vim-airline 버퍼 목록 파일명만 출력
let g:airline#extensions#tabline#buffer_nr_show = 1       " buffer number를 보여준다
let g:airline#extensions#tabline#buffer_nr_format = '%s:' " buffer number format

"-----------------------------------------------------------------------"
"ctrlp
"-----------------------------------------------------------------------"
"파일 검색 플러그인.
"ctrl + p로 동작시키며, 파일 이름을 입력시 가장 유사한 리스트를 보여줌
"제외될 경로 내지는 파일 형식 지정
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.doc,tags,*.xls,cscope*.*,*.d,*.o
let g:ctrlp_custom_ignore = {
            \ 'dir': '.git$\|.hg$\|.svn$\|./release$\|Amboot$\|Kernel\|RootFS$\|Packages$\|script$\|SDK$',
            \ 'file': '.inc'
            \ }
let g_ctrlp_user_command = 'find %s -type f'
let g_ctrlp_match_func = {'match' : 'matcher#cmatch' }
"F4를 누르면 해당 파일과 대응하는 cpp/h 파일로 전환
map <F4> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>

"redo
map <c-u> <c-R>

"home
map <c-h> <Home>
"end
map <c-l> <End>
"page up
map <c-k> <PageUp>
"page down
map <c-j> <PageDown>

set autoindent                              " 자동으로 들여쓰기를 한다."
set cindent                                 " C 프로그래밍을 할때 자동으로 들여쓰기를 한다."
set smartindent                             " 좀더 똑똑한 들여쓰기를 위한 옵션이다. "
"set nowrapscan                              " 검색할 때 문서의 끝에서 다시 처음으로 돌아가지 않는다."
set nobackup                                " 백업 파일을 만들지 않는다."
"set visualbell                              " 키를 잘못눌렀을 때 삑 소리를 내는 대신 번쩍이게 한다."
"set ruler                                   " 화면 우측 하단에 현재 커서의 위치(줄,칸)를 보여준다."
set tabstop=4                               " Tab을 눌렀을 때 8칸 대신 4칸 이동하도록 한다."
set shiftwidth=4                            " 자동 들여쓰기를 할때 4칸 들여쓰도록 한다."
set number                                  " 행번호를 사용한다."
set fencs=utf-8,euc-kr,cp949       " 한글 파일은 euc-kr로 읽어들이며,유니코드는 유니코드로 읽음 설정"
set fileencoding=utf-8                     " 실제로 파일을 저장할때 사용되는 인코딩은 euc-kr"
set expandtab                               " 탭을 입력하면 공백문자로 변환하는 기능을 설정"
set hlsearch                                " 검색어를 구문강조해주는 기능"
set ignorecase                              " 검색할 때 대소문자 무시하도록 하는 것."
"set title                                   " 타이틀바에 현재 편집중인 파일을 표시"
set ai                                      " 자동행
set si                                      " if문 다음에 자동으로 맞추어주기
set mouse=a                                 " 마우스 입력을 받아들임
set backspace=2                             " 최신 vim에서 backspace가 동작하지 않는 문제 수정"
