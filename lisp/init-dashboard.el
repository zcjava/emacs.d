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
  )

(use-package page-break-lines
  :config
  (setq turn-on-page-break-lines-mode t)
  )


(provide 'init-dashboard)
