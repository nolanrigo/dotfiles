{ config, pkgs, ... }: {
  home-manager.users.${config.user.name} = {
    programs.neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      coc = {
        enable = true;
      };
      plugins = with pkgs.vimPlugins; [
        # General
        vim-surround
        vim-commentary

        # Theme
        dracula-vim
        vim-airline
        vim-airline-themes

        # Syntax
        vim-polyglot

        # Formater
        editorconfig-vim
        vim-prettier

        # Node.js
        vim-prisma

        # Git
        vim-gitgutter

        # File
        telescope-nvim
          nvim-treesitter

        # Coc
        coc-tsserver
        coc-json
        coc-explorer

        # Copilot
        copilot-vim

        # Database
        vim-dadbod
        vim-dadbod-ui
        vim-dadbod-completion
      ];

      extraConfig = ''
        syntax on
        set termguicolors
        colorscheme dracula

        " Sensible (but manual)
        set number relativenumber
        set nopaste
        set clipboard=unnamedplus
        set colorcolumn=80
        let mapleader=","
        set expandtab shiftwidth=2
        set list listchars=tab:▸▸,trail:·
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
        set gdefault                                                              " Use 'g' flag by default with :s/foo/bar/.
        set magic                                                                 " Use 'magic' patterns (extended regular expressions).
        set nowrap
        set smarttab
        set hidden
        set cmdheight=2
        set signcolumn=yes

        let $NVIM_TUI_ENABLE_TRUE_COLOR=1

        set updatetime=300
        set shortmess+=c

        " Enter to autocomplete
        set completeopt=longest,menuone
        inoremap <silent><expr> <c-space> coc#refresh()
        inoremap <silent><expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<CR>"

        " Buffer
        map <C-J> <cmd>bnext<cr>
        map <C-K> <cmd>bprevious<cr>
        map <C-H> <cmd>tabprevious<cr>
        map <C-L> <cmd>tabnext<cr>

        " Inverse () to )(
        nnoremap ( )
        vnoremap ( )
        nnoremap ) (
        vnoremap ) (

        " Airline
        let g:airline_theme='dracula'
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

        " Prettier
        let g:prettier#autoformat = 0 " disable format on save
        let g:prettier#autoformat_require_pragma = 0
        let g:prettier#autoformat_config_present = 0 " disable format on save

        " shortcuts
        let mapleader = " "

        " Explorer
        nnoremap <leader>ff <cmd>Telescope find_files<cr>
        nnoremap <leader>fg <cmd>Telescope live_grep<cr>
        nnoremap <leader>fb <cmd>Telescope buffers<cr>
        nnoremap <leader>fh <cmd>Telescope help_tags<cr>
        nnoremap <leader>fe <cmd>CocCommand explorer --position=floating --toggle --no-quit-on-open --sources=file+ <cr>

        " Search
        noremap <leader>sx <cmd>nohlsearch<cr>

        " Prettier
        nnoremap <leader>pp <cmd>PrettierAsync<cr>

        " Copilot
        " let g:copilot_node_command = "${pkgs.nodejs}/bin/node"
      '';
    };
  };
}
