;;; cc-helm.el --- Helm configuration

;; Author: chrischen
;; Maintainer: chrischen

;; This file is not part of GNU Emacs

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; For a full copy of the GNU General Public License
;; see <http://www.gnu.org/licenses/>.

;;; Commentary:
;;

;;; Code:
(use-package
  helm
  :init (setq helm-split-window-in-side-p t ; open helm buffer inside currbbent window, not occupy whole other window
              helm-ff-search-library-in-sexp t ; search for library in `require' and `declare-function' sexp.
              helm-scroll-amount 8 ; scroll 8 lines other window using M-<next>/M-<prior>
              helm-ff-file-name-history-use-recentf t
              helm-echo-input-in-header-line t)
  :demand
  :custom ((completion-styles '(flex))
           (helm-net-prefer-curl t)
           (helm-autoresize-max-height 0)
           (helm-autoresize-min-height 25)
           (helm-buffers-fuzzy-matching t)
           (helm-recentf-fuzzy-match t))
  :bind-keymap ("C-c h" . helm-command-prefix)
  :bind (([remap execute-extended-command] . helm-M-x)
         ([remap find-file] . helm-find-files)
         ([remap occur] . helm-occur)
         ([remap list-buffers] . helm-buffers-list)
         ([remap switch-to-buffer] . helm-mini)
         :map helm-map ("<tab>" . helm-execute-persistent-action)
         ("C-i" . helm-select-action)
         ("S-SPC" . helm-toggle-visible-mark-forward))
  :hook (after-init . helm-autoresize-mode)
  :config (global-unset-key (kbd "C-x c"))
  (which-key-add-key-based-replacements "C-c h" "helm-commands")
  (which-key-add-key-based-replacements "C-c h h" "help"))


(use-package
  helm-icons
  :after all-the-icons
  :custom ((helm-icons-provider 'all-the-icons)
           (helm-icons-mode->icon nil)) ; workaround for "f-filename: Wrong type argument: stringp, dir-closed"
  :config (helm-icons-enable))

(provide 'cc-helm)

;;; cc-helm.el ends here
