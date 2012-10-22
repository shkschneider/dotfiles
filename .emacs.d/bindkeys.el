;; ~/.emacs.d/bindkeys

;; Thx <http://www.cs.rutgers.edu/LCSR-Computing/some-docs/emacs-chart.html>

(global-set-key (kbd "C-x") ctl-x-map)

; <>
(global-set-key (kbd "RET") 'newline-and-indent) ;newline
(global-set-key (kbd "<tab>") 'indent-for-tab-command)
(global-set-key (kbd "<del>") 'backward-delete-char)
(global-set-key (kbd "<ins>") 'delete-char)
(global-set-key (kbd "<f9>") 'compile)
;(global-set-key [home] 'beginning-of-line)
;(global-set-key [end] 'end-of-line)

; C-<>
(global-set-key (kbd "C-a") 'beginning-of-line)
(global-set-key (kbd "C-d") 'send-shell-eof)
(global-set-key (kbd "C-e") 'end-of-line)
(global-set-key (kbd "C-g") 'keyboard-quit)
(global-set-key (kbd "C-k") 'kill-line)
(global-set-key (kbd "C-l") 'recenter)
(global-set-key (kbd "C-p") 'match-parenthesis)
(global-set-key (kbd "C-r") 'replace-regexp)
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-t") 'replace-rectangle)
(global-set-key (kbd "C-w") 'kill-region)
(global-set-key (kbd "C-y") 'yank)
(global-set-key (kbd "C-z") 'suspend-emacs)
(global-set-key (kbd "C-SPC") 'set-mark)

; C-c <>
(global-set-key (kbd "C-c c") 'kill-ring-save)
(global-set-key (kbd "C-c d") 'clone-line)
(global-set-key (kbd "C-c q") 'indent-region)
(global-set-key (kbd "C-c u") 'kill-whole-line)
(global-set-key (kbd "C-c w") 'delete-trailing-whitespace)

; C-c C-<>
;(global-set-key (kbd "C-c C-c")  'comment-region)
;(global-set-key (kbd "C-c C-u")  'uncomment-region)

; C-x <>
(global-set-key (kbd "C-x d") 'downcase-region) ;downcase-word
(global-set-key (kbd "C-x l") 'global-linum-mode)
(global-set-key (kbd "C-x u") 'upcase-region) ;upcase-word
(global-set-key (kbd "C-x x") 'erase-buffer)
(global-set-key (kbd "C-x 1") 'delete-window)
(global-set-key (kbd "C-x 2") 'delete-other-windows)
(global-set-key (kbd "C-x =") 'count-lines-region)
(global-set-key (kbd "C-x $") 'shell-command)
(global-set-key (kbd "C-x #") 'eshell)
(global-set-key (kbd "C-x ]") 'scroll-up) ;backward-page
(global-set-key (kbd "C-x [") 'scroll-down) ;forward-page
(global-set-key (kbd "C-x }") 'end-of-buffer)
(global-set-key (kbd "C-x {") 'beginning-of-buffer)
(global-set-key (kbd "C-x -") 'advertised-undo)
(global-set-key (kbd "C-x _") 'revert-buffer)
(global-set-key (kbd "C-x SPC") 'mark-paragraph)

; C-x C-<>
(global-set-key (kbd "C-x C-b") 'electric-buffer-list)
(global-set-key (kbd "C-x C-c") 'save-buffers-kill-emacs)
(global-set-key (kbd "C-x C-d") 'dired-at-point)
(global-set-key (kbd "C-x C-f") 'find-file-at-point)
(global-set-key (kbd "C-x C-i") 'insert-file)
(global-set-key (kbd "C-x C-r") 'string-insert-rectangle)
(global-set-key (kbd "C-x C-s") 'save-buffer)
(global-set-key (kbd "C-x C-w") 'write-file)

; M-<>
(global-set-key (kbd "M-a") 'apply-shell)
(global-set-key (kbd "M-g") 'goto-line)
(global-set-key (kbd "M-i") 'insert-shell)
(global-set-key (kbd "M-w") 'mark-whole-buffer)

(provide 'bindkeys)

;; EOF
