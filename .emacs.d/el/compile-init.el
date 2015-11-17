;; ~/.emacs.d/el/compile.el

(defun compile-init-file ()
  (let ((byte-compile-warnings '(unresolved)))
    (byte-compile-file user-init-file)
    (message "Emacs init file saved and compiled.")))

(defun compile-init-hook ()
  (if (string-equal buffer-file-name (expand-file-name user-init-file))
      (progn (add-hook 'after-save-hook 'compile-init-file t t))
    )
  )

(add-hook 'emacs-lisp-mode-hook 'compile-init-hook)

(provide 'compile-init)

;; EOF
