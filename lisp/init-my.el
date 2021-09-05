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


(defun copy-file-path ()
  "Put the current file name on the clipboard"
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode)
                      default-directory
                    (buffer-file-name))))
    (when filename
      (with-temp-buffer
        (insert filename)
        (clipboard-kill-region (point-min) (point-max)))
      (message filename))))

;;==========myself custom==========

(provide 'init-my)
