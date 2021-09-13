(use-package projectile
  :config
  (projectile-global-mode)
  ;; 注意rg会忽略gitignore的文件，所以如果需要unignore某些在gitignore的文件：需要设置(setq projectile-indexing-method 'native)
  ;; counsel-projectile-rg 忽略不忽略由 .gitginore + .ignore(.ignore优先级高于.gitignore)共同决定；
  ;; counsel-projectile-find-file 忽略不忽略由 .projectile 决定
  (setq projectile-indexing-method 'native)
  (setq projectile-enable-caching t)

  (setq projectile-globally-ignored-directories
        (append (list
                 ".pytest_cache"
                 "__pycache__"
                 "build"
                 "elpa"
                 "node_modules"
                 "output"
                 "reveal.js"
                 "semanticdb"
                 "target"
                 "venv"
                 )
                projectile-globally-ignored-directories))
  )

(use-package treemacs-projectile)

(provide 'init-projectile)
