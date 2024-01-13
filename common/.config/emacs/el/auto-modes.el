;;
;; Modes auto
;;

(provide 'auto-modes)

;; shells
(add-to-list 'auto-mode-alist '("\\.\\([a-z]+sh\\)\\(rc\\)?$" . sh-mode))
(add-to-list 'auto-mode-alist '("\\.[a-z]+sh\\(rc\\|_[a-z]+\\)$" . sh-mode))
;; shells/zsh
(add-to-list 'auto-mode-alist '("[a-z]+shrc$" . sh-mode))
(add-to-list 'auto-mode-alist '("\\.zsh-[a-z]+$" . sh-mode))
(add-to-list 'auto-mode-alist '("prompt_[a-z]+_setup$" . sh-mode))

;; EOF
