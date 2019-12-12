# dotfiles

This repository contains (a user friendly version of) the configuration files I use on all my systems.


### .bashrc
You have here a set of convenient aliases, a function to extract archives and a more graphical pleasing and useful prompt 
(that displays for example the current full path). 

### .inputrc
This sets some keyboard shortcuts when using readline (bash) like using up arrow in a middle of a command to search back in the
history or the use of ctrl+left or ctrl+right to move word by word.

### .zshrc
Provides the same features as the `.bashrc` for zsh, plus a git related prompt and some zsh specific autocompletion options.

### .vimrc
This includes some general vim settings, a status line and a function to prettify xml files (by just issuing `:PrettyXML`).

##### Vim plugin I often use (with [pathogen](https://github.com/tpope/vim-pathogen)):
Each of them being as useful as it is light ;)
* [supertab](https://github.com/ervandew/supertab): autocompletion in insert mode
* [tabular](https://github.com/godlygeek/tabular): align text
* [tagbar](https://github.com/majutsushi/tagbar): display code structure overview in a separate pane
* [traces](https://github.com/markonm/traces.vim): range, pattern and substitute preview
* [vim-bookmarks](https://github.com/MattesGroeger/vim-bookmarks): visual bookmark for lines
* [vim-commentary](https://github.com/tpope/vim-commentary): comment code
* [vim-highlightedyank](https://github.com/machakann/vim-highlightedyank): highlight yanked text
* [vim-minisnip](https://github.com/tckmn/vim-minisnip): minimal snippet manager
* [vim-noscrollbar](https://github.com/gcavallanti/vim-noscrollbar): visual scrollbar in status line


### .ssh/config
Enables compression by default and set up a connection reuse to speed up login step via the `ControlMaster` feature of ssh.

### .nanorc
Various settings for nano.

