(use-package lsp-dart
  :ensure t
  :hook (dart-mode . lsp)
  )

(use-package hover
  :ensure t
  )

;; (use-package lsp-dart
;;   :ensure t
;;   :hook (dart-mode . lsp)
;;   :init
;;   (dap-register-debug-template "Flutter :: Custom debug"
;;                                (list :flutterPlatform ""
;;                                      :program "lib/main_debug.dart"
;;                                      :args '("--flavor" "customer_a"))))

(provide 'init-lsp-flutter)
