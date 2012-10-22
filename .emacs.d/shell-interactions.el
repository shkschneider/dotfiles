;; ~/.emacs.d/shell-interactions.el

; Thx <http://www.squidoo.com/emacs-command>

(defun insert-shell(&optional arg)
  (interactive)
  (insert (shell-command-to-string (read-from-minibuffer "Command: ")))
  )

; Thx <http://stackoverflow.com/questions/1548605/emacs-lisp-shell-command-on-region>

(defun apply-shell(&optional start end)
  (interactive "r")
  (shell-command-on-region start end (read-from-minibuffer "Command: ") (current-buffer) t)
  )


(provide 'shell-interactions)

;; EOF
