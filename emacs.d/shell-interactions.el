;;
;; shell-interactions.el -- emacs configuration for shell commands
;; Copyright (C) 2012  Alan SCHNEIDER
;;                     <shk.schneider[at]gmail.com>
;;
;; This program comes with ABSOLUTELY NO WARRANTY.
;; This is free software, and you are welcome to redistribute it
;; under certain conditions.
;;

;; ~/.emacs.d/shell-interactions.el r0

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

(defun apply-sed(&optional start end)
  (interactive "r")
  (shell-command-on-region start end (concat "sed -r 's/"
                                             (read-from-minibuffer "Sed (search/replace): ")
                                             "'/g"
                                             ) (current-buffer) t)
  )

(provide 'shell-interactions)

;; EOF
