;;; cc-packages.el

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

;;; Code:

(require 'package)
(setq package-archives '(("gnu"   . "https://elpa.zilongshanren.com/gnu/")
             ("melpa" . "https://elpa.zilongshanren.com/melpa/")
             ("org" . "https://elpa.zilongshanren.com/org/")))

(package-initialize)
(unless package-archive-contents (package-refresh-contents))

(provide 'cc-packages)

;;; cc-packages.el ends here
