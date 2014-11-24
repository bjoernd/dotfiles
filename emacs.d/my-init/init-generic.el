; themes stuff
(load-theme 'Amelie t)
(set-cursor-color "#ffffff")


; EMACS Package archive stuff...
(require 'package)
(setq package-archives '(("melpa" . "http://melpa.milkbox.net/packages/")))
(package-initialize)

; disable audible bell
(setq visible-bell 1 ring-bell-function ())

; set font size
(set-face-attribute 'default nil :height 100)

; window size
(setq default-frame-alist
      '(
        (width . 100) ; character
        (height . 70) ; lines
        ))

; highlight matching parentheses
(show-paren-mode 1)
(setq show-paren-delay 0)

; yasnippet snippet manager
(require 'yasnippet)
(yas-global-mode 1)

(provide 'init-generic)
