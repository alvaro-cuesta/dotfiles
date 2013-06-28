# System

## Git prompt & completion

```
git clone git://github.com/lvv/git-prompt.git ~/.git-prompt
wget https://raw.github.com/git/git/master/contrib/completion/git-completion.bash -O ~/.git-completion.bash
echo "source ~/.bashrc_personal" >> ~/.bashrc
```

# emacs

```
mkdir ~/.emacs.common/
wget http://danamlund.dk/emacs/no-easy-keys.el -O ~/.emacs.common/no-easy-keys.el
```

## Clojure

```
git clone --recursive git://github.com/vedang/clojure-emacs.git ~/.emacs.clojure.d/
wget http://raw.github.com/technomancy/leiningen/stable/bin/lein -O ~/bin/lein
chmod 755 ~/bin/lein
```

## CoffeeScript

```
mkdir ~/.emacs.coffee.d
wget https://raw.github.com/defunkt/coffee-mode/master/coffee-mode.el -O ~/.emacs.coffee.d/coffee-mode.el
wget https://raw.github.com/emacsmirror/nodejs-mode/master/nodejs-mode.el -O ~/.emacs.coffee.d/nodejs-mode.el
```

## Python

`git clone https://github.com/gabrielelanaro/emacs-for-python.git ~/.emacs.python.d`

# TODO

- Ido mode everywhere
- Clojure
- Markdown
- Plain JS?
- HTML/CSS/HAML/SASS/etc.
- Fix Git "load"
- Leiningen config
