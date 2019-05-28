;;; magit-spinner.el --- Shows a spinner during Magit async operations
;;; Version: 0.1
;;; Commentary:
;; See https://github.com/porras/magit-spinner
;;; Homepage: https://github.com/porras/magit-spinner
;; Package-Requires: ((emacs "25") (magit "2.90.0") (spinner "1.7.3"))
;;; Code:

(require 'magit)
(require 'spinner)

(defvar magit-spinner-mode--spinner (spinner-create 'progress-bar))

(defconst magit-spinner-mode--lighter
  '(:eval (spinner-start-print magit-spinner-mode--spinner)))

(define-minor-mode magit-spinner-mode
  "Shows a spinner during Magit async operations (pull, push, fetch, etc.)"
  :lighter magit-spinner-mode--lighter)

;;;###autoload
(defun magit-spinner-mode-enable (&rest args)
  (magit-spinner-mode 1))

;;;###autoload
(defun magit-spinner-mode-disable (&rest args)
  (magit-spinner-mode -1))

;;;###autoload
(advice-add 'magit-run-git-async :before 'magit-spinner-mode-enable)
;;;###autoload
(advice-add 'magit-process-finish :after 'magit-spinner-mode-disable)

(provide 'magit-spinner)

;;; magit-spinner.el ends here
