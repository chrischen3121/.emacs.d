;;; cc-dev-files.el --- modes for dev files

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
  json-mode
  :defer t)

(use-package
  yaml-mode
  :defer t)

(use-package
  markdown-mode
  :defer t)

(use-package
  dockerfile-mode
  :defer t)

(use-package
  protobuf-mode
  :defer t)

(use-package
  graphviz-dot-mode
  :defer t
  :ensure-system-package dot)

(use-package
  plantuml-mode
  :mode "\\.puml\\'"
  :interpreter "plantuml"
  :ensure-system-package plantuml
  :custom (plantuml-default-exec-mode 'executable))

(provide 'cc-dev-files)

;;; cc-dev-files.el ends here
