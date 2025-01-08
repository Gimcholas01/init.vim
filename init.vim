set number
set relativenumber
set ts=4 sw=4
set et
set backspace=indent,eol,start
syntax on
set ignorecase
set smartcase
set history=500
set undofile
set undodir=$HOME/.vim/undo 
set undolevels=1000
set undoreload=10000

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

" enter to new line / delete to remove line
nnoremap <CR> ^i<CR><ESC>
nnoremap <BS> ^i<BS><ESC>

" tab in visual/normal mode
vnoremap <Tab> >
vnoremap <S-Tab> <
nnoremap <Tab> >>^
nnoremap <S-Tab> <<^

call plug#begin()

Plug 'tpope/vim-surround' " Surrounding ysw)
Plug 'tpope/vim-commentary' " For Commenting gcc & gc
Plug 'preservim/nerdtree' ", {'on': 'NERDTreeToggle'}
Plug 'junegunn/fzf.vim' " Fuzzy Finder, Needs Silversearcher-ag for :Ag
Plug 'vim-airline/vim-airline'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp' " nvim-cmp
Plug 'nvim-tree/nvim-web-devicons' " Recommended (for coloured icons)
Plug 'akinsho/bufferline.nvim', { 'tag': '*' } " buffer tabs
Plug 'farmergreg/vim-lastplace' " vim last place
Plug 'romainl/vim-cool/'
call plug#end()

" Nerd tree custom keybind
nnoremap <C-t> :NERDTreeToggle<CR>

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


" nvim-cmp setup
lua <<EOF
  -- Set up nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
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
  
  
  --ocal capabilities = require('cmp_nvim_lsp').default_capabilities()
  --- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  --equire('lspconfig')['<YOUR_LSP_SERVER>'].setup {
  -- capabilities = capabilities
  --
  
EOF


" bufferline
" In your init.lua or init.vim
set termguicolors
lua << EOF
require("bufferline").setup{}
EOF
