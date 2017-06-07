## vim-prettier

A vim plugin wrapper for prettier, pre-configured with custom default prettier settings.

By default it will auto format **javascript**, **typescript**, **less**, **scss** and **css** files that have "@format" annotation in the header of the file.

![vim-prettier](/media/vim-prettier.gif?raw=true "vim-prettier")

### INSTALL 

Install with [vim-plug](https://github.com/junegunn/vim-plug), assumes node and yarn|npm installed globally.

```vim
" post install (yarn install | npm install) then load plugin only for editing supported files
plug 'mitermayer/vim-prettier', { 
	\ 'do': 'yarn install', 
	\ 'for': ['javascript', 'typescript', 'css', 'less', 'scss'] } 
```

If using other vim plugin managers or doing manual setup make sure to have `prettier` installed globally or go to your vim-prettier directory and either do `npm install` or `yarn install`

### Prettier Executable resolution

When installed via vim-plug, a default prettier executable is installed inside vim-prettier.

vim-prettier executable resolution:

1. Tranverse parents and search for Prettier installation inside `node_modules`
2. Look for a global prettier installation
3. Use locally installed vim-prettier prettier executable

### USAGE

Prettier by default will run on auto save but can also be manualy triggered by:

```vim
<Leader>p
```
or

```vim
:Prettier
```

If your are on vim 8+ you can also trigger async formatting by:

```vim
:PrettierAsync
```

### Configuration

Disable auto formatting of files that have "@format" tag 

```vim
let g:prettier#autoformat = 0
```

The command `:Prettier` by default is synchronous but can also be forced async

```vim
let g:prettier#exec_cmd_async = 1
```

By default parsing errors will open the quickfix but can also be disabled

```vim
let g:prettier#quickfix_enabled = 0
```

To enable vim-prettier to run in files without requiring the "@format" doc tag.
First disable the default autoformat, then update to your own custom behaviour

Running before saving sync:

```vim
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.css,*.scss,*.less Prettier
```

Running before saving async (vim 8+):

```vim
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.css,*.scss,*.less PrettierAsync
```

Running before saving, changing text or leaving insert mode: 

```vim
" when running at every change you may want to disable quickfix
let g:prettier#quickfix_enabled = 0

let g:prettier#autoformat = 0
autocmd BufWritePre,TextChanged,InsertLeave *.js,*.css,*.scss,*.less PrettierAsync
```

### Overwrite default prettier configuration

```vim
" max line lengh that prettier will wrap on
g:prettier#config#print_width = 80

" number of spaces per indentation level
g:prettier#config#tab_width = 2

" use tabs over spaces
g:prettier#config#use_tabs = 'false'

" print semicolons
g:prettier#config#semi = 'true'

" single quotes over double quotes
g:prettier#config#single_quote = 'true' 

" print spaces between brackets
g:prettier#config#bracket_spacing = 'false' 

" put > on the last line instead of new line
g:prettier#config#jsx_bracket_same_line = 'true' 

" none|es5|all
g:prettier#config#trailing_comma = 'all'

" flow|babylon|typescript|postcss
g:prettier#config#parser = 'flow'

```
### REQUIREMENT(S) 

If prettier installation can't be found no code formatting will happen
