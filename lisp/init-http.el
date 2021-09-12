(use-package restclient
  :config
  (add-to-list 'company-backends 'company-restclient)
  )
(use-package company-restclient
  :after(restclient-mode)
  )

(add-to-list 'auto-mode-alist '("\\.hpct\\'" . restclient-mode))


(provide 'init-http)
