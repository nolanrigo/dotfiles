{ pkgs, config, ... }:
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    withNodeJs = true;

    plugins = with pkgs.vimPlugins; [
      nerdtree
      nerdtree-git-plugin
      base16-vim
      vim-gitgutter
      vim-fugitive
      vim-surround
      vim-airline
      vim-airline-themes
      editorconfig-vim
      ale
      vim-polyglot
      coc-nvim
      ctrlp-vim
      Rename
    ];

    extraConfig = ''
      syntax on
      set termguicolors
      colorscheme base16-${config.home.sessionVariables.COLORTHEME}

      set mouse=a
      set encoding=utf-8                                                        " Set default encoding to UTF-8
      set backspace=indent,eol,start                                            " Makes backspace key more powerful.
      set splitbelow                                                            " Horizontal split below current.
      set splitright                                                            " Vertical split to right of current.
      set noerrorbells                                                          " No beeps
      set noswapfile                                                            " Don't use swapfile
      set nobackup                                                              " Don't create annoying backup files
      set nowritebackup
      set autoread                                                              " Automatically reread changed files without asking me anything
      set noshowmode                                                            " Disable double insert
      set laststatus=2                                                          " Space for status line
      set fileformats=unix,dos,mac                                              " Prefer Unix over Windows over OS 9 formats
      set incsearch                                                             " Shows the match while typing
      set ignorecase                                                            " Search case insensitive...
      set smartcase                                                             " ... but not when search pattern contains upper case characters
      set autoindent
      set hlsearch                                                              " Highlight found searches
      set tabstop=2 shiftwidth=2 expandtab
      set gdefault                                                              " Use 'g' flag by default with :s/foo/bar/.
      set magic                                                                 " Use 'magic' patterns (extended regular expressions).
      set number
      set relativenumber
      set nowrap
      set list
      set smarttab
      set colorcolumn=80
      set expandtab
      set hidden
      set cmdheight=2
      set signcolumn=yes
      set nopaste

      let $NVIM_TUI_ENABLE_TRUE_COLOR=1

      " Coc configuration
      let g:coc_global_extensions = [ 'coc-highlight', 'coc-svg', 'coc-css', 'coc-tailwindcss',  'coc-html', 'coc-tsserver', 'coc-json' ]
      " Unused coc plugins: 'coc-pairs'

      set updatetime=300
      set shortmess+=c

      inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()
      inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
      function! s:check_back_space() abort
        let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~# '\s'
      endfunction

      inoremap <silent><expr> <c-space> coc#refresh()

      " Buffer
      map <C-H> :bnext<CR>
      map <C-L> :bprevious<CR>
      map <C-W> :bdelete<CR>

      " Ctrl-L to clear search
      map <C-C> :nohlsearch<CR>
      map <F2> :NERDTreeToggle<CR>
      map <F5> :NERDTreeRefreshRoot<CR>:CtrlPClearCache<CR>                     " Clear

      " Elm
      let g:polyglot_disabled = [ 'elm' ]                                       " Disable elm on polyglot

      " Airline
      let g:airline_theme='${config.home.sessionVariables.COLORTHEME}'
      let g:airline_powerline_fonts=1
      let g:airline#extensions#tabline#enabled = 1
      let g:airline#extensions#tabline#left_sep = ' '
      let g:airline#extensions#tabline#left_alt_sep = '|'
      let g:airline#extensions#tabline#right_sep = ' '
      let g:airline#extensions#tabline#right_alt_sep = '|'
      let g:airline_left_sep = ' '
      let g:airline_left_alt_sep = '|'
      let g:airline_right_sep = ' '
      let g:airline_right_alt_sep = '|'

      " ALE Config
      let g:ale_fixers = {
      \   '*': ['trim_whitespace'],
      \   'javascript': ['prettier', 'eslint'],
      \   'typescript': ['prettier', 'eslint'],
      \   'css': ['prettier'],
      \   'html': ['prettier'],
      \   'markdown': ['prettier'],
      \   'json': ['prettier'],
      \}
      let g:ale_linters_explicit = 1
      let g:ale_sign_column_always = 1
      let g:ale_sign_error = ''
      let g:ale_sign_warning = ''
      let g:ale_fix_on_save = 1
      let g:airline#extensions#ale#enabled = 1

      " Ctrl Config
      let g:ctrlp_custom_ignore = 'node_modules\|git\|elm-stuff\|dist\|.cache\|cdk.out'
    '';
  };

  home.file = {
    ".config/nvim/coc-settings.json".text = builtins.toJSON {
      "tsserver.enableJavascript" =  false;
      "tsserver.implicitProjectConfig.checkJs" = true;
    };
  };

}
