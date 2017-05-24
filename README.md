## vim-prettier

A vim plugin wrapper for prettier, pre-configured with custom default prettier settings.

### INSTALL 

Install with [vim-plug](https://github.com/junegunn/vim-plug), assumes node and yarn|npm installed globally.

```
" yarn install | npm install
Plug 'mitermayer/vim-prettier', { 'do': 'yarn install', 'for': 'javascript' } 
```

If using other vim plugin managers or doing manual setup make sure to have `prettier` installed globally or go to your vim-prettier directory and either do `npm install` or `yarn install`

## Prettier Executable resolution

When installed via vim-plug, a default prettier executable is installed inside vim-prettier.

vim-prettier executable resolution:

1. Tranverse parents and search for Prettier installation inside `node_modules`
2. Look for a global prettier installation
3. Use locally installed vim-prettier prettier executable

## USAGE

Formats the entire buffer

```
:Prettier
```

Disable auto formatting of javascript files that have "@format" tag 

```
let g:prettier#autoformat = 0
```

Enable vim-prettier to run in javascript files without the "@format" doc tag 

```
autocmd BufWritePre *.js call prettier#Prettier()
```

Overwrite default configuration

```
" max line lengh that prettier will wrap on
g:prettier#config#print_width = 80

" number of spaces per indentation level
g:prettier#config#tab_width = 2

" use tabs over spaces
g:prettier#config#use_tabs = 0

" print semicolons
g:prettier#config#semi = 1

" single quotes over double quotes
g:prettier#config#single_quote = 1

" print spaces between brackets
g:prettier#config#bracket_spacing = 0

" put > on the last line instead of new line
g:prettier#config#jsx_bracket_same_line = 1

" none|es5|all
g:prettier#config#trailing_comma = 'all'

" flow|babylon
g:prettier#config#parser = 'flow'

```
### REQUIREMENT(S) 

If prettier installation can't be found no code formatting will happen
