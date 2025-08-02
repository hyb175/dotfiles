# Environment setup

## Search

```
brew install ripgrep
```

## Editor

* Install Neovim & copy config

```
brew install neovim
ln -s $PWD/vim/.vimrc ~/.vimrc
```

* Link plugins

```
mkdir -p ~/.local/share/nvim/site/pack/plugins
ln -s $PWD/vim/plugins ~/.local/share/nvim/site/pack/plugins/start
```

## asdf

Follow [official instructions][asdf] to install `asdf`.

[asdf]: https://asdf-vm.com/#/core-manage-asdf-vm

Then install plugins:

```
asdf plugin-add ruby
```

```
brew install gpg # dependency of asdf nodejs plugin
asdf plugin-add nodejs
```

Then follow [instructions][asdf-nodejs] for bootstrapping trust with gpg.

[asdf-nodejs]: https://github.com/asdf-vm/asdf-nodejs#using-a-dedicated-openpgp-keyring

## File finder

```
brew install fzf
/usr/local/opt/fzf/install
```

## Tmux

* Clone with submodules (for TPM):

```
git clone --recursive https://github.com/YOUR_USERNAME/dotfiles.git ~/Projects/dotfiles
```

Or if already cloned:

```
git submodule update --init --recursive
```

* Create symlink:

```
ln -s $PWD/tmux ~/.config/tmux
```

* Install plugins - in tmux, press `prefix + I` (default prefix is `Ctrl-b`)

