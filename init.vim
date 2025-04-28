" you can use the command below to open vim using this init.vim setup
" Linux:
" nvim -u <(curl -s https://raw.githubusercontent.com/Gimcholas01/init.vim/refs/heads/main/init.vim)
"
" Windows:
" curl -O https://raw.githubusercontent.com/Gimcholas01/init.vim/refs/heads/main/init.vim --output-dir %temp% && nvim -u %temp%/init.vim && del %temp%\init.vim
"
" Windows does not have the functionality to pass in curl output into vim,
" hence the work around is to download the init.vim file to the %temp% folder
" and delete it after exiting vim

set number
set relativenumber
set softtabstop=4
set tabstop=4
set shiftwidth=4
set expandtab
set backspace=indent,eol,start
syntax on
set clipboard=unnamedplus
set ignorecase
set smartcase
set history=500
set undofile
set undodir=$HOME/.vim/undo 
set undolevels=1000
set undoreload=10000
set autoread

" delete change substitute without copy
nnoremap d "_d
vnoremap d "_d
nnoremap D "_D
vnoremap D "_D
nnoremap c "_c
vnoremap c "_c
nnoremap C "_C
vnoremap C "_C
xnoremap p P

" window navigation remap
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

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

" ctrl + w + h to split horizontally
nnoremap <C-W>h :split<CR>

" paste on new line
nnoremap P o<Esc>p

" buffer delete, dont close window
map <C-d> :bn<CR>:bd#<CR>

" check for changes from different sessions
if ! exists("g:CheckUpdateStarted")
    let g:CheckUpdateStarted=1
    call timer_start(1,'CheckUpdate')
endif
function! CheckUpdate(timer)
    silent! checktime
    call timer_start(3000,'CheckUpdate')
endfunction

" plugin manager, stop here if Plug is not found
if empty(globpath(&rtp, 'autoload/plug.vim'))
    new
    call setline(1, 'Download Plug At:')
    call append(1, 'https://github.com/junegunn/vim-plug?tab=readme-ov-file#installation')
    finish
endif

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
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
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
Plug 'rafamadriz/friendly-snippets'

Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'jose-elias-alvarez/null-ls.nvim'

Plug 'christoomey/vim-tmux-navigator'

Plug 'hrsh7th/vim-vsnip'

Plug 'nvim-tree/nvim-web-devicons' " Recommended (for coloured icons)

Plug 'akinsho/bufferline.nvim', { 'tag': '*' } " buffer tabs

Plug 'farmergreg/vim-lastplace' " vim last place

Plug 'romainl/vim-cool/'

Plug 'catppuccin/nvim', { 'as': 'catppuccin' }

Plug 'tribela/vim-transparent'

call plug#end()

colorscheme catppuccin

" Nerd tree custom keybind
nnoremap <C-t> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

" commenting custom keybind
nnoremap <C-Space> :Commentary<CR>
" fuzzy finder telescope
nnoremap <leader>ff <cmd>Telescope find_files hidden=true<cr>
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
      ['<C-p>'] = cmp.mapping.select_prev_item(),
      ['<C-n>'] = cmp.mapping.select_next_item(),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-y>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
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
  require('lspconfig')['djlsp'].setup {
      capabilities = capabilities
  }

    require('lspconfig').pyright.setup {
        capabilities = capabilities,
        settings = {
            python = {
                analysis = {
                    typeCheckingMode = "off"  -- Disable type checking
                }
            }
        }
    }

  require('lspconfig')['cssls'].setup { 
    capabilities = capabilities
  }

  require('lspconfig')['html'].setup { 
    capabilities = capabilities
  }

  require('lspconfig')['jdtls'].setup { 
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
