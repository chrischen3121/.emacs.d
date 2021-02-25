;;; cc-core.el

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
(require 'cl-lib)
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://mirrors.cloud.tencent.com/elpa/melpa/"))
(add-to-list 'package-archives '("melpa-stable" . "http://mirrors.cloud.tencent.com/elpa/melpa-stable/"))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

;; futher reduce load time
(eval-when-compile
  (require 'use-package))
;; (require 'diminish)
;; (require 'bind-key)

;; globally ensure package installation
(require 'use-package-ensure)
(setq use-package-always-ensure t)

(use-package diminish
  :defer t)

;; keep package updated
(use-package auto-package-update
  :config
  (setq auto-package-update-delete-old-versions t)
  (setq auto-package-update-hide-results t)
  (auto-package-update-maybe))

;; (use-package which-key)
				 
(provide 'cc-core)

;;; cc-core.el ends here
