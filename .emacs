(global-set-key "\C-c\C-c" 'comment-region)

(setq c-default-style "linux"
      c-basic-offset 2)
(defun apz-cc-style()
  (c-set-style "linux")
  (c-set-offset 'innamespace '0)
  (c-set-offset 'inextern-lang '0)
  (c-set-offset 'inline-open '0)
  (c-set-offset 'label '*)
  (c-set-offset 'case-label '*)
  (c-set-offset 'access-label '/)
  (setq c-basic-offset 2)
  (setq tab-width 2)
  (setq indent-tabs-mode nil)
)

(add-hook 'c++-mode-hook 'apz-cc-style)

(add-hook 'java-mode-hook (lambda ()
			    (setq c-basic-offset 2)))
(require 'package) ;; You might already have this line
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize) ;; You might already have this line
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#2d3743" "#ff4242" "#74af68" "#dbdb95" "#34cae2" "#008b8b" "#00ede1" "#e1e1e0"])
 '(c-basic-offset 2)
 '(custom-enabled-themes (quote (deeper-blue)))
 '(doc-view-continuous t)
 '(inhibit-startup-screen t)
 '(package-selected-packages
   (quote
    (bicycle gnu-elpa-keyring-update auctex auto-complete flycheck arduino-mode nim-mode yafolding rust-mode markdown-mode flylisp floobits))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Hack" :foundry "SRC" :slant normal :weight normal :height 90 :width normal)))))
(add-hook 'rust-mode-hook
  (lambda ()
    (setq indent-tabs-mode nil)
    (setq tab-width 2)
    (setq rust-indent-offset 2)))


(defun my-clear ()
  (interactive)
  (let ((comint-buffer-maximum-size 0))
    (comint-truncate-buffer)))

(defun my-shell-hook ()
  (local-set-key "\C-cl" 'my-clear))

(add-hook 'shell-mode-hook 'my-shell-hook)

(require 'yafolding)
(define-key yafolding-mode-map (kbd "<C-S-return>") nil)
(define-key yafolding-mode-map (kbd "<C-M-return>") nil)
(define-key yafolding-mode-map (kbd "<C-return>") nil)
(define-key yafolding-mode-map (kbd "C-c <C-M-return>") 'yafolding-toggle-all)
(define-key yafolding-mode-map (kbd "C-c <C-s-return>") 'yafolding-hide-parent-element)
(define-key yafolding-mode-map (kbd "C-c <C-return>") 'yafolding-toggle-element)


;; Erlang modifications
(defvar erlang-indent-level 2
  "*Indentation of Erlang calls/clauses within blocks.")
(defvar erlang-indent-guard 2
  "*Indentation of Erlang guards.")
(defvar erlang-argument-indent 2
  "*Indentation of the first argument in a function call.
  When nil, indent to the column after the `(' of the
  function.")

;; TODO: Make an arduino-cli based arduino mode
;;(setq auto-mode-alist (cons '("\\.\\(pde\\|ino\\)$" . arduino-mode) auto-mode-alist))
;;(autoload 'arduino-mode "arduino-mode" "Arduino editing mode." t)
(add-to-list 'auto-mode-alist '("\\.ino\\'" . c++-mode))
;; ROS launch files are XML
(add-to-list 'auto-mode-alist '("\\.launch$" . xml-mode))

(progn
  (require 'windmove)
  ;; use Shift+arrow_keys to move cursor around split panes
  (windmove-default-keybindings)
  ;; when cursor is on edge, move to the other side, as in a torus space
  (setq windmove-wrap-around t )
)

(desktop-save-mode 1)

(auto-complete-mode 1)

(ac-config-default)

(winner-mode 1)


;; TRAMP
(setq tramp-default-method "ssh")
(setq tramp-verbose 6) ;; This should be uncommented when 
(setq tramp-histfile-override "/dev/null") ;; This is to deal with glue being shit.

;; Annoying bell
(setq ring-bell-function 'ignore)
(setq visible-bell t)

;;acutex
;; to use pdfview with auctex
(setq TeX-view-program-list '(("Emacs" "\doc-view %o")))
(setq TeX-view-program-selection '((output-pdf "Emacs"))) ;; not sure if this works super well, TODO: Fix it.


;; to have the buffer refresh after compilation
(add-hook 'TeX-after-compilation-finished-functions
	  #'TeX-revert-document-buffer)

(setq ps-print-header nil
      ps-print-color-p nil
      ps-font-size 7
      ps-landscape-mode 1
      ps-number-of-columns 1)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

(require 'ansi-color)
(defun display-ansi-colors ()
  (interactive)
  (ansi-color-apply-on-region (point-min) (point-max)))
