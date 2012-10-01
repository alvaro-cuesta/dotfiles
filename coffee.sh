#!/bin/bash
mkdir ~/.emacs.coffee.d/
wget https://raw.github.com/defunkt/coffee-mode/master/coffee-mode.el
mv ./coffee-mode.el ~/.emacs.coffee.d/
echo "#!/bin/bash" > ~/emacs-coffee.sh
echo "emacs -l ~/.emacs.coffee.el" >> ~/emacs-coffee.sh
chmod +x ~/emacs-coffee.sh
cp ./.emacs.coffee.el ~
