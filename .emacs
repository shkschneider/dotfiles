;; ~/.emacs

;; Most oftently changed setting

(normal-erase-is-backspace-mode 0)

;; Emacs23+

;(if (>= emacs-major-version 23) (server-start))

;; Author

;(setq user-full-name "User Name")
;(setq user-mail-address "you@gmail.com")

;; CustomConf & Autoload

(if (file-exists-p (expand-file-name "~/.myemacs")) (load-file (expand-file-name "~/.myemacs")))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/"))
(require 'shebang nil 'noerror)
(require 'templates nil 'noerror)
(require 'shell-interactions nil 'noerror)
(require 'bindkeys nil 'noerror)
(require 'timestamp nil 'noerror)
;(require 'compile-init nil 'noerror)
;(require 'abbrev)

;; Language

(prefer-coding-system 'utf-8)
(set-language-environment 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(setq locale-coding-system 'utf-8)

;; Interface

(setq inhibit-splash-screen t
      initial-scratch-message nil
      inhibit-startup-message t)
(menu-bar-mode -1)
(setq truncate-partial-width-windows nil)
(setq visible-bell t)
;(setq ring-bell-function (lambda() (call-process "artsplay" nil 0 nil "/path/to/audio/file"))
(setq line-number-mode t
      column-number-mode t
      linum-format "%\ 3d ")
(global-linum-mode t)
(setq display-time-format " %A %e %B %Y, %H:%M "
      display-time-24hr-format t)
(display-time)
(setq-default show-trailing-whitespace t)
(setq european-calendar-style 't)
(setq calendar-week-start-day 1)
;TODO: disable mouse wheel scroll

(global-font-lock-mode t)
(show-paren-mode t)
(transient-mark-mode t)
(setq search-highlight t)

;(global-hl-line-mode t)

;; Edition

(setq scroll-step 1)
(delete-selection-mode t)
(setq mouse-yank-at-point t)
(setq backup-directory-alist '(("." . "/.emacs.d/tmp")))
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(setq next-line-add-newlines nil)
(setq default-major-mode 'text-mode)
(global-auto-revert-mode 1)
(setq x-select-enable-clipboard t)
;TODO: (shift-select-mode t)

;; Functions

(defun top-of-screen()
  (interactive)
  (forward-line (- (window-height) 2))
  )

(defun bottom-of-screen()
  (interactive)
  (forward-line (- (- (window-height) 2)))
  )

(defun clone-line()
  (interactive)
  (save-excursion
    (beginning-of-line)
    (let ((begin(point)))
      (forward-line)
      (copy-region-as-kill begin(point))
      (yank)
      (forward-line -1)
      (back-to-indentation)
      )
    )
  )

(defun kill-whole-line()
  (interactive)
  (save-excursion
    (beginning-of-line)
    (let ((begin(point)))
      (forward-line)
      (kill-region begin(point))
      (forward-line -1)
      (back-to-indentation)
      )
    )
)

(defun match-parenthesis(args)
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1))
	(t (backward-char 1)
	   (cond ((looking-at "\\s\)")
		  (forward-char 1) (backward-list 1))
		 (t (while (not (looking-at "\\s("))
		      (backward-char 1)
		      (cond ((looking-at "\\s\)")
			     (message "->> )")
			     (forward-char 1)
			     (backward-list 1)
			     (backward-char 1)))
		      ))
		 )
	   ))
  )

;; Fix

(add-hook 'before-save-hook (lambda ()
                              (when buffer-file-name
                                (let ((dir (file-name-directory buffer-file-name)))
                                  (when (and (not (file-exists-p dir))
                                             (y-or-n-p (format "Directory %s does not exist. Create it?" dir)))
                                    (make-directory dir t)
                                    )
                                  )
                                )
                              ))

(fset 'yes-or-no-p 'y-or-n-p)

(setq make-backup-files nil)
(setq confirm-kill-emacs nil)
(setq require-final-newline t)
(setq-default indent-tabs-mode nil)

(put 'overwrite-mode 'disabled t)
(put 'erase-buffer 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

;; EOF
