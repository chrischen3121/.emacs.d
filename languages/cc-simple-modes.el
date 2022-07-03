;;; cc-simple-modes.el --- Configurations for all simple modes

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
  mhtml-mode
  :ensure nil
  :config (which-key-add-key-based-replacements "C-c C-c" "html-components"))

(use-package
  json-mode
  :ensure nil
  :custom (indent-tabs-mode nil)
  (tab-width 4)
  (standard-indent 4)
  :bind (:map json-mode-map
              ("C-c f" . json-pretty-print-buffer)))

(use-package
  git-modes
  :defer t)

(use-package
  clojure-mode
  :defer t)

(provide 'cc-simple-modes)

;;; cc-simple-modes.el ends here
