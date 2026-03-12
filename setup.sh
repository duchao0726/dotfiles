#!/bin/bash
# setup.sh - dotfiles setup for macOS and Linux/server

DOTFILES="$HOME/.dotfiles"
OS="$(uname -s)"

# Clone dotfiles if not already present
if [ ! -d "$DOTFILES" ]; then
    git clone https://github.com/duchao0726/dotfiles.git "$DOTFILES"
fi

echo "==> vim"
ln -sf "$DOTFILES/vim/vimrc" ~/.vimrc
mkdir -p ~/.vim/tmpfiles

echo "==> neovim"
mkdir -p ~/.config/nvim
ln -sf "$DOTFILES/nvim/init.lua" ~/.config/nvim/init.lua
ln -sf "$DOTFILES/nvim/lua" ~/.config/nvim/lua

echo "==> tmux"
ln -sf "$DOTFILES/tmux/tmux.conf" ~/.tmux.conf
ln -sf "$DOTFILES/tmux/tmux.theme.conf" ~/.tmux.theme.conf
if [ ! -d ~/.tmux/plugins/tpm ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

echo "==> git"
ln -sf "$DOTFILES/git/gitconfig" ~/.gitconfig
ln -sf "$DOTFILES/git/gitconfig.personal" ~/.gitconfig.personal
# Work identity: only on macOS (servers use personal identity)
if [ "$OS" = "Darwin" ]; then
    ln -sf "$DOTFILES/git/gitconfig.work" ~/.gitconfig.work
fi

echo "==> zsh"
if [ ! -d ~/.oh-my-zsh ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
if [ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k"
fi
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi
ln -sf "$DOTFILES/zsh/custom.zsh" "$ZSH_CUSTOM/custom.zsh"

# macOS only
if [ "$OS" = "Darwin" ]; then
    echo "==> ghostty"
    mkdir -p ~/.config/ghostty
    ln -sf "$DOTFILES/ghostty/config" ~/.config/ghostty/config
fi

echo ""
echo "==> Done! Next steps:"
echo "    1. Edit ~/.zshrc: set ZSH_THEME=\"powerlevel10k/powerlevel10k\""
echo "       and plugins=(git zsh-autosuggestions zsh-syntax-highlighting)"
echo "    2. Reload zsh: source ~/.zshrc"
echo "    3. Run: p10k configure"
echo "    4. Start tmux and press Ctrl+a then I to install plugins"
