git clone https://github.com/duchao0726/dotfiles.git ~/.dotfiles
ln -s ~/.dotfiles/vim/vimrc ~/.vimrc
ln -s ~/.dotfiles/tmux/tmux.conf ~/.tmux.conf
ln -s ~/.dotfiles/tmux/tmux.tmuxline.vim.theme.conf ~/.tmux.theme.conf
mkdir -p ~/.vim
mkdir -p ~/.vim/tmpfiles
mkdir -p ~/.vim/bundle
cd ~/.vim/bundle
git clone https://github.com/VundleVim/Vundle.vim.git
cd ~
mkdir -p ~/.config
ln -s ~/.dotfiles/others/pycodestyle ~/.config/pycodestyle
#sh -c "$(wget -O- https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
curl -Lo install.sh https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh
#sh install.sh
