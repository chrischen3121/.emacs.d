;;; cc-locale.el

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

;; Fonts
(prefer-coding-system 'utf-8)
;; (set-frame-font "Source Code Pro-11" nil t)
;; (set-fontset-font t 'han "WenQuanYi Micro Hei-11")

(use-package
  cnfonts
  :init (cnfonts-mode 1)
  :bind (:map cnfonts-mode-map
              ("C--" . cnfonts-decrease-fontsize)
              ("C-=" . cnfonts-increase-fontsize)))
;; Use 'M-x cnfonts-edit-profile' to setup profile

(provide 'cc-locale)

;;; cc-locale.el ends here
