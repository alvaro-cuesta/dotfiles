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
