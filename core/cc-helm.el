(use-package
  helm
  :custom (completion-styles '(flex))
  :bind
  (("C-x c" . nil)
  ;; TODO: ("C-c h" . helm-command-prefix-key)
  ([remap execute-extended-command] . helm-M-x)
  ([remap find-file] . helm-find-files)
  ([remap occur] . helm-occur)
  ([remap list-buffers] . helm-buffers-list)
  ([remap switch-to-buffer] . helm-mini)
  :map helm-map
  ("<tab>" . helm-execute-persistent-action)
  ("C-i" . helm-select-action)
  ("S-SPC" . helm-toggle-visible-mark-forward)))

(provide 'cc-helm)
