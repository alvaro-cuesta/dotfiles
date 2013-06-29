#!/bin/bash

mkdir -p ~/bin/
ln ./bin/pycheckers ~/bin/
chmod 755 ~/bin/pycheckers
wget http://raw.github.com/technomancy/leiningen/stable/bin/lein -O ~/bin/lein
chmod 755 ~/bin/lein

mkdir -p ~/.emacs.d/
wget http://danamlund.dk/emacs/no-easy-keys.el -O ~/.emacs.d/no-easy-keys.el
wget http://www.dr-qubit.org/undo-tree/undo-tree.el -O ~/.emacs.d/undo-tree.el
wget https://github.com/DarwinAwardWinner/ido-ubiquitous/raw/master/ido-ubiquitous.el -O ~/.emacs.d/ido-ubiquitous.el
wget https://github.com/antonj/Highlight-Indentation-for-Emacs/raw/master/highlight-indentation.el -O ~/.emacs.d/highlight-indentation.el
wget https://github.com/defunkt/coffee-mode/raw/master/coffee-mode.el -O ~/.emacs.d/coffee-mode.el
wget https://github.com/emacsmirror/nodejs-mode/raw/master/nodejs-repl.el -O ~/.emacs.d/nodejs-repl.el
wget https://github.com/brianc/jade-mode/raw/master/sws-mode.el -O ~/.emacs.d/sws-mode.el
wget https://github.com/brianc/jade-mode/raw/master/jade-mode.el -O ~/.emacs.d/jade-mode.el
wget https://github.com/brianc/jade-mode/raw/master/stylus-mode.el -O ~/.emacs.d/stylus-mode.el
wget http://jblevins.org/projects/markdown-mode/markdown-mode.el -O ~/.emacs.d/markdown-mode.el
wget https://github.com/technomancy/clojure-mode/raw/master/clojure-mode.el -O ~/.emacs.d/clojure-mode.el
wget https://github.com/technomancy/clojure-mode/raw/master/clojure-test-mode.el -O ~/.emacs.d/clojure-test-mode.el
wget https://github.com/kingtim/nrepl.el/raw/master/nrepl.el -O ~/.emacs.d/nrepl.el

git clone git://github.com/lvv/git-prompt.git ~/.git-prompt
wget https://raw.github.com/git/git/master/contrib/completion/git-completion.bash -O ~/.git-completion.bash

# Backup files
declare -a BACKUP_FILES=(~/.gitconfig ~/.git-prompt.conf ~/.bashrc_personal ~/.emacs.d/init.el)

for i in ${BACKUP_FILES[@]}
do
    mv $i $i.bak
done

ln -s $PWD/.gitconfig ~
ln -s $PWD/.git-prompt.conf ~
ln -s $PWD/.bashrc_personal ~
ln -s $PWD/.emacs.d/init.el ~/.emacs.d/

# Print differences with backed up files
for i in ${BACKUP_FILES[@]}
do
    if [ -f $i.bak ]
    then
	echo "Diffing $i"
        diff $i.bak $i
    fi
done
