" you can use the command below to open vim using this init.vim setup without needing to download it
" nvim -u <(curl -s https://raw.githubusercontent.com/Gimcholas01/init.vim/refs/heads/main/init.vim)
" note: only for linux users (if youre using windows then youre out of luck :p)

set number
set relativenumber
set softtabstop=4
set tabstop=4
set shiftwidth=4
set expandtab
set backspace=indent,eol,start
syntax on
set clipboard^=unnamed
set clipboard=unnamedplus
set ignorecase
set smartcase
set history=500
set undofile
set undodir=$HOME/.vim/undo 
set undolevels=1000
set undoreload=10000

" C-s to save
nnoremap <C-s> <ESC>:w<CR>

" window navigation remap
nnoremap <S-h> <C-w>h
nnoremap <S-j> <C-w>j
nnoremap <S-k> <C-w>k
nnoremap <S-l> <C-w>l

" alt + up down arrow keys to move blocks of code up or down
nnoremap <A-Up> :m .-2<CR>==
nnoremap <A-Down> :m .+1<CR>==
vnoremap <A-Up> :m '<-2<CR>gv=gv
vnoremap <A-Down> :m '>+1<CR>gv=gv

" tab in visual/normal mode
vnoremap <Tab> >
vnoremap <S-Tab> <
nnoremap <Tab> >>^
nnoremap <S-Tab> <<^

" ctrl + f to find word
nnoremap <C-f> /

" ctrl + w + h to split horizontally
nnoremap <C-W>h :split<CR>

call plug#begin()

Plug 'tpope/vim-surround' " Surrounding ysw)
Plug 'tpope/vim-commentary' " For Commenting gcc & gc

Plug 'preservim/nerdtree' ", {'on': 'NERDTreeToggle'}

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }
Plug 'BurntSushi/ripgrep'
Plug 'sharkdp/fd'

Plug 'tpope/vim-fugitive'

Plug 'lewis6991/gitsigns.nvim'

Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp' " nvim-cmp
Plug 'hrsh7th/cmp-vsnip'
Plug 'neovim/nvim-lspconfig'

Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'jose-elias-alvarez/null-ls.nvim'

Plug 'hrsh7th/vim-vsnip'

Plug 'nvim-tree/nvim-web-devicons' " Recommended (for coloured icons)

Plug 'akinsho/bufferline.nvim', { 'tag': '*' } " buffer tabs

Plug 'farmergreg/vim-lastplace' " vim last place

Plug 'romainl/vim-cool/'

Plug 'catppuccin/nvim', { 'as': 'catppuccin' }

call plug#end()

colorscheme catppuccin

" Nerd tree custom keybind
nnoremap <C-t> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

" commenting custom keybind
nnoremap <C-Space> :Commentary<CR>
" fuzzy finder telescope
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" bufferline jump to buffer with ctrl+number
nnoremap <f1> <cmd>BufferLineGoToBuffer1<cr>
nnoremap <f2> <cmd>BufferLineGoToBuffer2<cr>
nnoremap <f3> <cmd>BufferLineGoToBuffer3<cr>
nnoremap <f4> <cmd>BufferLineGoToBuffer4<cr>
nnoremap <f5> <cmd>BufferLineGoToBuffer5<cr>
nnoremap <f6> <cmd>BufferLineGoToBuffer6<cr>
nnoremap <f7> <cmd>BufferLineGoToBuffer7<cr>
nnoremap <f8> <cmd>BufferLineGoToBuffer8<cr>
nnoremap <f9> <cmd>BufferLineGoToBuffer9<cr>

lua << EOF
require("mason").setup()
require("mason-lspconfig").setup()
require("null-ls").setup()
EOF

lua << EOF
-- Set up nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-k>'] = cmp.mapping.select_prev_item(),
      ['<C-j>'] = cmp.mapping.select_next_item(),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
  -- Set configuration for specific filetype.
  --[[ cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'git' },
    }, {
      { name = 'buffer' },
    })
 })
 require("cmp_git").setup() ]]-- 

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    }),
    matching = { disallow_symbol_nonprefix_matching = false }
  })

  -- Set up lspconfig.
    local capabilities = require('cmp_nvim_lsp').default_capabilities()
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.

  -- LSP
  require('lspconfig')['pyright'].setup {
    capabilities = capabilities
  }

  require('lspconfig')['cssls'].setup { 
    capabilities = capabilities
  }

  require('lspconfig')['djlsp'].setup {
    capabilities = capabilities
  }

  require('lspconfig')['html'].setup { 
    capabilities = capabilities
  }

    -- Snippets
EOF


" bufferline
" In your init.lua or init.vim
set termguicolors
lua << EOF
require("bufferline").setup{}
EOF

lua << EOF
  require('gitsigns').setup()
EOF
