 ; auto-complete tools
(require 'auto-complete)
(require 'auto-complete-config)
(setq ac-menu-height 20)
(setq ac-auto-start 3)
(setq ac-delay 1)
(setq ac-quick-help-delay 0.5)
(setq ac-use-fuzzy t)
(define-key ac-mode-map  (kbd "C-n") 'auto-complete)

(defun my-ac-config ()
  (setq-default ac-sources
                '(ac-source-abbrev ac-source-dictionary ac-source-words-in-same-mode-buffers))
  (add-hook 'emacs-lisp-mode-hook 'ac-emacs-lisp-mode-setup)
  (add-hook 'auto-complete-mode-hook 'ac-common-setup)
  (global-auto-complete-mode t))


(defun my-ac-cc-mode-setup ()
  (add-to-list 'load-path "~/.emacs.d/ac-clang-async")
  (require 'auto-complete-clang-async)
  (setq ac-clang-complete-executable "~/.emacs.d/ac-clang-async/clang-complete")
  (setq ac-sources '(ac-source-clang-async))

  (setq clang-include-dir-str "
 /usr/include/c++/4.9
 /usr/include/x86_64-linux-gnu/c++/4.9
 /usr/include/c++/4.9/backward
 /usr/lib/gcc/x86_64-linux-gnu/4.9/include
 /usr/local/include
 /usr/lib/gcc/x86_64-linux-gnu/4.9/include-fixed
 /usr/include/x86_64-linux-gnu
 /usr/include
 /usr/local/include/elkvm
")
  (setq clang-iflags
         (mapcar (lambda (item) (concat "-I" item))
                 (split-string clang-include-dir-str))
         )
  (setq ac-clang-cflags (append '("-g" "-std=c++11" "-msse4") clang-iflags))
        

  (setq ac-clang-auto-save t)
  (ac-clang-launch-completion-process)
  )

(add-hook 'c-mode-common-hook 'my-ac-cc-mode-setup)
(add-hook 'c++-mode-hook 'my-ac-cc-mode-setup)

(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)
(my-ac-config)

(provide 'init-ac)
