;;==========myself custom fun==========


(defun open-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el")
  )

(global-set-key (kbd "<C-return>") 'newline-code-tab)

(defun newline-code-tab()
  (interactive)
  (newline-and-indent)
  (newline-and-indent)
  (previous-line)
  (indent-for-tab-command)
  )


(defun copy-path()
;;  (setq default-directory "~/")  
  (interactive)
  (setq currentdir "~/")
  (message "%s" currentdir)
  (x-select-text currentdir)
  )
;;==========myself custom==========

(provide 'init-my)
