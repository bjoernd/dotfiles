; C/C++ tabs, spaces and indents
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)

(smart-tabs-insinuate 'c 'c++)
(add-hook 'c-mode-hook (lambda () (setq indent-tabs-mode t)))
(add-hook 'c++-mode-hook (lambda () (setq indent-tabs-mode t)))

; whitespace highlighting
(require 'whitespace)

(provide 'init-wsindent)
