(defun my-hacking-init ()
  ; global tags integration
  (gtags-mode t)
  ; show function name in mode line
  (which-function-mode t)
  ; coordinates in mode line
  (column-number-mode t)
  ; and line numbers
  (linum-mode t)
  )


(add-hook 'c-mode-common-hook 'my-hacking-init)
(add-hook 'c++-mode-hook 'my-hacking-init)


(provide 'init-hacking)
