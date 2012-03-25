;;
;; abbrevs.el -- emacs configuration for abbrevss
;; Copyright (C) 2012  Alan SCHNEIDER
;;                     <shk.schneider[at]gmail.com>
;;
;; This program comes with ABSOLUTELY NO WARRANTY.
;; This is free software, and you are welcome to redistribute it
;; under certain conditions.
;;

;; ~/.emacs.d/abbrevs.el r0

(setq-default abbrev-mode t)
(read-abbrev-file "~/.emacs.d/abbrevs.el")
(setq save-abbrevs t)

(provide 'abbrevs)

;; EOF
