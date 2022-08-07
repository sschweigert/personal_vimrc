# Setup Instructions

Install this version of vim which will have +ruby support:
sudo apt install vim-nox

cd ~
git clone https://github.com/sschweigert/personal_vimrc.git
ln -s ./personal_vimrc/vim_util.vim .
ln -s ./personal_vimrc/.vimrc .
ln -s ~/personal_vimrc/bundle/ ./.vim/
cd ~/personal_vimrc
git submodule init
git submodule update


Install pathogen (https://github.com/tpope/vim-pathogen):
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

Note: Need to delete vim-ruby submodule. Doesn't exist anymore?
