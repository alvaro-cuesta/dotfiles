(custom-set-variables
 '(column-number-mode t)
 '(custom-enabled-themes (quote (wombat)))
 '(inhibit-startup-screen t)
 '(line-number-mode t)
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(truncate-lines t))

(custom-set-faces
 '(default ((t (:family "Inconsolata" :foundry "unknown" :slant normal :weight normal :height 98 :width normal)))))

(add-hook 'before-save-hook 'delete-trailing-whitespace)
(global-set-key "\C-l" 'goto-line)
(desktop-save-mode 1)
(global-linum-mode 1)
(menu-bar-mode -1)

(add-hook 'latex-mode-hook 'visual-line-mode)
(add-hook 'latex-mode-hook 'flyspell-mode)
(add-hook 'flyspell-mode-hook (lambda () (ispell-change-dictionary "en_US")))
(add-hook 'flyspell-mode-hook 'flyspell-buffer)

(add-to-list 'load-path "~/.emacs.common/")
(require 'no-easy-keys)
(no-esasy-keys 1)
