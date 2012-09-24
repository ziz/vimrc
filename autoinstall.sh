#!/bin/sh
cd $(dirname $0)
INSTALL_TO=$(dirname $(pwd))

warn() {
    echo "$1" >&2
}

die() {
    warn "$1"
    exit 1
}

#[ -e "$INSTALL_TO/vimrc" ] && die "$INSTALL_TO/vimrc already exists."
[ -e "~/.vim" ] && die "~/.vim already exists."
[ -e "~/.vimrc" ] && die "~/.vimrc already exists."

cd "$INSTALL_TO"
cd vimrc

git pull
# Download vim plugin bundles
git submodule update --init --recursive

# Compile command-t for the current platform
cd vim/bundle/command-t/ruby/command-t
(ruby extconf.rb && make clean && make) || warn "Ruby compilation failed. Ruby not installed, maybe?"

# Symlink ~/.vim and ~/.vimrc
(
	cd ~
	ln -ns "$INSTALL_TO/vimrc/vimrc" .vimrc
	ln -ns "$INSTALL_TO/vimrc/vim" .vim
	touch ~/.vim/user.vim
)

if [ -f /usr/local/bin/mvim -a ! -f /usr/local/bin/vim ]; then
	(
	echo "linking vim to mvim"
	cd /usr/local/bin
	ln -nsf mvim vim
	)
fi

echo "Installed and configured .vim, have fun."
