# dotfiles

This repository contains (a user friendly version of) the dotfiles I use on all my systems.


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

### .ssh/config
Enables compression by default and set up a connection reuse to speed up login step via the `ControlMaster` feature of ssh.

### .nanorc
Various settings for nano.

