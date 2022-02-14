(use-package web-mode
  :mode ("\\.html\\'" "\\.css\\'")
  :config
  (add-hook 'web-mode-hook 'prettier-js-mode)
  )

(use-package prettier-js
  )
(provide 'init-html)
