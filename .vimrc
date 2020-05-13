" ***************************************
" Basic Config
"***************************************
    if executable('tmux') && filereadable(expand('~/.bashrc')) && $TMUX !=# ''
        let g:vimIsInTmux = 1
        let &t_8f = "\<esc>[38;2;%lu;%lu;%lum"
        let &t_8b = "\<esc>[48;2;%lu;%lu;%lum"
        set termguicolors
        set mouse=a
    else
        let g:vimIsInTmux = 0
    endif

    " if has('win64') || has('win32') || has('win16')
    "     let g:whichOS = 'WINDOWS'
    " else
        let g:whichOS = toupper(substitute(system('uname'), '\n', '', ''))
    " endif
"***************************************
" plugins
"***************************************
call plug#begin('~/.vim/plugged')
" themes
    " Plug 'morhetz/gruvbox'
    " Plug 'sainnhe/forest-night'
    " Plug 'gruvbox-material/vim', { 'as': 'gruvbox-material' }
    Plug 'sainnhe/sonokai'
    Plug 'ryanoasis/vim-devicons'
    Plug 'yggdroot/indentline'
if g:vimIsInTmux == 1
    Plug 'sainnhe/tmuxline.vim', { 'on': [ 'Tmuxline', 'TmuxlineSnapshot' ] }
    Plug 'christoomey/vim-tmux-navigator'
endif
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'itchyny/lightline.vim'
Plug 'itchyny/vim-gitbranch'
Plug 'macthecadillac/lightline-gitdiff'
Plug 'maximbaz/lightline-ale'
Plug 'benmills/vimux'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-commentary' 	" [count]gcc -> comment or uncomment total [count] lines.
Plug 'tpope/vim-surround'
Plug 'romainl/vim-cool'
Plug 'thaerkh/vim-workspace'
" Plug 'jiangmiao/auto-pairs'
Plug 'vim-python/python-syntax'
Plug 'jeetsukumaran/vim-pythonsense'
Plug 'heavenshell/vim-pydocstring'
Plug 'tmhedberg/SimpylFold'
Plug 'liuchengxu/vista.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dense-analysis/ale'
Plug 'cjrh/vim-conda'
if g:whichOS == 'DARWIN'
    Plug 'ianding1/leetcode.vim'
endif
" Fuzzy search
    if isdirectory('/usr/local/opt/fzf')
        Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
    else
        Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
        Plug 'junegunn/fzf.vim'
    endif
call plug#end()

"***************************************
" Configurations
"***************************************
    "" Encoding
        set encoding=utf-8
        set fileencoding=utf-8
        set fileencodings=utf-8
        set ttyfast

    "" Fix backspace indent
        set backspace=indent,eol,start

    "" Scheme & GUI settings
        syntax on
        let g:python_highlight_all = 1
        set t_Co=256
        set termguicolors
        set background=dark
        let g:sonokai_style = 'atlantis'
        let g:sonokai_disable_italic_comment = 0
        let g:sonokai_enable_italic = 1
        colorscheme sonokai
        " let g:gruvbox_material_background = 'medium'
        " let g:gruvbox_material_visual = 'grey background'
        " let g:gruvbox_material_enable_italic = 1
        " let g:gruvbox_material_disable_italic_comment = 1
        " colorscheme gruvbox-material
        " colorscheme gruvbox
        set number
        set relativenumber
        set nocompatible
        set showcmd             "show cmd in the rhs below
        set hidden	            "switching buffers w/o write into file
        set cursorline
        set laststatus=2
        set noshowmode
        set ttimeoutlen=50
        set updatetime=300
        set showtabline=2       "always show tabline
        autocmd VimEnter,WinEnter,VimResized * let &scrolloff = (winheight(0)+1) / 3
        set wildmenu
        if !has('nvim')
            set ttymouse=xterm2
        endif

    "" Tab, Space and indent
        set expandtab           " enter spaces when tab is pressed
        set tabstop=4           " use 4 spaces to represent tab
        set softtabstop=4
        set shiftwidth=4        " number of spaces to use for auto indent
        set autoindent          " copy indent from current line when starting a new line
        let g:indentLine_char = '┆'
        let g:indentLine_conceallevel = 0
        " configure expanding of tabs for various file types
            au BufRead,BufNewFile *.py set expandtab
            au BufRead,BufNewFile *.c set noexpandtab
            au BufRead,BufNewFile *.h set noexpandtab
            au BufRead,BufNewFile Makefile* set noexpandtab

    "" Enable folding
        set foldmethod=indent
        set foldlevel=99
        let g:SimpylFold_docstring_preview = 1

    "" search
        set hlsearch
        set incsearch
        set ignorecase
        set smartcase

"***************************************
"" Abbreviations & mappings
"***************************************
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall

    "" split navigations
        set splitbelow
        set splitright
        nnoremap <C-J> <C-W><C-J>
        nnoremap <C-K> <C-W><C-K>
        nnoremap <C-L> <C-W><C-L>
        nnoremap <C-H> <C-W><C-H>

    "" change buffers
        nnoremap <C-N> :bn<CR>
        " nnoremap <C-P> :bp<CR>

    " Enable folding with the spacebar
        nnoremap <space> za

    "" map capital U to redo
        nnoremap U <C-R>

    "" write and source current file (local: MacOS)
        nnoremap ∑ :w<CR>:so %<CR>

    "" set zero and minus to the begin and end of current line.
        nnoremap - $
        vnoremap - $
        onoremap - $
        nnoremap 0 ^
        vnoremap 0 ^
        onoremap 0 ^

    "" switch mappings of # and *
        nnoremap # *
        nnoremap * #

    "" save session before leaving workspace (Plugin: vim-workspace)
        nnoremap <leader>q :call Qall()<CR>
        function! Qall()
            if isdirectory(".undodir")
                qall
            else
                exec "ToggleWorkspace"
                qall
            endif
        endfunction

    "" ale mappings
        nnoremap <leader>aa :ALEFix<CR>

    "" vim-conda mappings
        nnoremap <leader>c :CondaChangeEnv<CR>
"***************************************
"" Plugin settings
"***************************************

    "" NERDTree setup
        nnoremap <Leader>n :NERDTreeTabsToggle<CR>
        let NERDTreeQuitOnOpen = 1
        let g:NERDTreeWinSize = 25
        let NERDTreeWinPos="left"
        let NERDTreeMinimalUI = 1
        let NERDTreeDirArrows = 1
        let g:NERDTreeHidden= 0
        " toggle nerdtree if open empty file
            " autocmd vimenter * if !argc()|NERDTree|endif
        " autoclose when NERDTree is the only buffer
            autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

    "" lightline
        let g:lightline = {}
        let g:lightline.colorscheme = 'sonokai' "'forest_night'
        let g:lightline.separator = { 'left': "\ue0b8", 'right': "\ue0be" }
        let g:lightline.subseparator = { 'left': "\ue0b9", 'right': "\ue0b9" }
        let g:lightline.tabline_separator = { 'left': "\ue0bc", 'right': "\ue0ba" }
        let g:lightline.tabline_subseparator = { 'left': "\ue0bb", 'right': "\ue0bb" }
        let g:lightline#ale#indicator_checking = "\uf110"
        let g:lightline#ale#indicator_warnings = "\uf529"
        let g:lightline#ale#indicator_errors = "\uf00d"
        let g:lightline#ale#indicator_ok = "\uf00c"
        let g:lightline_gitdiff#indicator_added = '+'
        let g:lightline_gitdiff#indicator_deleted = '-'
        let g:lightline_gitdiff#indicator_modified = '*'
        let g:lightline_gitdiff#min_winwidth = '70'
        let g:lightline#asyncrun#indicator_none = ''
        let g:lightline#asyncrun#indicator_run = 'Running...'

        let g:lightline.active = {
           \ 'left': [ [ 'mode', 'paste' ],
           \           [ 'readonly', 'filename', 'modified', 'fileformat', 'devicons_filetype' ] ],
           \ 'right': [ [ 'lineinfo' ],
           \            [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok', 'pomodoro' ],
           \           [ 'asyncrun_status', 'coc_status' ] ]
           \ }
        let g:lightline.inactive = {
           \ 'left': [ [ 'filename' , 'modified', 'fileformat', 'devicons_filetype' ]],
           \ 'right': [ [ 'lineinfo' ] ]
           \ }
        let g:lightline.tabline = {
           \ 'left': [ [ 'vim_logo', 'tabs' ] ],
           \ 'right': [ [ 'gitbranch' ],
           \ [ 'gitstatus' ] ]
           \ }
        let g:lightline.tab = {
           \ 'active': [ 'tabnum', 'filename', 'modified' ],
           \ 'inactive': [ 'tabnum', 'filename', 'modified' ] }
        let g:lightline.tab_component = {
           \ }
        let g:lightline.tab_component_function = {
           \ 'filename': 'lightline#tab#filename',
           \ 'modified': 'lightline#tab#modified',
           \ 'readonly': 'lightline#tab#readonly',
           \ 'tabnum': 'Tab_num'
           \ }
        let g:lightline.component = {
           \ 'gitstatus' : '%{lightline_gitdiff#get_status()}',
           \ 'bufinfo': '%{bufname("%")}:%{bufnr("%")}',
           \ 'vim_logo': "\ue7c5",
           \ 'mode': '%{lightline#mode()}',
           \ 'absolutepath': '%F',
           \ 'relativepath': '%f',
           \ 'filename': '%t',
           \ 'filesize': "%{HumanSize(line2byte('$') + len(getline('$')))}",
           \ 'fileencoding': '%{&fenc!=#""?&fenc:&enc}',
           \ 'fileformat': '%{&fenc!=#""?&fenc:&enc}[%{&ff}]',
           \ 'filetype': '%{&ft!=#""?&ft:"no ft"}',
           \ 'modified': '%M',
           \ 'bufnum': '%n',
           \ 'paste': '%{&paste?"PASTE":""}',
           \ 'readonly': '%R',
           \ 'charvalue': '%b',
           \ 'charvaluehex': '%B',
           \ 'percent': '%2p%%',
           \ 'percentwin': '%P',
           \ 'spell': '%{&spell?&spelllang:""}',
           \ 'lineinfo': '%2p%% %3l:%-2v',
           \ 'line': '%l',
           \ 'column': '%c',
           \ 'close': '%999X X ',
           \ 'winnr': '%{winnr()}'
           \ }
        let g:lightline.component_function = {
           \ 'gitbranch': 'Gitbranch',
           \ 'devicons_filetype': 'Devicons_Filetype',
           \ 'devicons_fileformat': 'Devicons_Fileformat',
           \ 'coc_status': 'coc#status',
           \ 'coc_currentfunction': 'CocCurrentFunction'
           \ }
        let g:lightline.component_expand = {
           \ 'linter_checking': 'lightline#ale#checking',
           \ 'linter_warnings': 'lightline#ale#warnings',
           \ 'linter_errors': 'lightline#ale#errors',
           \ 'linter_ok': 'lightline#ale#ok',
           \ 'asyncrun_status': 'lightline#asyncrun#status'
           \ }
        let g:lightline.component_type = {
           \ 'linter_warnings': 'warning',
           \ 'linter_errors': 'error'
           \ }
        let g:lightline.component_visible_condition = {
           \ 'gitstatus': 'lightline_gitdiff#get_status() !=# ""'
           \ }
        autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

        function! CocCurrentFunction()
          return get(b:, 'coc_current_function', '')
        endfunction

        function! Tab_num(n) abort
          return a:n." \ue0bb"
        endfunction

        function! Gitbranch() abort
          if gitbranch#name() !=# ''
            return gitbranch#name()." \ue725"
          else
            return "\ue61b"
          endif
        endfunction

        function! Devicons_Filetype()
          " return winwidth(0) > 70 ? (strlen(&filetype) ? WebDevIconsGetFileTypeSymbol() . ' ' . &filetype : 'no ft') : ''
          return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
        endfunction

        function! Devicons_Fileformat()
          return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
        endfunction

    "" tmuxline.vim
        if g:vimIsInTmux == 1
          let g:tmuxline_preset = {
                \'a'    : '#S',
                \'b'    : '%R',
                \'c'    : [ '#{sysstat_mem} #[fg=white] \ufa51 #{upload_speed}' ],
                \'win'  : [ '#I', '#W' ],
                \'cwin' : [ '#I', '#W', '#F' ],
                \'x'    : [ "#[fg=white]#{download_speed} \uf6d9 #{sysstat_cpu}" ],
                \'y'    : [ '%a' ],
                \'z'    : '#H #{prefix_highlight}'
                \}
          let g:tmuxline_separators = {
                \ 'left' : "\ue0bc",
                \ 'left_alt': "\ue0bd",
                \ 'right' : "\ue0ba",
                \ 'right_alt' : "\ue0bd",
                \ 'space' : ' '}
        endif

    "" Vim-airline
    "    let g:airline_theme="luna"
    "    "let g:airline_theme = 'powerlineish'
    "    let g:airline_powerline_fonts = 1
    "    let g:airline#extensions#branch#enabled = 1
    "    let g:airline#extensions#ale#enabled = 1
    "    let g:airline#extensions#tagbar#enabled = 0
    "    let g:airline_skip_empty_sections = 1
    "    let g:airline#extensions#tabline#enabled = 1
    "    let g:airline#extensions#tabline#buffer_nr_show=0
    "    let g:airline#extensions#tabline#tab_nr_type = 1 " tab number
    "    let g:airline#extensions#tabline#show_tab_nr = 1
    "    let g:airline#extensions#tabline#formatter = 'default'
    "    let g:airline#extensions#tabline#fnamecollapse = 1
    "    let g:airline#extensions#tabline#fnamemod = ':p:.'
    "    let g:airline#extensions#tabline#buffer_idx_mode = 1
    "    nmap <leader>1 <Plug>AirlineSelectTab1
    "    nmap <leader>2 <Plug>AirlineSelectTab2
    "    nmap <leader>3 <Plug>AirlineSelectTab3
    "    nmap <leader>4 <Plug>AirlineSelectTab4
    "    nmap <leader>5 <Plug>AirlineSelectTab5
    "    nmap <leader>6 <Plug>AirlineSelectTab6
    "    nmap <leader>7 <Plug>AirlineSelectTab7
    "    nmap <leader>8 <Plug>AirlineSelectTab8
    "    nmap <leader>9 <Plug>AirlineSelectTab9
    "    " let g:airline#extensions#tabline#buffer_idx_format = {
    "        \ '0': '0 ',
    "        \ '1': '1 ',
    "        \ '2': '2 ',
    "        \ '3': '3 ',
    "        \ '4': '4 ',
    "        \ '5': '5 ',
    "        \ '6': '6 ',
    "        \ '7': '7 ',
    "        \ '8': '8 ',
    "        \ '9': '9 '
    "        \}
    "    " let g:airline#extensions#tabline#buffer_nr_format = '(b%s)'
    "    let g:airline#extensions#virtualenv#enabled = 1
    "    let g:airline#extensions#vista#enabled = 1

    "" vim-cool
        let g:CoolTotalMatches = 1 "show match numbers in commend line

    "" vim-workspace
        nnoremap <leader>s :ToggleWorkspace<CR>
        let g:workspace_session_name = 'Session.vim'
        let g:workspace_session_directory = $HOME . '/.vim/sessions/'
        let g:workspace_create_new_tabs = 1 " enabled = 1 (default), disabled = 0
        let g:workspace_session_disable_on_args = 1
        let g:workspace_persist_undo_history = 1 " enabled = 1 (default), disabled = 0
        let g:workspace_undodir='.undodir'
        let g:workspace_autosave_always = 1
        let g:workspace_autosave_ignore = ['gitcommit']

    "" ale
    let g:ale_fixers = {
                \'*': ['remove_trailing_lines', 'trim_whitespace'],
                \'python': ['yapf', 'isort'],
                \}
    let g:ale_python_flake8_options = "--ignore=E501,E226"

    " vim-session
        " g:session_directory = "~/.vim/session"
        " g:session_autoload = 'prompt'
        " g:session_autosave = 'yes'
        " g:session_command_aliases = 1
        "nnoremap <leader>so :OpenSession<Space>
        "nnoremap <leader>ss :SaveSession<Space>
        "nnoremap <leader>sd :DeleteSession<CR>
        "nnoremap <leader>sc :CloseSession<CR>

    "" vim-devicons
        let g:WebDevIconsUnicodeGlyphDoubleWidth = 1
        let g:WebDevIconsUnicodeDecorateFolderNodes = 1
        let g:DevIconsEnableFoldersOpenClose = 1
        let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {}
        let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols[''] = "\uf15b"
        let g:WebDevIconsUnicodeDecorateFolderNodes = v:true

    " CoC.nvim settings
        " TextEdit might fail if hidden is not set.
        set hidden

        " Some servers have issues with backup files, see #649.
        set nobackup
        set nowritebackup

        " Give more space for displaying messages.
        set cmdheight=2

        " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
        " delays and poor user experience.
        set updatetime=300

        " Don't pass messages to |ins-completion-menu|.
        set shortmess+=c

        " Always show the signcolumn, otherwise it would shift the text each time
        " diagnostics appear/become resolved.
        set signcolumn=yes

        " Use tab for trigger completion with characters ahead and navigate.
        " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
        " other plugin before putting this into your config.
        inoremap <silent><expr> <TAB>
              \ pumvisible() ? "\<C-n>" :
              \ <SID>check_back_space() ? "\<TAB>" :
              \ coc#refresh()
        inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

        function! s:check_back_space() abort
          let col = col('.') - 1
          return !col || getline('.')[col - 1]  =~# '\s'
        endfunction

        " Use <c-space> to trigger completion.
        " inoremap <silent><expr> <c-space> coc#refresh()

        " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
        " position. Coc only does snippet and additional edit on confirm.
        if has('patch8.1.1068')
            " Use `complete_info` if your (Neo)Vim version supports it.
            inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
        else
          imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
        endif

        " Use `[g` and `]g` to navigate diagnostics
        nmap <silent> [g <Plug>(coc-diagnostic-prev)
        nmap <silent> ]g <Plug>(coc-diagnostic-next)

        " GoTo code navigation.
        nmap <silent> gd <Plug>(coc-definition)
        nmap <silent> gy <Plug>(coc-type-definition)
        nmap <silent> gi <Plug>(coc-implementation)
        nmap <silent> gr <Plug>(coc-references)

        " Use K to show documentation in preview window.
        nnoremap <silent> K :call <SID>show_documentation()<CR>

        function! s:show_documentation()
          if (index(['vim','help'], &filetype) >= 0)
            execute 'h '.expand('<cword>')
          else
            call CocAction('doHover')
          endif
        endfunction

        " Highlight the symbol and its references when holding the cursor.
        autocmd CursorHold * silent call CocActionAsync('highlight')

        " Symbol renaming.
        nmap <leader>rn <Plug>(coc-rename)

        " Formatting selected code.
        xmap <space>f  <Plug>(coc-format-selected)
        nmap <space>f  <Plug>(coc-format-selected)

        augroup mygroup
          autocmd!
          " Setup formatexpr specified filetype(s).
          autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
          " Update signature help on jump placeholder.
          autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
        augroup end

        " Applying codeAction to the selected region.
        " Example: `<leader>aap` for current paragraph
        xmap <leader>a  <Plug>(coc-codeaction-selected)
        nmap <leader>a  <Plug>(coc-codeaction-selected)

        " Remap keys for applying codeAction to the current line.
        nmap <leader>ac  <Plug>(coc-codeaction)
        " Apply AutoFix to problem on the current line.
        nmap <leader>qf  <Plug>(coc-fix-current)

        " Introduce function text object
        " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
        xmap if <Plug>(coc-funcobj-i)
        xmap af <Plug>(coc-funcobj-a)
        omap if <Plug>(coc-funcobj-i)
        omap af <Plug>(coc-funcobj-a)

        " " Use <TAB> for selections ranges.
        " " NOTE: Requires 'textDocument/selectionRange' support from the language server.
        " " coc-tsserver, coc-python are the examples of servers that support it.
        " nmap <silent> <TAB> <Plug>(coc-range-select)
        " xmap <silent> <TAB> <Plug>(coc-range-select)
        "     " since <TAB> == <C-I>, we will map <C-0> as substitute mappings of <C-I>
        "         " nnoremap <C-0> <C-I>
        "         nnoremap <C-0> <C-i>

        " Add `:Format` command to format current buffer.
        command! -nargs=0 Format :call CocAction('format')

        " Add `:Fold` command to fold current buffer.
        command! -nargs=? Fold :call     CocAction('fold', <f-args>)

        " Add `:OR` command for organize imports of the current buffer.
        command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

        " Add (Neo)Vim's native statusline support.
        " NOTE: Please see `:h coc-status` for integrations with external plugins that
        " provide custom statusline: lightline.vim, vim-airline.
        set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

        " Mappings using CoCList:
        " Show all diagnostics.
        nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
        " Manage extensions.
        nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
        " Show commands.
        nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
        " Find symbol of current document.
        nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
        " Search workspace symbols.
        nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
        " Do default action for next item.
        nnoremap <silent> <space>j  :<C-u>CocNext<CR>
        " Do default action for previous item.
        nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
        " Resume latest coc list.
        nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

    "" Fzf
        nnoremap <leader>b :Buffers<CR>
        nnoremap <leader>f :Files<CR>
        nnoremap <leader>h :History<CR>

    "" easymotion
        map , <Plug>(easymotion-prefix)
        " let g:EasyMotion_do_mapping = 0 " Disable default mappings

        " Jump to anywhere you want with minimal keystrokes, with just one key binding.
        " `s{char}{label}`
        " nmap s <Plug>(easymotion-overwin-f)
        " or
        " `s{char}{char}{label}`
        " Need one more keystroke, but on average, it may be more comfortable.
        nmap <Plug>(easymotion-prefix), <Plug>(easymotion-overwin-f2)
        "
        "" Turn on case-insensitive feature
        let g:EasyMotion_smartcase = 1

        " JK motions: Line motions
        " map <Plug>(easymotion-prefix)j <Plug>(easymotion-j)
        " map <Plug>(easymotion-prefix)k <Plug>(easymotion-k)"

    " Pydocstring
        let g:pydocstring_enable_mapping = 0

    " Vimux
        nnoremap <leader>p :w<CR>:call VimuxRunCommand("conda activate torch; py " . bufname("%"))<CR>

    " leetcode.vim
    if g:whichOS == 'DARWIN'
        let g:leetcode_solution_filetype = 'python3'
        let g:leetcode_browser = 'chrome'
    endif

    " auto-pairs
        let g:AutoPairsFlyMode = 1
