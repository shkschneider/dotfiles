;;
;; timestamp.el -- emacs configuration for time-stamp
;; Copyright (C) 2012  Alan SCHNEIDER
;;                     <shk.schneider[at]gmail.com>
;;
;; This program comes with ABSOLUTELY NO WARRANTY.
;; This is free software, and you are welcome to redistribute it
;; under certain conditions.
;;

;; ~/.emacs.d/timestamp.el r0

(setq time-stamp-pattern "8/Last modified:[ \t]+\\\\?[\"<]+%:y-%02m-%02d %02H:%02M:%02S %u\\\\?[\">]")
(setq time-stamp-format "%:y-%02m-%02d %02H:%02M:%02S %u %f")
(add-hook 'before-save-hook 'time-stamp)

(provide 'timestamp)

;; EOF
