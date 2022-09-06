{ config, pkgs, ... }:

let
  params = import ./params.nix;
in {
  home-manager.users."${params.username}" = {
    # Neovim
    programs.neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      withNodeJs = true;

      coc = {
        enable = true;
        # bug: neovim: rebuilding with coc support does not work when nodejs is in PATH
        # https://github.com/nix-community/home-manager/issues/2966
        # Solution:
        # https://github.com/sumnerevans/home-manager-config/commit/da138d4ff3d04cddb37b0ba23f61edfb5bf7b85e
        package = pkgs.vimUtils.buildVimPluginFrom2Nix {
          pname = "coc.nvim";
          version = "2022-05-21";
          src = pkgs.fetchFromGitHub {
            owner = "neoclide";
            repo = "coc.nvim";
            rev = "791c9f673b882768486450e73d8bda10e391401d";
            sha256 = "sha256-MobgwhFQ1Ld7pFknsurSFAsN5v+vGbEFojTAYD/kI9c=";
          };
          meta.homepage = "https://github.com/neoclide/coc.nvim/";
        };
      };

      plugins = with pkgs.vimPlugins; [
        # copilot-vim FIXME: install the upgraded version of copilot
        vim-prisma
        base16-vim
        vim-gitgutter
        vim-fugitive
        vim-surround
        vim-airline
        vim-airline-themes
        vim-prettier # instead of coc-prettier
        marks-nvim

        telescope-nvim
          nvim-treesitter

        editorconfig-vim
        vim-polyglot
        Rename
        # coc-html
        # coc-css
        # coc-eslint
        # coc-emmet
        # coc-docker
        # coc-graphql
        # coc-sql
        # coc-xml
        # coc-nginx
        # coc-sh

        # Coc plugins
        coc-tsserver
        coc-json
        coc-explorer
      ];

      extraConfig = ''
        syntax on
        set termguicolors
        colorscheme base16-${params.theme.base16-name}

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

        inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
        function! s:check_back_space() abort
          let col = col('.') - 1
          return !col || getline('.')[col - 1]  =~# '\s'
        endfunction

        " Ctrl-space to trigger coc hints
        inoremap <silent><expr> <c-space> coc#refresh()

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
        let g:airline_theme='${params.theme.base16-name}'
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
        nnoremap <leader>pp <cmd>Prettier<cr>
        vnoremap <leader>pp <cmd>'<,'>PrettierPartial<cr>
      '';
    };

    # nvim as "e" fish abbr
    programs.fish.shellAbbrs.e = "nvim";

    # nvim as $EDITOR
    home.sessionVariables.EDITOR = "nvim";
    home.sessionVariables.VISUAL = "nvim";

    # nvim as git editor
    programs.git.extraConfig.core.editor = "nvim";
  };
}

