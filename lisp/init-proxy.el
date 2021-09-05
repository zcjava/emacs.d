(setq smile-proxy_addr "127.0.0.1:52067")
(defun proxy-show ()
  "Show http/https proxy."
  (interactive)
  (if url-proxy-services
      (message "Current proxy is \"%s\"" smile-proxy_addr)
    (message "No proxy")))

(defun proxy-set ()
  (interactive)
  (setq url-proxy-services
        `(("no_proxy" . "^\\(localhost\\|10.*\\)")
          concat("http" . ,smile-proxy_addr)
          ("https" . ,smile-proxy_addr)))
  (proxy-show))

(defun proxy-unset ()
  "Unset http/https proxy."
  (interactive)
  (setq url-proxy-services nil)
  (proxy-show))

(defun proxy-toggle ()
  "Toggle http/https proxy."
  (interactive)
  (if url-proxy-services
      (proxy-unset)
    (proxy-set)))

(provide 'init-proxy)
