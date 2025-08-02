# Environment setup

## Search

```
brew install ripgrep
```

## Editor

* Install Neovim:

```
brew install neovim
```

* Link LazyVim configuration:

```
ln -s $PWD/nvim ~/.config/nvim
```

* (Optional) Link basic vimrc for vim compatibility:

```
ln -s $PWD/vim/.vimrc ~/.vimrc
```

LazyVim will automatically bootstrap and install plugins on first launch.

**Note**: The `nvim/lazy-lock.json` file is tracked in git to ensure consistent plugin versions across all machines. This means everyone who uses this configuration will get the exact same plugin versions. To update plugins, use `:Lazy update` in Neovim and commit the updated `lazy-lock.json`.

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

