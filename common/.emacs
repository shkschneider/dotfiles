;; ~/.emacs

;(setq package-enable-at-startup nil) > ~/.emacs.d/early-init.el
(load-file "~/.emacs.d/init.el")

(if (file-exists-p (expand-file-name "~/.emacs.local")) (load-file (expand-file-name "~/.emacs.local")))

;(fset 'yes-or-no-p 'y-or-n-p)

;; EOF
