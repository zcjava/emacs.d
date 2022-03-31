(use-package clojure-mode
  :ensure t
  :init
  (setq lsp-clojure-custom-server-command '("bash" "-c" "/opt/homebrew/bin/clojure-lsp"))
  :config
  (add-hook 'clojure-mode-hook 'lsp)
  (add-hook 'clojurec-mode-hook 'lsp)
  (add-hook 'clojurescript-mode-hook 'lsp)
  (require 'flycheck-clj-kondo)
  )


(use-package flycheck-clj-kondo
  :ensure t)

(use-package cider
  :ensure t
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (dolist (checkers '((clj-kondo-clj . clojure-joker)                        ;;
;;                     (clj-kondo-cljs . clojurescript-joker)                 ;;
;;                     (clj-kondo-cljc . clojure-joker)                       ;;
;;                     (clj-kondo-edn . edn-joker)))                          ;;
;;   (flycheck-add-next-checker (car checkers) (cons 'error (cdr checkers)))) ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; need install tools


;; brew install clojure/tools/clojure
;; brew install clojure-lsp/brew/clojure-lsp-native
;; brew install borkdude/brew/clj-kondo
;; brew install leiningen
;; brew install --cask zprint

(provide 'init-lsp-clojure)
