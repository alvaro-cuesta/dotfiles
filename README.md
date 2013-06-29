# Quick install

- Todo quick install
- Leiningen config
- Python emacs

```
mkdir -p ~/bin/
wget http://raw.github.com/technomancy/leiningen/stable/bin/lein -O ~/bin/lein
chmod 755 ~/bin/lein
```

# Git prompt & completion

```
git clone git://github.com/lvv/git-prompt.git ~/.git-prompt
wget https://raw.github.com/git/git/master/contrib/completion/git-completion.bash -O ~/.git-completion.bash
echo "source ~/.bashrc_personal" >> ~/.bashrc
```

# emacs

```
mkdir -p ~/.emacs.d/
sudo apt-get install ttf-inconsolata  # Or alternative in non-Debian
wget http://danamlund.dk/emacs/no-easy-keys.el -O ~/.emacs.d/no-easy-keys.el
wget http://www.dr-qubit.org/undo-tree/undo-tree.el -O ~/.emacs.d/undo-tree.el
wget https://github.com/DarwinAwardWinner/ido-ubiquitous/raw/master/ido-ubiquitous.el -o ~/.emacs.d/ido-ubiquitous.el
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
```
