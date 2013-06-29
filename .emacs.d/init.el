;;(load-file "/home/kaod/emacs-for-python/epy-init.el")
;;(epy-setup-ipython)
;; (epy-django-snippets)
;; (epy-setup-checker "sh ~/bin/pychecker %f")


;; TODO:
;;  importar más de python?
;;  coffee/js lint
;;  Nodejs completion
;;  Coffee compeltion


(add-to-list 'load-path "~/.emacs.d/")
(require 'no-easy-keys)
(require 'undo-tree)
(require 'highlight-indentation)
(require 'ido)
(require 'ido-ubiquitous)
(require 'coffee-mode)
(require 'nodejs-repl)
(require 'sws-mode)
(require 'jade-mode)
(require 'stylus-mode)
(require 'clojure-mode)
(require 'clojure-test-mode)


(custom-set-variables
 '(column-number-mode t)
 '(custom-enabled-themes (quote (wombat)))
 '(inhibit-startup-screen t)
 '(line-number-mode t)
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(truncate-lines t)
 '(indent-tabs-mode nil)
 '(global-linum-mode t)
 '(menu-bar-mode nil)
 '(desktop-save-mode nil)
 '(no-easy-keys t)
 '(highlight-indentation-mode t)
 '(x-select-enable-clipboard-manager nil)
 '(skeleton-pair t)
 '(delete-selection-mode t)
 '(ido-mode t)
 '(ido-enable-flex-matching t)
 '(coffee-tab-width 2)
 '(global-undo-tree-mode t)
 '(ido-ubiquitous t))

(custom-set-faces
 '(default ((t (:family "Inconsolata" :foundry "unknown" :slant normal :weight normal :height 98 :width normal)))))


;; Functions
(defun kill-other-buffers ()
    "Kill all other buffers."
    (interactive)
    (mapc 'kill-buffer
          (delq (current-buffer)
                (remove-if-not 'buffer-file-name (buffer-list)))))

(defun kill-all-buffers ()
  (interactive)
  (mapc 'kill-buffer (buffer-list)))

(defun backward-kill-line (arg)
  "Kill ARG lines backward."
  (interactive "p")
  (kill-line (- 1 arg)))

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

(defun my-desktop ()
  "Load the desktop and enable autosaving"
  (interactive)
  (let ((desktop-load-locked-desktop "ask"))
    (desktop-read)
    (desktop-save-mode 1)))

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

;; code borrowed from http://emacs-fu.blogspot.com/2010/01/duplicating-lines-and-commenting-them.html
(defun djcb-duplicate-line (&optional commentfirst)
  "comment line at point; if COMMENTFIRST is non-nil, comment the
original" (interactive)
  (beginning-of-line)
  (push-mark)
  (end-of-line)
  (let ((str (buffer-substring (region-beginning) (region-end))))
    (when commentfirst
    (comment-region (region-beginning) (region-end)))
    (insert-string
      (concat (if (= 0 (forward-line 1)) "" "\n") str "\n"))
    (forward-line -1)))

;; Mark whole line
(defun mark-line (&optional arg)
  "Marks a line"
  (interactive "p")
  (beginning-of-line)
  (push-mark (point) nil t)
  (end-of-line))

; code copied from http://stackoverflow.com/questions/2423834/move-line-region-up-and-down-in-emacs
(defun move-text-internal (arg)
  (cond
   ((and mark-active transient-mark-mode)
    (if (> (point) (mark))
        (exchange-point-and-mark))
    (let ((column (current-column))
          (text (delete-and-extract-region (point) (mark))))
      (forward-line arg)
      (move-to-column column t)
      (set-mark (point))
      (insert text)
      (exchange-point-and-mark)
      (setq deactivate-mark nil)))
   (t
    (let ((column (current-column)))
      (beginning-of-line)
      (when (or (> arg 0) (not (bobp)))
        (forward-line)
        (when (or (< arg 0) (not (eobp)))
          (transpose-lines arg))
        (forward-line -1))
      (move-to-column column t)))))

(defun annotate-pdb ()
  (interactive)
  (highlight-lines-matching-regexp "import pdb")
  (highlight-lines-matching-regexp "pdb.set_trace()"))

(defun annotate-todo ()
  (font-lock-add-keywords nil
                          '(("\\<\\(FIXME\\|TODO\\|BUG\\):" 1 font-lock-doc-face t))))

(defun move-text-down (arg)
  "Move region (transient-mark-mode active) or current line
  arg lines down."
  (interactive "*p")
  (move-text-internal arg))

(defun move-text-up (arg)
  "Move region (transient-mark-mode active) or current line
  arg lines up."
  (interactive "*p")
  (move-text-internal (- arg)))

(defun yank-and-indent ()
  "Yank and then indent the newly formed region according to mode."
  (interactive)
  (yank)
  (call-interactively 'indent-region))

(defun kill-and-join-forward (&optional arg)
  "If at end of line, join with following; otherwise kill line.
    Deletes whitespace at join."
  (interactive "P")
  (if (and (eolp) (not (bolp)))
      (delete-indentation t)
    (kill-line arg)))

;; Aliases
(defalias 'rs 'replace-string)
(defalias 'qrr 'query-replace-regexp)

;; Key bindings
(define-key function-key-map [(control tab)] [?\M-\t])

(global-set-key (kbd "C-x C-b") 'ibuffer)

(global-set-key (kbd "}")
                (lambda ()
                  (interactive)
                  (insert "}")
                  (indent-for-tab-command)))

(global-set-key (kbd ")")
                (lambda ()
                  (interactive)
                  (insert ")")
                  (indent-for-tab-command)))

(global-set-key (kbd "]")
                (lambda ()
                  (interactive)
                  (insert "]")
                  (indent-for-tab-command)))

(global-set-key (kbd "C-y") 'yank-and-indent)
(global-set-key (kbd "C-k") 'kill-and-join-forward)

(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)

(global-set-key "\M-n"
                (lambda ()
                  (interactive)
                  (next-line 5)))
(global-set-key "\M-p"
                (lambda ()
                  (interactive)
                  (previous-line 5)))

(global-set-key "\C-l" 'goto-line)

(global-set-key [remap move-beginning-of-line] 'smarter-move-beginning-of-line)

(global-set-key (kbd "C-x M-k") 'kill-other-buffers)
(global-set-key (kbd "C-x C-M-k") 'kill-all-buffers)

(global-set-key "\C-h" 'backward-delete-char-untabify)
(define-key isearch-mode-map "\C-h" 'isearch-delete-char)
(global-set-key (kbd "C-M-h") 'backward-kill-word)
(global-set-key (kbd "C-'") 'help-command)
(global-set-key (kbd "M-'") 'mark-paragraph)
(global-set-key (kbd "C-S-k") 'backward-kill-line)
(global-set-key (kbd "<backspace>")
                (lambda ()
                  (interactive)
                  (message "No! Use C-h instead")))
(global-set-key (kbd "C-<backspace>")
                (lambda ()
                  (interactive)
                  (message "No! Use C-M-h instead")))
(global-set-key (kbd "M-<backspace>")
                (lambda ()
                  (interactive)
                  (message "No! Use C-M-h instead")))
(global-set-key (kbd "<DEL>")
                (lambda ()
                  (interactive)
                  (message "No! Use C-h instead")))
(global-set-key (kbd "C-<DEL>")
                (lambda ()
                  (interactive)
                  (message "No! Use C-M-h instead")))
(global-set-key (kbd "M-<DEL>")
                (lambda ()
                  (interactive)
                  (message "No! Use C-M-h instead")))

(global-set-key (kbd "C-c y") 'djcb-duplicate-line)
(global-set-key (kbd "C-c c")
                (lambda ()
                  (interactive)
                  (djcb-duplicate-line t)))
(global-set-key (kbd "C-c l") 'mark-line)
(global-set-key (kbd "M-<up>") 'move-text-up)
(global-set-key (kbd "M-<down>") 'move-text-down)

;; Programs
(global-set-key (kbd "C-c t") 'ansi-term)
(global-set-key (kbd "C-c p") 'proced)

;; Font size
(global-set-key "\M-+" 'text-scale-increase)
(global-set-key (kbd "C-M-+") 'text-scale-decrease)
(global-set-key (kbd "M-<kp-add>") 'text-scale-increase)
(global-set-key (kbd "M-<kp-subtract>") 'text-scale-decrease)

;; Buffer navigation
(global-set-key (kbd "<C-S-left>") 'previous-buffer)
(global-set-key (kbd "<C-S-right>") 'next-buffer)

(global-set-key "\C-xO" '(lambda () (interactive) (other-window -1)))
(global-set-key (kbd "<RET>") 'newline-and-indent)
(global-set-key (kbd "C-<return>") 'newline)
(global-set-key (kbd "M-<RET>") 'newline)

;; Hooks

(add-hook 'after-change-major-mode-hook 'highlight-indentation-mode)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(add-hook 'before-save-hook
          (lambda ()
            (untabify (point-min) (point-max))))
(add-hook 'latex-mode-hook 'visual-line-mode)
(add-hook 'latex-mode-hook 'flyspell-mode)
(add-hook 'text-mode-hook 'visual-line-mode)
(add-hook 'text-mode-hook 'flyspell-mode)
(add-hook 'flyspell-mode-hook (lambda () (ispell-change-dictionary "en_US")))
(add-hook 'flyspell-mode-hook 'flyspell-buffer)
(add-hook 'python-mode-hook 'annotate-pdb)
(add-hook 'after-change-major-mode-hook 'annotate-todo)
(defun ido-define-keys () ;; C-n/p is more intuitive in vertical layout
  (define-key ido-completion-map (kbd "C-n") 'ido-next-match)
  (define-key ido-completion-map (kbd "C-p") 'ido-prev-match))
(add-hook 'ido-setup-hook 'ido-define-keys)


;; Print TOTD
(totd)
