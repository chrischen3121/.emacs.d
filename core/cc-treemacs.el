;;; cc-treemacs.el

;; Author: Chris Chen
;; Maintainer: Chris Chen

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

;;; Code:


(use-package
  treemacs
  :defer t
  :custom (treemacs-deferred-git-apply-delay 0.5)
  (treemacs-directory-name-transformer #'identity)
  (treemacs-display-in-side-window t)
  (treemacs-eldoc-display t)
  (treemacs-file-event-delay 5000)
  (treemacs-file-extension-regex treemacs-last-period-regex-value)
  (treemacs-file-follow-delay 0.2)
  (treemacs-file-name-transformer #'identity)
  (treemacs-follow-after-init t)
  (treemacs-git-command-pipe "")
  (treemacs-goto-tag-strategy 'refetch-index)
  (treemacs-indentation 2)
  (treemacs-indentation-string " ")
  (treemacs-is-never-other-window nil)
  (treemacs-max-git-entries 5000)
  (treemacs-missing-project-action 'ask)
  (treemacs-move-forward-on-expand nil)
  (treemacs-no-png-images nil)
  (treemacs-no-delete-other-windows t)
  (treemacs-project-follow-cleanup nil)
  (treemacs-persist-file (expand-file-name ".cache/treemacs-persist" user-emacs-directory))
  (treemacs-position 'left)
  (treemacs-read-string-input 'from-child-frame)
  (treemacs-recenter-distance 0.1)
  (treemacs-recenter-after-file-follow nil)
  (treemacs-recenter-after-tag-follow nil)
  (treemacs-recenter-after-project-jump 'always)
  (treemacs-recenter-after-project-expand 'on-distance)
  (treemacs-show-cursor nil)
  (treemacs-show-hidden-files t)
  (treemacs-silent-filewatch nil)
  (treemacs-silent-refresh nil)
  (treemacs-sorting 'alphabetic-asc)
  (treemacs-space-between-root-nodes      t)
  (treemacs-tag-follow-cleanup t)
  (treemacs-tag-follow-delay 1.5)
  (treemacs-user-mode-line-format nil)
  (treemacs-user-header-line-format nil)
  (treemacs-width 35)
  (treemacs-workspace-switch-cleanup nil)
  :config (progn
      ;; The default width and height of the icons is 22 pixels. If you are
      ;; using a Hi-DPI display, uncomment this to double the icon size.
      ;;(treemacs-resize-icons 44)
      (setq treemacs-collapse-dirs (if treemacs-python-executable 3 0))
      (treemacs-follow-mode t)
      (treemacs-filewatch-mode t)
      (treemacs-fringe-indicator-mode 'always)
      (pcase (cons (not (null (executable-find "git")))
       (not (null treemacs-python-executable)))
        (`(t . t)
         (treemacs-git-mode 'deferred))
        (`(t . _)
         (treemacs-git-mode 'simple)))
      (which-key-add-key-based-replacements "C-c t" "treemacs"))
  :bind (("C-c t w" . treemacs-select-window)
   ("C-c t k" . treemacs-delete-other-windows)
   ("C-c t t" . treemacs)
   ("C-c t a" . treemacs-add-project-to-workspace)
   ("C-c t b" . treemacs-bookmark)
   ("C-c t f" . treemacs-find-file)
   ("C-c t g" . treemacs-find-tag)))

(use-package
  treemacs-projectile
  :after (treemacs projectile))

(use-package
  treemacs-magit
  :after (treemacs magit))

(use-package
  treemacs-all-the-icons
  :after (treemacs all-the-icons)
  :config (treemacs-load-all-the-icons-with-workaround-font "Hermit"))

(provide 'cc-treemacs)

;;; cc-treemacs.el ends here
