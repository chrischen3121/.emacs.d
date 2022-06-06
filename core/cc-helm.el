(use-package
  helm
  :init
  (setq helm-split-window-in-side-p t ; open helm buffer inside current window, not occupy whole other window
        helm-ff-search-library-in-sexp t ; search for library in `require' and `declare-function' sexp.
        helm-scroll-amount 8 ; scroll 8 lines other window using M-<next>/M-<prior>
        helm-ff-file-name-history-use-recentf t
        helm-echo-input-in-header-line t)
  :custom (completion-styles '(flex))
  (helm-net-prefer-curl t)
  (helm-autoresize-max-height 0)
  (helm-autoresize-min-height 20)
  :bind-keymap
  ("C-c h" . helm-command-map)
  :bind (("C-x c" . nil)
         ([remap execute-extended-command] . helm-M-x)
         ([remap find-file] . helm-find-files)
         ([remap occur] . helm-occur)
         ([remap list-buffers] . helm-buffers-list)
         ([remap switch-to-buffer] . helm-mini)
         :map helm-map ("<tab>" . helm-execute-persistent-action)
         ("C-i" . helm-select-action)
         ("S-SPC" . helm-toggle-visible-mark-forward))
  :config
  (helm-autoresize-mode 1)
  (which-key-add-key-based-replacements "C-c h" "helm command"))

(use-package
  helm-icons
  :custom (helm-icons-provider 'all-the-icons)
  :config (helm-icons-enable))

(provide 'cc-helm)
