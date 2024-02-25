git clone https://github.com/chriskempson/base16-shell.git $HOME/.config/base16-shell
cat <<-'EOF' >> ~/.bashrc
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        source "$BASE16_SHELL/profile_helper.sh"
        
base16_material-darker
EOF
ln -s $(pwd)/.vimrc $HOME
ln -s $(pwd)/.vimrc_background $HOME
ln -s $(pwd)/.vim $HOME
ln -s $(pwd)/.tmux.conf $HOME
ln -s $(pwd)/.zpreztorc $HOME
