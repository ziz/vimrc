#!/bin/bash

cd vim

#echo update vim-git syntax
#curl --silent -L https://github.com/tpope/vim-git/tarball/master | tar xzf - --strip-components=1

echo update pathogen
curl --silent -Lo autoload/pathogen.vim https://github.com/tpope/vim-pathogen/raw/master/autoload/pathogen.vim


#echo rebuild command-t
#(
	#cd bundle/command-t/ruby/command-t/ 
	#(ruby extconf.rb && make clean && make) || echo "command-t update failed"
#)

#echo update markdown support
#curl --silent -L https://github.com/tpope/vim-markdown/tarball/master | tar xzf - --strip-components=1
