My dotfiles repository
======================

Use
---
Clone the dotfiles to your home directory

```bash
git clone --bare git@github.com:jniedrauer/dotfiles.git ~/.dotfiles
git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME checkout
git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME config --local status.showUntrackedFiles no
```

Once you have the files in place, start a new shell. You will now have an alias `cfg` for adding and storing dotfiles which points at the bare repo in ~/.dotfiles.

Examples

```bash
# Add a file, commit, and push
cfg add ~/.dotfile
cfg commit -m "hello world"
cfg push

# Fetch and diff against origin
cfg fetch
cfg diff FETCH_HEAD
```

Vim setup
---------
Clone Vundle

```bash
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```

Open vim and run `:PluginInstall`

Python Dev Environment
----------------------
Install requirements

```bash
pip install --user virtualenv virtualenvwrapper
```

Virtualenvwrapper cheat sheet

```bash
# Create new virtualenv
mkvirtualenv --python <python interpreter> <name>

# Switch to virtualenv
workon <name>
```
