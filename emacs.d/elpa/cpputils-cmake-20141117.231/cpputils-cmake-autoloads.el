;;; cpputils-cmake-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (or (file-name-directory #$) (car load-path)))

;;;### (autoloads nil "cpputils-cmake" "cpputils-cmake.el" (21619
;;;;;;  1979 735843 988000))
;;; Generated autoloads from cpputils-cmake.el

(autoload 'cppcm-get-exe-path-current-buffer "cpputils-cmake" "\


\(fn)" t nil)

(autoload 'cppcm-version "cpputils-cmake" "\


\(fn)" t nil)

(autoload 'cppcm-compile "cpputils-cmake" "\
compile the executable/library in current directory,
default compile command or compile in the build directory.
You can specify the sequence which compile is default
by customize `cppcm-compile-list'.

\(fn &optional PREFIX)" t nil)

(autoload 'cppcm-recompile "cpputils-cmake" "\
make clean;compile

\(fn)" t nil)

(autoload 'cppcm-reload-all "cpputils-cmake" "\
reload and reproduce everything

\(fn)" nil nil)

;;;***

;;;### (autoloads nil nil ("cpputils-cmake-pkg.el") (21619 1979 852404
;;;;;;  598000))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; cpputils-cmake-autoloads.el ends here
