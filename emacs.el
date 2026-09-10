;;; Package --- Summary
;;; Commentary:
;;; It sets cmake-ide variables

;;; Code:
(defvar CMakeProject "Texject")
(require 'cmake-ide)

(setq cmake-ide-build-dir
      (concat cmake-ide-project-dir "build/Linux/x86-64/debug/"))
(setq cmake-ide-build-pool-dir cmake-ide-build-dir)
(make-directory cmake-ide-build-dir t)
(setq cmake-ide-cmake-args
      (list "-D_DEBUG=1 -DCMAKE_BUILD_TYPE=Debug"
	         "-DCMAKE_EXPORT_COMPILE_COMMANDS=1"
            "-DBUILD_TESTING=1"))
(defvar MakeThreadCount 1)
(defvar DebugTarget "testUnits")
(defvar TargetArguments "-s normal")
(message "Texject emacs project loaded.")
(provide 'Texject)
;;; emacs.el ends here
