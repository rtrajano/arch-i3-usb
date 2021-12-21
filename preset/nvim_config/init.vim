call plug#begin('~/.vim/plugged')
Plug 'sheerun/vimrc'
Plug 'sheerun/vim-polyglot'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'FooSoft/vim-argwrap'
Plug 'Raimondi/delimitMate'
Plug 'stefandtw/quickfix-reflector.vim'
Plug 'majutsushi/tagbar'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'neovim/nvim-lspconfig'

" Install lsp autocompletion w/snippets
if has('nvim')
        Plug 'hrsh7th/nvim-cmp'
        Plug 'hrsh7th/cmp-buffer'
        Plug 'hrsh7th/cmp-path'
        Plug 'hrsh7th/cmp-cmdline'
        Plug 'hrsh7th/cmp-nvim-lsp'
        Plug 'andersevenrud/cmp-tmux'
        Plug 'saadparwaiz1/cmp_luasnip'
        Plug 'L3MON4D3/LuaSnip'
		Plug 'rafamadriz/friendly-snippets'
endif
call plug#end()

" Most other sane defaults are from sheerun/vimrc
" check `:verbose set smartcase?` to see where things are set
set showmatch
set tabstop=4
set shiftwidth=4
set smartindent
set wildcharm=<C-Z>
set diffopt=iwhiteall,iblank  " Diff ignore whitespace

" sheerun vimrc overrides
autocmd VimEnter * set nonumber
autocmd VimEnter * set nocursorline
filetype plugin on

" sane file explorer settings
let g:netrw_banner=0
let g:netrw_browse_split=4  "<CR> will open file in previous window if available
let g:netrw_liststyle=3  "tree style view
let g:netrw_preview=1 " p in tree will open vert split
let g:netrw_altv=1  " v in tree will open vert split to the right
let g:netrw_alto=0  " v in tree will open vert split to the bottom

let mapleader=","
nnoremap <silent> <leader>tb :TagbarToggle<CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>B :Gblame<CR>
nnoremap <silent> <Leader>gb :Gblame<CR>
nnoremap <silent> <Leader>gc :Commits<CR>
nnoremap <silent> <leader>r :Rg <C-R><C-W><CR>
nnoremap <silent> <leader>f :Files<CR>
nnoremap <silent> <leader>w :ArgWrap<CR>
nnoremap <silent> <leader>F :20Lexplore<CR>
nnoremap <silent> <Leader>gd :Gvdiff<CR>
nnoremap <silent> gdh :diffget //2<CR>
nnoremap <silent> gdl :diffget //3<CR>
command! MakeTags !ctags --exclude='build*' -R .
nnoremap <silent> <leader>mt :MakeTags<CR>
nnoremap <silent> <Bslash> :wincmd w<CR>
vnoremap <leader>64 c<c-r>=system('base64 --decode', @")<cr><esc>

" Make will call make and open an error list window
command! -nargs=* Make make <args> | cwindow 3
noremap <F5> :Make<CR><C-w><Up>

colorscheme desert

" EasyMotion settings
let g:EasyMotion_do_mapping = 0 " Disable default mappings
let g:EasyMotion_smartcase = 1
nmap s <Plug>(easymotion-overwin-f)

" argwrap
let argwrap_tail_comma = 1

" Ripgrep
if executable('rg')
    set grepprg=rg\ --no-heading\ --vimgrep
    set grepformat=%f:%l:%c:%m
endif

" session management
let g:session_directory = "~/.config/nvim/session"
let g:session_autoload = "no"
let g:session_autosave = "no"
let g:session_command_aliases = 1

" vimdiff better https://www.codyhiar.com/blog/vimdiff-better-highlighting/
highlight DiffAdd    cterm=BOLD ctermfg=NONE ctermbg=22
highlight DiffDelete cterm=BOLD ctermfg=NONE ctermbg=52
highlight DiffChange cterm=BOLD ctermfg=NONE ctermbg=23
highlight DiffText   cterm=BOLD ctermfg=NONE ctermbg=40

" highlight git conflict markers ie. >>>>>>>>>
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" completion
set completeopt=menu,menuone,noselect
set shortmess+=c

lua << EOF

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

local lspconfig = require('lspconfig')

local servers = {'pyright'}
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    -- on_attach = my_custom_on_attach,
    capabilities = capabilities,
  }
end

-- luasnip setup
local luasnip = require 'luasnip'
require("luasnip.loaders.from_vscode").lazy_load()

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),

  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    {
      name = 'buffer',
      option = {
        get_bufnrs = function()
          return vim.api.nvim_list_bufs()
        end
      },
    },
    { name = 'path' },
    {
      name = 'tmux',
      option = {
        all_panes = false,
        label = '[tmux]',
        trigger_characters = { '.' },
        trigger_characters_ft = {} -- { filetype = { '.' } }
      },
    },
  },
}
cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
})
cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
})
