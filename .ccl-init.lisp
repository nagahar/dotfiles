(setf ccl:*default-external-format*            (ccl:make-external-format :character-encoding :utf-8				      :line-termination :unix)	         ccl:*default-file-character-encoding* :utf-8		 ccl:*default-socket-character-encoding* :utf-8);;; The following lines added by ql:add-to-init-file:#-quicklisp(let ((quicklisp-init (merge-pathnames "~/Dropbox/Documents/sandbox/lisp/lispbox-0.7/quicklisp/setup.lisp"                                       (user-homedir-pathname))))                                         (when (probe-file quicklisp-init)                                             (load quicklisp-init)))
;;; The following lines added by ql:add-to-init-file:
#-quicklisp
(let ((quicklisp-init (merge-pathnames ".quicklisp/setup.lisp" (user-homedir-pathname))))
  (when (probe-file quicklisp-init)
    (load quicklisp-init)))
(ql:quickload :split-sequence)
(defun get-args ()
  (split-sequence:split-sequence #\Space (car ccl:*unprocessed-command-line-arguments*)))

;;; The following lines added by ql:add-to-init-file:
#-quicklisp
(let ((quicklisp-init (merge-pathnames ".quicklisp/setup.lisp" (user-homedir-pathname))))
  (when (probe-file quicklisp-init)
    (load quicklisp-init)))

