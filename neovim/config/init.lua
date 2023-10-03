vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("lazy").setup({
  -- General
  "tpope/vim-surround",
  "tpope/vim-commentary",
  -- colorscheme
  {
    "Mofiqul/dracula.nvim",
    config = function ()
      local dracula = require("dracula")
      local colors = dracula.colors()


      dracula.setup({
        colors = colors,
        show_end_of_buffer = true,
        transparent_bg = true,
        -- lualine_bg_color = dracula.colors().selection,
        italic_comment = true,
      })

      vim.cmd[[colorscheme dracula]]
    end
  },
  {
    'romgrk/barbar.nvim',
    dependencies = {
      'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
      'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
    },
    init = function() vim.g.barbar_auto_setup = false end,
    opts = {
      animation = false,
      auto_hide = true,
    },
    version = '^1.0.0', -- optional: only update when a new 1.x version is released
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
    },
    opts = {
      options = {
        theme = "dracula-nvim";
      },
    },
    config = function ()
      -- Eviline config for lualine
      -- Author: shadmansaleh
      -- Credit: glepnir
      local lualine = require('lualine')
      local colors = require("dracula").colors()

      local conditions = {
        buffer_not_empty = function()
          return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
        end,
        hide_in_width = function()
          return vim.fn.winwidth(0) > 80
        end,
        check_git_workspace = function()
          local filepath = vim.fn.expand('%:p:h')
          local gitdir = vim.fn.finddir('.git', filepath .. ';')
          return gitdir and #gitdir > 0 and #gitdir < #filepath
        end,
      }

      -- Config
      local config = {
        options = {
          -- Disable sections and component separators
          component_separators = '',
          section_separators = '',
          theme = "dracula-nvim",
        },
        sections = {
          -- these are to remove the defaults
          lualine_a = {},
          lualine_b = {},
          lualine_y = {},
          lualine_z = {},
          -- These will be filled later
          lualine_c = {},
          lualine_x = {},
        },
        inactive_sections = {
          -- these are to remove the defaults
          lualine_a = {},
          lualine_b = {},
          lualine_y = {},
          lualine_z = {},
          lualine_c = {},
          lualine_x = {},
        },
      }

      -- Inserts a component in lualine_c at left section
      local function ins_left(component)
        table.insert(config.sections.lualine_c, component)
      end

      -- Inserts a component in lualine_x at right section
      local function ins_right(component)
        table.insert(config.sections.lualine_x, component)
      end

      -- ins_left {
      --   function()
      --     return '▊'
      --   end,
      --   color = { fg = colors.blue }, -- Sets highlighting of component
      --   padding = { left = 0, right = 1 }, -- We don't need space before this
      -- }

      ins_left {
        -- mode component
        function()
          return '▊▊▊'
        end,
        color = function()
          -- auto change color according to neovims mode
          local mode_color = {
            n = colors.purple,
            i = colors.green,
            v = colors.blue,
            [''] = colors.blue,
            V = colors.blue,
            c = colors.magenta,
            no = colors.red,
            s = colors.orange,
            S = colors.orange,
            [''] = colors.orange,
            ic = colors.yellow,
            R = colors.violet,
            Rv = colors.violet,
            cv = colors.red,
            ce = colors.red,
            r = colors.cyan,
            rm = colors.cyan,
            ['r?'] = colors.cyan,
            ['!'] = colors.red,
            t = colors.red,
          }
          return { fg = mode_color[vim.fn.mode()] }
        end,
        padding = { left = 0, right = 1 },
      }

      ins_left {
        -- filesize component
        'filesize',
        cond = conditions.buffer_not_empty,
      }

      ins_left {
        'filename',
        cond = conditions.buffer_not_empty,
        color = { fg = colors.magenta, gui = 'bold' },
      }

      ins_left { 'location' }

      ins_left { 'progress', color = { fg = colors.fg, gui = 'bold' } }

      ins_left {
        'diagnostics',
        sources = { 'nvim_diagnostic' },
        symbols = { error = ' ', warn = ' ', info = ' ' },
        diagnostics_color = {
          color_error = { fg = colors.red },
          color_warn = { fg = colors.yellow },
          color_info = { fg = colors.cyan },
        },
      }

      -- Insert mid section. You can make any number of sections in neovim :)
      -- for lualine it's any number greater then 2
      ins_left {
        function()
          return '%='
        end,
      }

      ins_left {
        -- Lsp server name .
        function()
          local msg = 'No Active Lsp'
          local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
          local clients = vim.lsp.get_active_clients()
          if next(clients) == nil then
            return msg
          end
          for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
              return client.name
            end
          end
          return msg
        end,
        icon = ' LSP:',
        color = { fg = '#ffffff', gui = 'bold' },
      }

      -- Add components to right sections
      ins_right {
        'o:encoding', -- option component same as &encoding in viml
        fmt = string.upper, -- I'm not sure why it's upper case either ;)
        cond = conditions.hide_in_width,
        color = { fg = colors.green, gui = 'bold' },
      }

      ins_right {
        'fileformat',
        fmt = string.upper,
        icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
        color = { fg = colors.green, gui = 'bold' },
      }

      ins_right {
        'branch',
        icon = '',
        color = { fg = colors.violet, gui = 'bold' },
      }

      ins_right {
        'diff',
        -- Is it me or the symbol for modified us really weird
        symbols = { added = ' ', modified = '󰝤 ', removed = ' ' },
        diff_color = {
          added = { fg = colors.green },
          modified = { fg = colors.orange },
          removed = { fg = colors.red },
        },
        cond = conditions.hide_in_width,
      }

      ins_right {
        function()
          return '▊'
        end,
        color = { fg = colors.blue },
        padding = { left = 1 },
      }

      -- Now don't forget to initialize lualine
      lualine.setup(config)
    end,
  },
  -- colors
  {
    "folke/zen-mode.nvim",
    config = function ()
      local zenmode = require("zen-mode")

      vim.keymap.set("n", "<leader>zz", zenmode.toggle);

      zenmode.setup({
        window = {
          backdrop = 0.95, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
          -- height and width can be:
          -- * an absolute number of cells when > 1
          -- * a percentage of the width / height of the editor when <= 1
          -- * a function that returns the width or the height
          width = 120, -- width of the Zen window
          height = 1, -- height of the Zen window
          -- by default, no options are changed for the Zen window
          -- uncomment any of the options below, or add other vim.wo options you want to apply
          options = {
            -- signcolumn = "no", -- disable signcolumn
            -- number = false, -- disable number column
            -- relativenumber = false, -- disable relative numbers
            -- cursorline = false, -- disable cursorline
            -- cursorcolumn = false, -- disable cursor column
            -- foldcolumn = "0", -- disable fold column
            -- list = false, -- disable whitespace characters
          },
        },
        plugins = {
          -- disable some global vim options (vim.o...)
          -- comment the lines to not apply the options
          options = {
            enabled = true,
            ruler = false, -- disables the ruler text in the cmd line area
            showcmd = false, -- disables the command in the last line of the screen
          },
          twilight = { enabled = false }, -- enable to start Twilight when zen mode opens
          gitsigns = { enabled = false }, -- disables git signs
          tmux = { enabled = false }, -- disables the tmux statusline
          -- this will change the font size on kitty when in zen mode
          -- to make this work, you need to set the following kitty options:
          -- - allow_remote_control socket-only
          -- - listen_on unix:/tmp/kitty
          kitty = {
            enabled = false,
            font = "+4", -- font size increment
          },
        },
        -- callback where you can add custom code when the Zen window opens
        on_open = function(win)
        end,
        -- callback where you can add custom code when the Zen window closes
        on_close = function()
        end,
      })
    end,
  },
  {
    "koenverburg/peepsight.nvim",
    config = function ()
      local peepsight = require("peepsight")

      vim.keymap.set("n", "<leader>zh", peepsight.toggle)

      peepsight.setup({
        -- typescript
        "class_declaration",
        "method_definition",
        "arrow_function",
        "function_declaration",
        "generator_function_declaration"
      })
    end,
  },
  -- File
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function () 
      local builtin = require("telescope.builtin")
      local themes = require("telescope.themes")

      -- IMPROVE: use fzf plugin, do I use fzf ?

      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[F]ind exising [F]iles" })
      vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = '[F]ind [D]iagnostics' })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "[F]ind file by [G]rep" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = '[F]ind existing [B]uffers' }) -- vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
      vim.keymap.set("n", "<leader><space>", builtin.buffers, { desc = '[F]ind existing [B]uffers' }) -- vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
      vim.keymap.set("n", "<leader>fs", function ()
        builtin.grep_string({ search = vim.fn.input("Grep > ") })
      end)
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to telescope to change theme, layout, etc.
        require('telescope.builtin').current_buffer_fuzzy_find(themes.get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })
      vim.keymap.set('n', '<leader>fr', require('telescope.builtin').oldfiles, { desc = '[F]ind [R]ecently opened files' })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function ()
      local treesitter = require("nvim-treesitter.configs")

      treesitter.setup({
        ensure_installed = {
          "javascript", "typescript", "tsx", "html", "css", "scss",
          "yaml", "json", "sql", "prisma", "graphql", "dockerfile",
          "gitignore", "gitcommit", "git_rebase", "fish",
          "nix", "c", "lua", "vim", "vimdoc", "query"
        },
        sync_install = false,
        auto_install = true,
        indent = { enable = true },  
        highlight = {
          enable = true,
          -- additional_vim_regex_highlighting = false,
        },
      })
    end,
  },
  {
    "mbbill/undotree",
    config = function ()
      vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
      vim.g.undotree_WindowLayout = 1;
      vim.g.undotree_SetFocusWhenToggle = 1;
      vim.g.undotree_SplitWidth = 50;
    end,
  },
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v2.x",
    dependencies = {
      -- LSP Support
      {"neovim/nvim-lspconfig"},             -- Required
      {"williamboman/mason.nvim"},           -- Optional
      {"williamboman/mason-lspconfig.nvim"}, -- Optional

      -- Autocompletion
      {"hrsh7th/nvim-cmp"},     -- Required
      {"hrsh7th/cmp-nvim-lsp"}, -- Required
      {"L3MON4D3/LuaSnip"},     -- Required
    },
    config = function()
      local lsp = require('lsp-zero')

      lsp.preset('recommended')

      lsp.ensure_installed({
        "tsserver",
        "eslint",
      })

      -- lsp.set_preferences({
      -- sign_icons = {}
      -- })

      -- lsp.on_attach(function(client, bufnr)
        -- local opts = {buffer = bufnr, remap = false}

        -- vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        -- vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
        -- vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
        -- vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
        -- vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
        -- vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
        -- vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
        -- vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
        -- vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
        -- vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
      -- end)

      lsp.setup()
    end,
  },
  {
    "neoclide/coc.nvim",
    branch = "release",
    build = function ()
      vim.cmd[[CocInstall coc-explorer]]
    end,
    config = function ()
      vim.api.nvim_set_keymap('n', '<leader>fe', [[<Cmd>CocCommand explorer --position=floating --toggle --no-quit-on-open --sources=file+ <CR>]], { noremap = true, silent = true })
    end,
  },
  -- INFO: when lua_lsp will work { "folke/neodev.nvim", opts = {}, }
  {
    "elentok/format-on-save.nvim",
    config = function ()
      local format_on_save = require("format-on-save")
      local formatters = require("format-on-save.formatters")
      local message_buffer = require("format-on-save.error-notifiers.message-buffer")

      format_on_save.setup({
        error_notifier = message_buffer,
        experiments = {
          partial_update = 'diff', -- or 'line-by-line'
        },
        exclude_path_patterns = {
          "/node_modules/",
          ".local/share/nvim/lazy",
        },
        formatter_by_ft = {
          css = formatters.lsp,
          html = formatters.lsp,
          java = formatters.lsp,
          javascript = formatters.lsp,
          json = formatters.lsp,
          lua = formatters.lsp,
          markdown = formatters.prettierd,
          openscad = formatters.lsp,
          python = formatters.black,
          rust = formatters.lsp,
          scad = formatters.lsp,
          scss = formatters.lsp,
          sh = formatters.shfmt,
          terraform = formatters.lsp,
          typescript = formatters.prettierd,
          typescriptreact = formatters.prettierd,
          yaml = formatters.lsp,

          -- Add your own shell formatters:
          -- myfiletype = formatters.shell({ cmd = { "myformatter", "%" } }),

          -- Add lazy formatter that will only run when formatting:
          -- my_custom_formatter = function()
          --   if vim.api.nvim_buf_get_name(0):match("/README.md$") then
          --     return prettier
          --   else
          --     return formatters.lsp()
          --   end
          -- end,

          -- Add custom formatter
          -- filetype1 = formatters.remove_trailing_whitespace,
          -- filetype2 = formatters.custom({ format = function(lines)
          --   return vim.tbl_map(function(line)
          --     return line:gsub("true", "false")
          --   end, lines)
          -- end}),

          -- Concatenate formatters
          -- python = {
          --   formatters.remove_trailing_whitespace,
          --   formatters.shell({ cmd = "tidy-imports" }),
          --   formatters.black,
          --   formatters.ruff,
          -- },

          -- Use a tempfile instead of stdin
          -- go = {
          --   formatters.shell({
          --     cmd = { "goimports-reviser", "-rm-unused", "-set-alias", "-format", "%" },
          --     tempfile = function()
          --       return vim.fn.expand("%") .. '.formatter-temp'
          --     end
          --   }),
          --   formatters.shell({ cmd = { "gofmt" } }),
          -- },

          -- Add conditional formatter that only runs if a certain file exists
          -- in one of the parent directories.
          -- javascript = {
          --   formatters.if_file_exists({
          --     pattern = ".eslintrc.*",
          --     formatter = formatters.eslint_d_fix
          --   }),
          --   formatters.if_file_exists({
          --     pattern = { ".prettierrc", ".prettierrc.*", "prettier.config.*" },
          --     formatter = prettier,
          --   }),
          --   -- By default it stops at the git repo root (or "/" if git repo not found)
          --   -- but it can be customized with the `stop_path` option:
          --   -- formatters.if_file_exists({
          --   --   pattern = ".prettierrc",
          --   --   formatter = prettier,
          --   --   stop_path = function()
          --   --     return "/my/custom/stop/path"
          --   --   end
          --   -- }),
          -- },
        },

        -- Optional: fallback formatter to use when no formatters match the current filetype
        fallback_formatter = {
          formatters.remove_trailing_whitespace,
          formatters.remove_trailing_newlines,
          formatters.prettierd,
        },

        -- By default, all shell commands are prefixed with "sh -c" (see PR #3)
        -- To prevent that set `run_with_sh` to `false`.
        run_with_sh = true,
      })
    end,
  },
})

-- Basic settings
vim.o.termguicolors = true -- NOTE: You should make sure your terminal supports this
vim.o.number = true                                     -- show line number
vim.o.relativenumber = true                             -- relative line numbers
vim.o.colorcolumn = 80                                  -- show a colorcolumn at 80 character
vim.o.paste = false                                     -- simplify paste from clipboarrd
vim.o.clipboard = "unnamedplus"                         -- sync OS & vim clipboards
vim.o.shiftwidth = 2                                    -- 2 spaces
vim.o.list = true                                       -- show hiddenchars
vim.o.listchars = "tab:▸▸,trail:·"                      -- select hiddenchars to show and how to show them
vim.o.mouse = "a"                                       -- activate mouse
vim.o.encoding = "utf-8"                                -- default encode file to utf-8
vim.o.backspace = "indent,eol,start"                    -- how backspacing works
vim.o.hlsearch = true                                   -- activate search highlight
  vim.keymap.set("n", "<leader>sx", vim.cmd.nohlsearch) -- clear search highlight
vim.o.errorbells = false                                -- disable error bells
vim.o.splitbelow = true                                 -- the new split window will be below
vim.o.splitright = true                                 -- the new split window will be right
vim.o.autoread = true                                   -- automatically read file that has been edited outside of vim
vim.o.showmode = false                                  -- disable "-- VISUAL" "--INSERT" <-- as we will use lualine
vim.o.laststatus = 2                                    -- influence when the last window will have a status line (2 = always)
vim.o.fileformats = "unix,dos"                          -- use unix end of lines
vim.o.incsearch = true                                  -- show pattern on search command
vim.o.ignorecase = true                                 -- ignore case on search
vim.o.smartcase = true                                  -- when the search contains a caps, the search become case sensitive
vim.o.autoindent = true                                 -- new line indentation follow the previous
vim.o.breakindent = true
-- DEPRECATED: vim.o.gdefault = true
vim.o.magic = true                                      -- change special characters that can be use in search
vim.o.wrap = false                                      -- don't wrap the text
vim.o.hidden = true
vim.o.cmdheight = 1
vim.o.scrolloff = 8                                     -- keep 8 character space when I scroll
vim.o.signcolumn = "yes"                                -- always show signcolumn
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.opt.shortmess:append { c = true }
vim.o.completeopt = "menuone,noselect"                  -- Set completeopt to have a better completion experience

-- Tabs -> 2 spaces
vim.o.expandtab = true                                  -- tab => spaces
vim.o.smarttab = true
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2

-- Swap
vim.o.swapfile = false                                  -- disable swapfile 🤮
vim.o.backup = false                                    -- don't backup the file when it got overwritten
vim.o.writebackup = true                                -- but do a temporary backup that will be delete after
vim.o.undofile = true                                   -- save undotree into a file
vim.o.undodir = os.getenv("HOME") .. "/.vim/undodir"    -- files are save in home directory

-- Buffer navigation
vim.keymap.set("n", "<C-K>", vim.cmd.bprevious, {})
vim.keymap.set("n", "<C-J>", vim.cmd.bnext, {})
vim.keymap.set("n", "<C-L>", vim.cmd.tabnext, {})
vim.keymap.set("n", "<C-H>", vim.cmd.tabprevious, {})
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>dd', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>df', vim.cmd.EslintFixAll, { desc = "[D]iagnostic auto[F]ix" })

vim.keymap.set("n", "(", ")", { noremap = true })
vim.keymap.set("n", ")", "(", { noremap = true })
vim.keymap.set("v", "(", ")", { noremap = true })
vim.keymap.set("v", ")", "(", { noremap = true })

-- [[ Basic Keymaps ]]

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Move code
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
-- vim.keymap.set("n", "<C-d>", "<C-d>zz")
-- vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("x", "p", "\"_dP")
vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})


-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'typescript', 'vimdoc', 'vim' },

  -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
  auto_install = false,

  highlight = { enable = true },
  indent = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<M-space>',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>A'] = '@parameter.inner',
      },
    },
  },
}

-- Diagnostic keymaps

-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<leader>k', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
--
--  If you want to override the default filetypes that your language server will attach to you can
--  define the property 'filetypes' to the map in question.
local servers = {
  -- clangd = {},
  -- gopls = {},
  -- pyright = {},
  -- rust_analyzer = {},
  -- tsserver = {},
  -- html = { filetypes = { 'html', 'twig', 'hbs'} },

  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
      filetypes = (servers[server_name] or {}).filetypes,
    }
  end
}

-- [[ Configure nvim-cmp ]]
-- See `:help cmp`
local cmp = require 'cmp'
local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    -- vim.api.nvim_set_keymap('i', '<C-Space>', [[coc#refresh()]], { silent = true, expr = true })
    -- vim.api.nvim_set_keymap('i', '<CR>', [[coc#pum#visible() ? coc#_select_confirm() : "\<CR>"]], { silent = true, expr = true })

    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

  ----use {
  ----  "nvim-lualine/lualine.nvim",
  ----  requires = { "nvim-tree/nvim-web-devicons", opt = true }
  ----}
  -- {
  --   "beauwilliams/statusline.lua",
  --   config = function ()
  --     local statusline = require('statusline')
  --     statusline.tabline = true 
  --   end,
  -- },
