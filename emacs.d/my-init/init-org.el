(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-font-lock-mode 1)

(setq org-support-shift-select t)

(setq org-adapt-indentation t)
(setq org-startup-indented t)


(setq org-todo-keywords
      '((sequence "TODO" "PENDING" "DONE")
        (sequence "REPORTED" "TRIAGED" "ANALYZED" "FIXED"))
      )

(setq org-todo-keyword-faces
      '(("PENDING" . (:foreground "yellow" :weight "bold"))
        ("TRIAGED" . (:foreground "yellow" :weight "bold"))
        ("ANALYZED" . (:foreground "yellow" :weight "bold")))
)

(setq org-log-done 'time)
             
(provide 'init-org)
