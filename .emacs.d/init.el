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

(defun my-desktop ()
  "Load the desktop and enable autosaving"
  (interactive)
  (let ((desktop-load-locked-desktop "ask"))
    (desktop-read)
    (desktop-save-mode 1)))
(desktop-save-mode 0)

(global-linum-mode 1)
(menu-bar-mode -1)

(add-hook 'latex-mode-hook 'visual-line-mode)
(add-hook 'latex-mode-hook 'flyspell-mode)
(add-hook 'text-mode-hook 'visual-line-mode)
(add-hook 'text-mode-hook 'flyspell-mode)
(add-hook 'flyspell-mode-hook (lambda () (ispell-change-dictionary "en_US")))
(add-hook 'flyspell-mode-hook 'flyspell-buffer)

(add-to-list 'load-path "~/.emacs.common/")
(require 'no-easy-keys)
(no-easy-keys 1)

(defun kill-other-buffers ()
    "Kill all other buffers."
    (interactive)
    (mapc 'kill-buffer
          (delq (current-buffer)
                (remove-if-not 'buffer-file-name (buffer-list)))))
(defun close-all-buffers ()
  (interactive)
  (mapc 'kill-buffer (buffer-list)))
(global-set-key (kbd "C-x M-k") 'kill-other-buffers)
(global-set-key (kbd "C-x C-M-k") 'kill-all-buffers)

(defun smarter-move-beginning-of-line (arg)
  "Move point back to indentation of beginning of line.

Move point to the first non-whitespace character on this line.
If point is already there, move to the beginning of the line.
Effectively toggle between the first non-whitespace character and
the beginning of the line.

If ARG is not nil or 1, move forward ARG - 1 lines first.  If
point reaches the beginning or end of the buffer, stop there."
  (interactive "^p")
  (setq arg (or arg 1))

  ;; Move lines first
  (when (/= arg 1)
    (let ((line-move-visual nil))
      (forward-line (1- arg))))

  (let ((orig-point (point)))
    (back-to-indentation)
    (when (= orig-point (point))
      (move-beginning-of-line 1))))

(global-set-key [remap move-beginning-of-line] 'smarter-move-beginning-of-line)
(global-set-key (kbd "C-c t") 'ansi-term)
(global-set-key (kbd "C-c p") 'proced)
(global-set-key "\M-+" 'text-scale-increase)
(global-set-key "\C-M-+" 'text-scale-decrease)
(global-set-key (kbd "M-<kp-add>") 'text-scale-increase)
(global-set-key (kbd "M-<kp-subtract>") 'text-scale-decrease)

(global-set-key (kbd "<C-S-left>") 'previous-buffer)
(global-set-key (kbd "<C-S-right>") 'next-buffer)

(global-set-key "\C-xO" '(lambda () (interactive) (other-window -1)))
(global-set-key (kbd "RET") 'newline-and-indent)
(global-set-key (kbd "C-c u") 'untabify)

(global-set-key "\C-h" 'backward-delete-char-untabify)
(define-key isearch-mode-map "\C-h" 'isearch-delete-char)
(global-set-key "\C-H" 'help-command)
(global-set-key (kbd "<C-M-h>") 'backward-kill-word)

(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)

(defalias 'rs 'replace-string)
(defalias 'qrr 'query-replace-regexp)

(require 'cl)
(defun totd ()
  (interactive)
  (random t)
  (with-output-to-temp-buffer "*Tip of the day*"
    (let* ((commands (loop for s being the symbols
                           when (commandp s) collect s))
           (command (nth (random (length commands)) commands)))
      (princ
       (concat "Your tip for the day is:\n========================\n\n"
               (describe-function command)
               "\n\nInvoke with:\n\n"
               (with-temp-buffer
                 (where-is command t)
                 (buffer-string)))))))
(totd)
