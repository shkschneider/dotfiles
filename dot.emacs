;;
;; ~/.emacs -- emacs configuration
;; Copyright (C) 2009-2012  Alan "Shtark" SCHNEIDER
;;                          <shk.schneider[at]gmail.com>
;;
;; This program comes with ABSOLUTELY NO WARRANTY.
;; This is free software, and you are welcome to redistribute it
;; under certain conditions.
;;

;; dot.emacs r1

;; Most oftently changed setting
(normal-erase-is-backspace-mode 1)

;; Autoload
;(if (file-exists-p (expand-file-name "~/.emacs.d"))
;    (add-to-list 'load-path (expand-file-name "~/.emacs.d/"))
;    (require 'shebang)
;    (require 'php-mode)
;)

;; KeyBinding
(global-set-key (kbd "RET") 'newline-and-indent)
(global-set-key [home] 'beginning-of-line)
(global-set-key [end] 'end-of-line)
(global-set-key [(meta g)] 'goto-line)
(global-set-key (kbd "C-c C-q") 'indent-region)
(global-set-key (kbd "C-c C-w") 'delete-trailing-whitespace)
(global-set-key [(control r)] 'replace-regexp)
(global-set-key [(control t)] 'replace-rectangle)
(global-set-key [(control l)] 'global-linum-mode)

;; Emacs23+
;(server-start)

;; Author
(setq user-full-name "Alan SCHNEIDER")
(setq user-mail-address "shk.schneider@gmail.com")

;; Language
(set-language-environment 'utf-8)
(prefer-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(setq locale-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)

;; Interface
(setq inhibit-splash-screen t
      initial-scratch-message nil
      inhibit-startup-message t)
(menu-bar-mode nil)
(setq truncate-partial-width-windows nil) ; do not split lines
(setq visible-bell t)
(setq line-number-mode t
      column-number-mode t
      linum-format "%\ 3d ")
(global-linum-mode 1)
(setq display-time-format " %A %e %B %Y, %H:%M "
      display-time-24hr-format t)
(display-time)
(blink-cursor-mode t) ; makes cursor blink
(setq-default show-trailing-whitespace t)

;; Colors
(global-font-lock-mode 1) ; colorfull
(show-paren-mode 1) ; highlight parent items
(transient-mark-mode t) ; highlight selection
(setq search-highlight t)

;; Edition
(setq scroll-step 1)
(delete-selection-mode t)
(setq mouse-yank-at-point t)

;; Fix
(fset 'yes-or-no-p 'y-or-n-p)
(setq make-backup-files nil)
(setq confirm-kill-emacs nil)
; DONT USE TABS

;; EOF
