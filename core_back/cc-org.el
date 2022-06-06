;;; cc-org.el

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

(defun cc-org/set-company-backends ()
  (set (make-local-variable 'company-backends)
       '(company-ispell company-capf company-dabbrev)))

(defun cc-org/disable-indent-mode ()
  (electric-indent-local-mode -1))

;; anki
(use-package
  anki-editor
  :after org
  :config (which-key-add-keymap-based-replacements org-mode-map "C-c k" "org-anki")
  :bind (:map org-mode-map
              ("C-c k p" . anki-editor-push-notes)
              ("C-c k i" . anki-editor-insert-note)
              ("C-c k c" . anki-editor-cloze-dwim))
  :custom (anki-editor-create-decks t))

;; full-text search
                                        ;TODO:
;; (use-package
;;   deft
;;   :after org
;;   :bind (:map org-mode-map
;;               ("C-c n d" . deft))
;;   :custom (deft-recursive t)
;;   (deft-use-filter-string-for-filename t)
;;   (deft-default-extension "org")
;;   (deft-directory cc-org-roam/org-roam-directory))


;; download screenshot
(use-package
  org-download
  :after org
  :config (which-key-add-keymap-based-replacements org-mode-map "C-c d" "org-download")
  :custom (org-download-image-dir "~/Pictures/org")
  :bind (:map org-mode-map
              ("C-c d s" . org-download-screenshot)
              ("C-c d y" . org-download-yank)))

(use-package
  graphviz-dot-mode
  :defer t)

(use-package
  plantuml-mode
  ;; TODO: 
  :mode "\\.puml\\'"
  :interpreter "plantuml"
  :ensure-system-package plantuml
  :custom (plantuml-executable-path "plantuml")
  (plantuml-default-exec-mode 'executable))

(use-package
  htmlize
  :defer t)

(use-package
  org-bullets
  :hook (org-mode . org-bullets-mode))

(use-package
  org-alert
  :defer t
  :custom (alert-default-style 'libnotify))

(require 'ox-md)
(use-package
  org
  :hook (org-mode . flyspell-mode)
  (org-mode . smartparens-mode)
  (org-mode . cc-org/set-company-backends)
  (org-mode . cc-org/disable-indent-mode)
  :init (require 'org-tempo)
  :custom (org-format-latex-options (plist-put org-format-latex-options
                                               :scale 5.0))
  (indent-tabs-mode nil)
  (tab-width 8)
  :bind (("C-c a" . org-agenda)
         ("C-c l" . org-store-link)
         ("C-c b" . org-switchb)
         :map org-mode-map ("C-c i" . org-id-get-create))
  :config (org-babel-do-load-languages 'org-babel-load-languages '((dot . t)
                                                                   (plantuml . t)))
  (org-indent-mode -1))

(use-package
  org-tree-slide
  :custom (org-tree-slide-skip-outline-level 3)
  (org-tree-slide-skip-done nil)
  :bind (:map org-mode-map
              ("<f8>" . org-tree-slide-mode)
              ("S-<f8>" . org-tree-slide-skip-done-toggle)
              :map org-tree-slide-mode-map
              ("<f9>" . org-tree-slide-move-previous-tree)
              ("<f10>" . org-tree-slide-move-next-tree)
              ("<f11>" . org-tree-slide-content)))


(provide 'cc-org)

;;; cc-org.el ends here
