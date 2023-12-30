;; ~/.emacs.d/el/timestamp.el

(setq time-stamp-pattern "8/Last modified:[ \t]+\\\\?[\"<]+%:y-%02m-%02d %02H:%02M:%02S %u\\\\?[\">]")
(setq time-stamp-format "%:y-%02m-%02d %02H:%02M:%02S %u %f")
(add-hook 'before-save-hook 'time-stamp)

(provide 'timestamp)

;; EOF
