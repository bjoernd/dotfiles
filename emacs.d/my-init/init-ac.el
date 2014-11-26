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

  (global-set-key (kbd "C-S-m") 'compile)
  
  (let ((bname (buffer-file-name)))
    (cond
     ; L4Re-specific configuration
     ((string-match "l4/pkg" bname)
      (setq clang-include-dir-str "
/home/doebel/src/tudos/l4/build/include/contrib/libstdc++-v3
/home/doebel/src/tudos/l4/build/include/contrib/libudis86
/home/doebel/src/tudos/l4/build/include/contrib/libiniparser
/home/doebel/src/tudos/l4/build/include/contrib/zlib
/home/doebel/src/tudos/l4/build/include/contrib/
/home/doebel/src/tudos/l4/build/include/x86/l4f
/home/doebel/src/tudos/l4/build/include/l4f
/home/doebel/src/tudos/l4/build/include/x86
/home/doebel/src/tudos/l4/build/include
/home/doebel/src/tudos/l4/build/include/uclibc
/home/doebel/src/tudos/l4/build/include/contrib/libstdc++-v3
")
      (setq clang-pre-flags '("-nostdinc" "-g" "-std=c++11" "-m32" "-DSYSTEM_x86_586_l4f"
                              "-DARCH-x86" "-DCPUTYPE_586" "-DL4API_l4f" "-D_GNU_SOURCE" "-D__L4"
                              "-fexceptions" "-fno-omit-frame-pointer" "-fno-strict-aliasing"))
      (setq clang-add-flags '("-isystem /usr/lib/gcc/x86_64-linux-gnu/4.9/include"
                              "-isystem /usr/lib/gcc/x86_64-linux-gnu/4.9/include-fixed" ))

      ; Build a compile command for L4Re:
      ; 1) extract pkg name from directory name
      (setq pkgdir (car (last (split-string (file-name-directory buffer-file-name) "l4/pkg"))))
      ; 2) build dir = $BUILD + pkg name
      ; XXX might want to have a config value for the build dir?
      (setq buildbase "/home/doebel/src/tudos/l4/build/pkg")
      (setq builddir(concat buildbase pkgdir))
      ; 3) set the compile command
      (set 'compile-command
           (concat " make -j4 -C " builddir))
      )
     
     ; Everthing else (aka Linux programming)
    ((t) (setq clang-include-dir-str "
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
     (setq clang-pre-flags ())
     (setq clang-add-flags '("-x c++" "-g" "-std=c++11" "-msse4"))
     )
    ))
  
  (setq clang-iflags
         (mapcar (lambda (item) (concat "-I" item))
                 (split-string clang-include-dir-str))
         )
  (setq ac-clang-cflags (append clang-pre-flags clang-iflags clang-add-flags))

  (setq ac-clang-auto-save t)
  (ac-clang-launch-completion-process)
  )

(add-hook 'c-mode-common-hook 'my-ac-cc-mode-setup)
(add-hook 'c++-mode-hook 'my-ac-cc-mode-setup)

(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)
(my-ac-config)

(provide 'init-ac)
