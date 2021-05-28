(use-package leetcode
  :config
  (setq leetcode-prefer-language "java")
  (setq leetcode-prefer-sql "mysql")
  (setq leetcode-save-solutions t)
  (setq leetcode-directory (expand-file-name "~/Desktop/note/leetcode/"))
  )

(provide 'init-leetcode)
