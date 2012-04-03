;;
;; templates.el -- emacs configuration for templates
;; Copyright (C) 2012  Alan SCHNEIDER
;;                     <shk.schneider[at]gmail.com>
;;
;; This program comes with ABSOLUTELY NO WARRANTY.
;; This is free software, and you are welcome to redistribute it
;; under certain conditions.
;;

;; ~/.emacs.d/templates.el r2

; From <http://repo.or.cz/w/emacs.git/blob_plain/HEAD:/lisp/autoinsert.el>
(auto-insert-mode)
(setq auto-insert-directory "~/.emacs.d/templates.d/")
(setq auto-insert-query nil)

(define-auto-insert "\\.sh$" "template.sh")
(define-auto-insert "\\.bash$" "template.bash")
(define-auto-insert "\\.c$" "template.c")
(define-auto-insert "\\.h$" "template.h")
(define-auto-insert "\\.css$" "template.css")
(define-auto-insert "\\.html$" "template.html")
(define-auto-insert "Makefile$" "template.makefile")
(define-auto-insert "\\.js$" "template.js")
(define-auto-insert "\\.pl$" "template.pl")
(define-auto-insert "\\.py$" "template.py")
(define-auto-insert "\\.php$" "template.php")
(define-auto-insert "\\.el$" "template.el")
(define-auto-insert "\\.conf$" "template.conf")
(define-auto-insert "\\.rb$" "template.rb")
(define-auto-insert "\\.cs$" "template.cs")

(provide 'templates)

;; EOF
