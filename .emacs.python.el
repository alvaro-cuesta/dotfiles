(load-file "~/.emacs.python/epy-init.el")
(epy-setup-ipython)
(epy-django-snippets)
(epy-setup-checker "~/.emacs.python/pycheckers %f")

(defun annotate-pdb ()
  (interactive)
  (highlight-lines-matching-regexp "import i?pdb")
  (highlight-lines-matching-regexp "i?pdb.set_trace()"))
(add-hook 'python-mode-hook 'annotate-pdb)

(require 'highlight-indentation)
(add-hook 'python-mode-hook 'highlight-indentation)

(defun auto-fill-pep8 ()
  (set-fill-column 79)
  (auto-fill-mode))
(add-hook 'python-mode-hook 'auto-fill-pep8)
