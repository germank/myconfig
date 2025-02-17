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

# zprezto
zsh <<'EOF'
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done
EOF


# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
source ~/.fzf/install

