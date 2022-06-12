;;; cc-org.el --- Configuration for org-mode

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

;;; Useful Commands:
;;
;; C-c C-l -- Insert a link
;; C-c C-o -- Open link at point
;; C-x n s, C-x n w -- Narrow buffer
;; C-c / -- Search in an outline tree and fold others as much as possible
;; M-S-RET -- Add TODO outlines or add items with a checkbox
;; C-c -    Cycle bullets (-, +, *, ...)
;; C-c i -- Create IDs
;;
;;; Code:


(defun cc-org/set-company-backends ()
  (setq-local company-backends '((company-yasnippet company-dabbrev
                                                    company-ispell
                                                    :separate))))

(defun cc-org/add-keymap-based-replacements ()
  (which-key-add-keymap-based-replacements org-mode-map "C-c f" "org-footnote")
  (which-key-add-keymap-based-replacements org-mode-map "C-c \"" "org-plot")
  (which-key-add-keymap-based-replacements org-mode-map "C-c C-v" "org-babel")
  (which-key-add-keymap-based-replacements org-mode-map "C-c C-x" "org-prefix")
  (which-key-add-keymap-based-replacements org-mode-map "C-c a" "org-anki"))

(use-package
  org-tempo
  :ensure nil
  :config (add-to-list 'org-structure-template-alist '("py" . "src python"))
  (add-to-list 'org-structure-template-alist '("cpp" . "src cpp"))
  (add-to-list 'org-structure-template-alist '("clang" . "src c"))
  (add-to-list 'org-structure-template-alist '("b" . "src bash"))
  (add-to-list 'org-structure-template-alist '("elisp" . "src emacs-lisp"))
  (add-to-list 'org-tempo-keywords-alist '("t" . "TODO")))

(use-package
  org
  :init (which-key-add-key-based-replacements "C-c o" "org")
  :hook (org-mode . flyspell-mode)
  (org-mode . cc-org/set-company-backends)
  (org-mode . cc-org/add-keymap-based-replacements)
  :bind (("C-c o a" . org-agenda)
         ("C-c o l" . org-store-link)
         ("C-c o c" . org-capture)
         ("C-c o b" . org-switchb)
         :map org-mode-map ("C-c i" . org-id-get-create)
         ("C-c f n" . org-footnote-new)
         ("C-c f a" . org-footnote-action)
         ("C-c s" . org-sort))
  ;; :config ((org-babel-do-load-languages 'org-babel-load-languages '((dot . t)
  ;;                                                                   (plantuml .
  ;;                                                                             t))))
  )


;; (defun cc-org/disable-indent-mode ()
;;   (electric-indent-local-mode -1))

;; (use-package
;;   org
;;   :init (which-key-add-key-based-replacements "C-c o" "org")
;;   :hook (org-mode . flyspell-mode)
;;   (org-mode . cc-org/set-company-backends)
;;   ;; (org-mode . cc-org/disable-indent-mode)
;;   ;; :init (require 'org-tempo)
;;   ;; :custom
;;   ;; (org-format-latex-options (plist-put org-format-latex-options :scale 5.0))
;;   ;; (indent-tabs-mode nil)
;;   :bind (("C-c o a" . org-agenda)
;;          ("C-c o l" . org-store-link)
;;          ("C-c o b" . org-switchb)
;;          :map org-mode-map ("C-c i" . org-id-get-create))
;;   :config (org-babel-do-load-languages 'org-babel-load-languages '((dot . t)
;;                                                                    (plantuml .
;;                                                                              t)))
;;   (org-indent-mode -1))
;; ;; (defun cc-org/disable-indent-mode ()
;; ;;   (electric-indent-local-mode -1))

;;(require 'org-tempo)

;; anki
(use-package
  anki-editor
  :after org
  :ensure-system-package anki
  :bind (:map org-mode-map
              ("C-c a p" . anki-editor-push-notes)
              ("C-c a i" . anki-editor-insert-note)
              ("C-c a c" . anki-editor-cloze-dwim))
  :custom (anki-editor-create-decks t))

;; ;; full-text search
;;                                         ;TODO:
;; ;; (use-package
;; ;;   deft
;; ;;   :after org
;; ;;   :bind (:map org-mode-map
;; ;;               ("C-c n d" . deft))
;; ;;   :custom (deft-recursive t)
;; ;;   (deft-use-filter-string-for-filename t)
;; ;;   (deft-default-extension "org")
;; ;;   (deft-directory cc-org-roam/org-roam-directory))

(use-package
  org-superstar
  :custom (org-superstar-special-todo-items t)
  :hook (org-mode . org-superstar-mode))


;; Presentation Tool
(use-package
  org-tree-slide
  :custom (org-tree-slide-header nil)
  (org-tree-slide-cursor-init t)
  (org-tree-slide-skip-outline-level 2)
  (org-tree-slide-skip-done t)
  (org-tree-slide-skip-comments t)
  ;; :hook (org-mode . org-tree-slide-simple-profile)
  :bind (:map org-mode-map
              ("<f12>" . org-tree-slide-mode)
              :map org-tree-slide-mode-map
              ("<f9>" . org-tree-slide-move-previous-tree)
              ("<f10>" . org-tree-slide-move-next-tree)
              ("<f11>" . org-tree-slide-content)))


(provide 'cc-org)

;;; cc-org.el ends here
