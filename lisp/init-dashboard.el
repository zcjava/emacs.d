(use-package dashboard
  :config
  (dashboard-setup-startup-hook)
  (dashboard-modify-heading-icons '((recents . "file-text")
                                    (boomarks . "book")
                                    ))
  (setq dashboard-banner-logo-title "Life is happy")
  (setq dashboard-startup-banner (expand-file-name "site-lisp/banner.png" user-emacs-directory))
  (setq dashboard-center-content t)
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-set-navigator t)

  (setq dashboard-items '((recents  . 5)
                          (bookmarks . 5)
                          (projects . 5)
                          (agenda . 5)
                          ))
  (setq dashboard-projects-switch-function 'counsel-projectile-switch-project-by-name)
  (setq dashboard-page-separator "\n\f\n")
  )


(use-package page-break-lines
  :config
  (setq page-break-lines-char)
  )


(provide 'init-dashboard)
