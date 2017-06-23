"========================================
" Basic
"========================================
" Environment {
    " Basics {
    set nocompatible "turnoff its compatibility for vi
    " }
    " Arrow key fix {
        if &term[:4] == "xterm" || &term[:5] == 'screen' || &term[:3] == 'rxvt'
            inoremap <silent> <C-[>OC <RIGHT>
        endif
" }

" General {
    set background=dark " Assume a dark background

    " ToggleBG() {
        function! ToggleBG()
            let s:tbg = &background
            " Inversion
            if s:tbg == "dark"
                set background=light
            else
                set background=dark
            endif
        endfunction
        noremap <leader>bg :call ToggleBG()<CR>
    " }
    " filetype plugin indent on  " how to deal with vundle?
    syntax on
    set mouse=a " automatically enable mouse
    set mousehide " hide mouse while typing
    " scriptencoding utf-8 " doesn't work with syntastic?
    " clipboard() {
    if has('clipboard')
        if has('unnamedplus')  " When possible use + register for copy-paste
            set clipboard=unnamed,unnamedplus
        else         " On mac and Windows, use * register for copy-paste
            set clipboard=unnamed
        endif
    endif
    " }
    " " set auto enter dir
    autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif
    set shortmess+=filmnrxoOtT  " Abbrev. of messages (avoids 'hit enter')
    set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
    " set virtualedit=onemore     " Allow for cursor beyond last character
    set history=1000            " Store a ton of history (default is 20)
    set hidden                  " Allow buffer switching without saving
    " keyword (what does this do?){
        set iskeyword-=.            " '.' is an end of word designator
        set iskeyword-=#            " '#' is an end of word designator
        set iskeyword-=-            " '-' is an end of word designator
    " }

    " Restore Cur {
        function! ResCur()
            if line("'\"") <= line("$")
                silent! normal! g`"
                return 1
            endif
        endfunction

        augroup resCur
            autocmd!
            autocmd BufWinEnter * call ResCur()
        augroup END
    " }
    " Setting up the backup directories {
        set writebackup                  " Backups are nice ...
        if has('persistent_undo')
            set undofile                " So is persistent undo ...
            set undolevels=1000         " Maximum number of changes that can be undone
            set undoreload=10000        " Maximum number lines to save for undo on a buffer reload
        endif

    " }
" }

    autocmd BufWritePre * %s/\s\+$//e "remove trailling space

    set hlsearch
    set relativenumber

    set foldmarker={,} foldlevel=0 foldmethod=syntax

" vim UI {
    " set ruler                   " Show the ruler
    " set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
    " set showcmd                 " Show partial commands in status line and
                                " Selected characters/lines in visual mode
    set laststatus=2                "always show the tab

    set linespace=0                 " No extra spaces between rows
    set showmatch                   " Show matching brackets/parenthesis
    set incsearch                   " Find as you type search
    set winminheight=0              " Windows can be 0 line high
    set ignorecase                  " Case insensitive search
    set smartcase                   " Case sensitive when uc present
    set wildmenu                    " Show list instead of just completing
    set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
    set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
    set scrolljump=5                " Lines to scroll when cursor leaves screen
    set scrolloff=3                 " Minimum lines to keep above and below cursor
    set list
    set listchars=tab:>\ ,trail:-,extends:#,nbsp:.

" }
" Formatting {
    set pastetoggle=<F12>
    set nowrap                      " Do not wrap long lines
    set autoindent                  " Indent at the same level of the previous line
    set shiftwidth=4                " Use indents of 4 spaces
    set expandtab                   " Tabs are spaces, not tabs
    set tabstop=4                   " An indentation every four columns
    set softtabstop=4               " Let backspace delete indent
    set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
    set splitright                  " Puts new vsplit windows to the right of the current
    set splitbelow                  " Puts new split windows to the bottom of the current
" }

    set encoding=utf-8
    set t_Co=256
    set backspace=indent,eol,start
    set nofoldenable
" }
"}

"========================================
" Custom key mapping
"========================================
" Custom_key_mapping{
    " accordion expand traversal of folds
    nnoremap <silent> z] :<C-u>silent! normal! zC<CR>zjzOzz
    nnoremap <silent> z[ :<C-u>silent! normal! zC<CR>zkzO[zzz
    " Leader {
        let mapleader=","
        :nmap <Leader>q :q<CR>
    " }
    " Window {                      "makes it easier to swap between the windows
        :nmap <C-J> <C-W><C-J>_
        :nmap <C-K> <C-W><C-K>_
        :nmap <C-L> <C-W><C-L>_
        :nmap <C-H> <C-W><C-H>_
    " }

    map! <C-[> <ESC>
    map! jk <ESC>
    :nmap <LEADER>s :w<CR>
    nmap <silent><F4> :nohlsearch<CR>
    nmap <silent><F5> :so ~/.vimrc<CR>

    " Wrapped lines goes down/up to next row, rather than next line in file.
    noremap j gj
    noremap k gk

    " Yank from the cursor to the end of the line, to be consistent with C and D.
    nnoremap Y y$

    " Shortcuts
    " Change Working Directory to that of the current file
    cmap cwd lcd %:p:h
    cmap cd. lcd %:p:h

    " Visual shifting (does not exit Visual mode)
    vnoremap < <gv
    vnoremap > >gv

    " Allow using the repeat operator with a visual selection (!)
    " http://stackoverflow.com/a/8064607/127816
    vnoremap . :normal .<CR>

    " Adjust viewports to the same size
    map <Leader>= <C-w>=
" }
"}

"========================================
" Vundle
"========================================
" vundle {
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

" Completion
Plugin 'scrooloose/nerdcommenter'
Plugin 'garbas/vim-snipmate'
" Plugin 'Shougo/neosnippet.vim'
" Plugin 'Shougo/neosnippet-snippets'
" Plugin 'Shougo/neocomplcache'
Plugin 'marcweber/vim-addon-mw-utils' "Dependency for snipmate
Plugin 'tomtom/tlib_vim' "Dependency for snipmate
Plugin 'honza/vim-snippets'
Plugin 'Raimondi/delimitMate'
Plugin 'ervandew/supertab'
Plugin 'tpope/vim-surround'

" Language supports
Plugin 'mattn/emmet-vim'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'scrooloose/syntastic'
Plugin 'plasticboy/vim-markdown'
Plugin 'fmoralesc/vim-tutor-mode'

" Interaction
Plugin 'godlygeek/csapprox'
Plugin 'mbbill/undotree'
Plugin 'easymotion/vim-easymotion'
Plugin 'Chiel92/vim-autoformat'
Plugin 'godlygeek/tabular'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'tacahiroy/ctrlp-funky'
Plugin 'thinca/vim-quickrun'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'jceb/vim-orgmode'
Plugin 'tpope/vim-speeddating' " required by org mode

" Interface
Plugin 'vim-airline/vim-airline'
Bundle 'majutsushi/tagbar'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'flazz/vim-colorschemes'
Plugin 'nathanaelkane/vim-indent-guides'

" To be explored
Plugin 'bling/vim-bufferline'
" Plugin 'osyo-manga/vim-over' " Command line substitute preview



call vundle#end()
filetype plugin indent on
" }
"========================================
" Plugin Config
"========================================
" Plugins {
    "Nerd tree Tabs
    "-----------------
    "{
    let Tlist_Use_Right_Window=1
    map <C-n> :NERDTreeTabsToggle<CR>
    "}

    "Syntasitic
    "-----------------
    "{
        set statusline+=%#warningmsg#
        set statusline+=%{SyntasticStatuslineFlag()}
        set statusline+=%*

        let g:syntastic_python_python_exec='/usr/bin/python3.4'
        let g:syntastic_python_checkers = ['pylint']
        let g:syntastic_error_symbol='✗'
        let g:syntastic_warning_symbol='!'
        let g:syntastic_always_populate_loc_list = 0
        let g:syntastic_auto_loc_list = 0
        "let g:syntastic_loc_list_height= 5

        nnoremap <Leader>sn :lnext<cr>
        nnoremap <Leader>sp :lprevious<cr>
        let g:syntastic_check_on_open = 1
        let g:syntastic_check_on_wq = 0
        let g:ycm_show_diagnostics_ui = 0
    "}

    "Formatter
    "-----------------
    "{
        nmap <F3> :Autoformat<CR>
        let g:formatdef_school = '"astyle --style=kr"'
        let g:formatters_c = ['school']
        let g:formatdef_autopep8 = "'autopep8 - --range '.a:firstline.' '.a:lastline"
        let g:formatters_python = ['autopep8']
    "}

    "Commenter
    "-----------------
    " {
        let g:NERDSpaceDelims=1

        " Use compact syntax for prettified multi-line comments
        let g:NERDCompactSexyComs = 1
        " Align line-wise comment delimiters flush left instead of following code
        " indentation
        let g:NERDDefaultAlign = 'left'
        " Set a language to use its alternate delimiters by default
        let g:NERDAltDelims_java = 1

        " Add your own custom formats or override the defaults
        let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
        " Allow commenting and inverting empty lines (useful when commenting a region)
        let g:NERDCommentEmptyLines = 1
        " Enable trimming of trailing whitespace when uncommenting
        let g:NERDTrimTrailingWhitespace = 1
    " }

    "Colorscheme
    "--------------------
    " {
        " colorscheme 256-jungle
        " colorscheme apprentice
        hi DiffText   cterm=none ctermfg=255 ctermbg=60 gui=none guifg=Black guibg=Red
        hi DiffChange cterm=none ctermfg=255 ctermbg=237 gui=none guifg=Black guibg=LightMagenta
        hi DiffDelete cterm=none ctermfg=255 ctermbg=1 gui=none guifg=fg guibg=Blue
        hi DiffAdd cterm=none ctermfg=255 ctermbg=23 gui=none guifg=fg guibg=Blue
        colorscheme lizard256
        " colorscheme default
        let g:airline_theme='papercolor'
        highlight Comment ctermfg=lightblue
    " }

    "Tagbar
    "--------------------
    " {
        nmap <F8> :TagbarToggle<CR>
    " }

    "ctrlp
    "--------------------
    " {
        let g:ctrlp_map = '<c-p>'
        let g:ctrlp_cmd = 'CtrlP'
        let g:ctrlp_working_path_mod = 'ra'
        set relativenumber
    " }

    "set markdown
    "--------------------
    " {
        let g:vim_markdown_new_list_item_indent = 0

        let g:vim_markdown_math = 1
    " }

    " Indent guide
    "--------------------
    " {
        let g:indent_guides_auto_colors = 0
        let g:indent_guides_guide_size = 1
        let g:indent_guides_soft_pattern = ' '
        hi IndentGuidesOdd  guibg=red   ctermbg=237
        hi IndentGuidesEven guibg=green ctermbg=235
        let g:indent_guides_enable_on_vim_startup = 1

    " }

" }

"{
if &term =~ '256color'
    set t_ut=
endif
"}
