(require 'cl)

; themes
(add-to-list 'custom-theme-load-path '"~/.emacs.d/themes")

(add-to-list 'load-path (expand-file-name "my-init" user-emacs-directory))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("b73c22111068f51f332cf73ea2eae196b2377c3218054c1bcd436e27e5eeac3e" "f2f2941e226bc578fa82b8badbb6ff252eef6b50b6f8f6263f8102cf5e029db8" "f641bdb1b534a06baa5e05ffdb5039fb265fde2764fbfd9a90b0d23b75f3936b" "ee17bcdaa3ce2c5b287dff4d4c1da13f45bfa2f1aa9e11ff0bbbebb2e6be79c5" "e4015539e6a04b69bca5a8097895bf98b625d8495a996719753a6fba7739d3ba" default)))
 '(inhibit-startup-screen t)
 '(org-agenda-files
   (quote
    ("~/Dropbox/org-notes/teaching.org" "~/Dropbox/org-notes/diss.org"))))

(require 'init-generic)
(require 'init-wsindent)
(require 'init-auto-header)
(require 'init-ac)
(require 'init-org)
(require 'init-hacking)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
