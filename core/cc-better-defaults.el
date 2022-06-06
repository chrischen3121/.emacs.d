;;; cc-better-defaults.el
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
(defun cc-core/after-init-func ()
  (progn (toggle-frame-maximized)
         (tool-bar-mode -1)
         ;;(menu-bar-mode -1)
         (delete-selection-mode +1)
         (toggle-scroll-bar -1)
         (fset 'yes-or-no-p 'y-or-n-p)
         (display-battery-mode +1)))

(use-package
  emacs
  :delight
  :custom (inhibit-startup-screen t)
  (make-backup-files nil)
  (tab-width 4)
  (indent-tabs-mode nil)
  (auto-save-default nil)
  (split-height-threshold nil)
  (split-width-threshold 160)
  :hook (after-init . cc-core/after-init-func)
  (after-save . executable-make-buffer-file-executable-if-script-p))

;; use gruvbox-theme
(use-package
  gruvbox-theme
  :init (if (daemonp)
            (add-hook 'after-make-frame-functions (lambda (frame)
                                                    (select-frame frame)
                                                    (load-theme 'gruvbox-light-medium t)))
          (load-theme 'gruvbox-light-medium t)))

(use-package
  which-key
  :config (which-key-mode 1)
  (which-key-add-key-based-replacements "C-x ESC" "repeat-command")
  ;; (which-key-add-key-based-replacements "C-c ESC" "n/a")
  (which-key-add-key-based-replacements "C-x p" "project")
  (which-key-add-key-based-replacements "C-x t" "tab")
  (which-key-add-key-based-replacements "C-x RET" "coding-system")
  (which-key-add-key-based-replacements "C-x 8" "strange-chars")
  (which-key-add-key-based-replacements "C-x @" "event-apply")
  (which-key-add-key-based-replacements "C-x a" "abbrev")
  (which-key-add-key-based-replacements "C-x n" "narrow")
  (which-key-add-key-based-replacements "C-x r" "register")
  :delight)

(use-package
  whole-line-or-region
  :config (whole-line-or-region-global-mode +1)
  :delight whole-line-or-region-local-mode)


;; (use-package
;;   ibuffer
;;   :bind ("C-x C-b" . ibuffer))

;; (use-package
;;   ibuffer-projectile
;;   :after ibuffer
;;   :config (add-hook 'ibuffer-hook (lambda ()
;;                  (ibuffer-projectile-set-filter-groups)
;;                  (unless (eq ibuffer-sorting-mode 'alphabetic)
;;                    (ibuffer-do-sort-by-alphabetic)))))

;; (use-package
;;   all-the-icons-ibuffer
;;   :init (all-the-icons-ibuffer-mode +1))

(use-package
  ace-window
  :bind (([remap other-window] . ace-window)
         ("C-x w" . ace-swap-window)))

;; all-the-icons
(use-package
  all-the-icons
  :config (unless (member "all-the-icons" (font-family-list))
            (all-the-icons-install-fonts t)))

(use-package
  all-the-icons-dired
  :after all-the-icons
  :hook (dired-mode . all-the-icons-dired-mode))

;; (use-package
;;   undo-tree
;;   :delight
;;   :custom (undo-tree-visualizer-timestamps t)
;;   (undo-tree-visualizer-diff t)
;;   :config (global-undo-tree-mode +1)
;;   :bind ("C-c C-/" . undo-tree-redo))

(use-package
  nyan-mode
  :hook (prog-mode text-mode))

(use-package
  whitespace
  :hook (before-save . whitespace-cleanup)
  :bind (("C-c w" . whitespace-mode)))

;; (use-package
;;   smart-tab
;;   :delight
;;   :hook ((prog-mode . smart-tab-mode)
;;          (text-mode . smart-tab-mode)))


(provide 'cc-better-defaults)

;;; cc-better-defaults.el ends here
