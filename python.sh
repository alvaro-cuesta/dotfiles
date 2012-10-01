#!/bin/bash
git clone https://github.com/gabrielelanaro/emacs-for-python.git ~/.emacs.python.d
cp ./pycheckers ~/.emacs.python.d/
echo "#!/bin/bash" > ~/emacs-py.sh
echo "emacs -q -l ~/.emacs.python.el" >> ~/emacs-py.sh
chmod +x ~/emacs-py.sh
cp ./.emacs.python.el ~
