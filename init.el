(setq inhibit-startup-message t)
(tool-bar-mode -1)
(setq-default  use-dialog-box nil)
(setq frame-title-format "%b  [%I] %f  GNU/Emacs" )
(setq visible-bell t)
(setq  ring-bell-function 'ignore)
(electric-pair-mode t)
(require 'menu-bar)
(menu-bar-mode nil)
(require 'tool-bar)
(tool-bar-mode nil)
(require 'scroll-bar)
(scroll-bar-mode nil)
(setq mouse-yank-at-point t)
(setq kill-ring-max 200)
(setq kill-do-not-save-duplicates t);不向kill-ring中加入重复内容
(setq-default indent-tabs-mode nil)
(setq kill-whole-line t);在行首 C-k 时，同时删除末尾换行符
;;我写的一个函数,如果有选中区域,则kill选区,否则删除当前行
;;注意当前行并不代表整行,它只删除光标到行尾的内容,也就是默认情况下
;;C-k 所具有的功能
;; C-w kill-region 这个按键可以省下来，此改进版 包含了kill-region 功能
;; 你可以把C-w 绑定到其他命令上去
(defun joseph-kill-region-or-line(&optional arg)
  "this function is a wrapper of (kill-line).
        When called interactively with no active region, this function
       will call (kill-line) ,else kill the region."
  (interactive "P")
  (if mark-active
      (if (= (region-beginning) (region-end) ) (kill-line arg)
        (kill-region (region-beginning) (region-end)))
    (kill-line arg)))
(global-set-key (kbd "C-k") 'joseph-kill-region-or-line)
(delete-selection-mode 1) ;;当选中内容时，输入新内容则会替换掉,启用delete-selection-mode
;; 把缺省的 major mode 设置为 text-mode, 而不是几乎什么功能也 没有的 fundamental-mode.
(setq default-major-mode 'text-mode)
;;; 关于没有选中区域,则默认为选中整行的advice
;;;;默认情况下M-w复制一个区域，但是如果没有区域被选中，则复制当前行
(defadvice kill-ring-save (before slickcopy activate compile)
  "When called interactively with no active region, copy a single line instead."
  (interactive
   (if mark-active (list (region-beginning) (region-end))
     (message "已选中当前行!")
     (list (line-beginning-position)
           (line-beginning-position 2)))))
;;-------------------------------------------------------------------------

(require 'package)
(setq package-enable-at-startup nil)

(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))

(package-initialize)
;; bootstrap "use-package"
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(use-package try
	     :ensure t)
(use-package which-key
	     :ensure t
	     :config
	     (which-key-mode))



;;=======================================================================

(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda ()(org-bullets-mode 1))))

;;;===========================
;;buffers
;(setq ido-enable-flex-matching t)
;(setq ido-everywhere t)
;(ido-mode 1)

;;(defalias 'list-buffers 'ibuffer) ; make ibuffer default
(defalias 'list-buffers 'ibuffer-other-window) ; make ibuffer default

;; (use-package tabbar
;;   :ensure t
;;   :config (tabbar-mode 1)
;; )
;;===================================
;;windows
;;
;
;;key	what it does
;;C-x 2	split-window-below (vertically)
;;C-x 3	split-window-right (horizontally)
;;C-x 0	delete-window (this one)
;;C-x 1	delete-other-windows
;;C-x o	other-window (moves foxus to the next window;
(windmove-default-keybindings)
;;S-arrow -> <-
; add this to init.el
(use-package ace-window
  :ensure t
  :init
  (progn
    (global-set-key [remap other-window] 'ace-window)
    (custom-set-faces
     '(aw-leading-char-face
       ((t (:inherit ace-jump-face-foreground :height 3.0))))) 
    ))
;;
(winner-mode 1)
;;Which will allow you to use C-c left or right to move through past window configurations 
;;
					;=================================================
;;search swiper

(use-package counsel
  :ensure t
  )

(use-package swiper
  :ensure try
  :config
  (progn
    (ivy-mode 1)
    (setq ivy-use-virtual-buffers t)
    (global-set-key "\C-s" 'swiper)
    (global-set-key (kbd "C-c C-r") 'ivy-resume)
    (global-set-key (kbd "<f6>") 'ivy-resume)
    (global-set-key (kbd "M-x") 'counsel-M-x)
    (global-set-key (kbd "C-x C-f") 'counsel-find-file)
    (global-set-key (kbd "<f1> f") 'counsel-describe-function)
    (global-set-key (kbd "<f1> v") 'counsel-describe-variable)
    (global-set-key (kbd "<f1> l") 'counsel-load-library)
    (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
    (global-set-key (kbd "<f2> u") 'counsel-unicode-char)
    (global-set-key (kbd "C-c g") 'counsel-git)
    (global-set-key (kbd "C-c j") 'counsel-git-grep)
    (global-set-key (kbd "C-c k") 'counsel-ag)
    (global-set-key (kbd "C-x l") 'counsel-locate)
    (global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
    (define-key read-expression-map (kbd "C-r") 'counsel-expression-history)
    ))
;; using swiper so ido no longer needed
;;(setq ido-enable-flex-matching t)
;;(setq ido-everywhere t)
;;(ido-mode 1)
;;;===================================
(use-package avy
  :ensure t
  :bind ("M-s" . avy-goto-char))

;;You can check the avy home page for their recommended configuration which you get by configuring this way instead:

(use-package avy
:ensure t
:init (avy-setup-default)
:config (progn
;; Makes it easier to see the candidates
(setq avy-background t)
;; Shows both the candidates over the text
(setq avy-styles-alist '((avy-goto-char-2 . at-full))))
:bind (;; Search by 2 chars
("C-'" . avy-goto-char-2)
;; Search by first char of a word
("C-\"" . avy-goto-word-1)))
;(use-package avy
;:ensure t
;:bind (("H-a" . avy-goto-word-1)
;("M-g M-g" . avy-goto-line)
;("M-g g" . avy-goto-line)
;("H-A" . avy-goto-char))
;:config (setq avy-all-windows nil))

;;=====================================
;;;;complete with auto-complete
;; (use-package auto-complete
;;   :ensure t
;;   :init
;;   (progn
;;     (ac-config-default)
;;     (global-auto-complete-mode t)
;;     ))

;;;;=====================================
;;;themes
(use-package zenburn-theme
  :ensure t
  :config (load-theme 'zenburn t))
;;;==============================================
;; use org manage config

;;(org-babel-load-file (expand-file-name "~/.emacs.d/myinit.org"))

;; add this about yes y no n
(fset 'yes-or-no-p 'y-or-n-p)
(global-set-key (kbd "<f5>") 'revert-buffer)
;;===============================

;;;;===============================
;;for pyhton
(use-package python
  :ensure t
  :mode ("\\.py" . python-mode)
  :config
  (use-package elpy
    :ensure t
    :commands elpy-enable
    :config
    (setq elpy-rpc-python-command "python3"
	  elpy-modules (dolist (elem '(elpy-module-highlight-indentation
				       elpy-module-yasnippet))
			 (remove elem elpy-modules)))
    (elpy-use-ipython))
  (elpy-enable)
  (require 'smartparens-python)
  (add-hook 'python-mode-hook #'smartparens-strict-mode))
(use-package flycheck
  :ensure t
  :init
  (global-flycheck-mode -1))
;; (use-package epc
;;   :ensure t)
;; (use-package jedi
;;   :ensure t
;;   :init
;;   (add-hook 'python-mode-hook 'jedi:setup)
;;   (add-hook 'python-mode-hook 'jedi:ac-setup))

;;===============================
;;yasnippet
(use-package yasnippet
  :ensure t
  :init
    (yas-global-mode 1))
;;=================================
(defvar myPackages
  '(better-defaults
    ein ;; add the ein package (Emacs ipython notebook)
    py-autopep8))
(setq ein:use-auto-complete t)
;; Or, to enable "superpack" (a little bit hacky improvements):
;; (setq ein:use-auto-complete-superpack t)


;;;===========================
;;pairs
(use-package smartparens
  :ensure t
  :commands (smartparens-mode
	     smartparens-strict-mode)
  :bind (:map smartparens-strict-mode-map
	      ("C-}" . sp-forward-slurp-sexp)
	      ("M-s" . sp-backward-unwrap-sexp)
	      ("C-c [" . sp-select-next-thing)
	      ("C-c ]" . sp-select-next-thing-exchange))
  :config
  (require 'smartparens-config))

(use-package smart-mode-line
  :ensure t
  :init
  (setq-default sml/vc-mode-show-backend t
	;;	sml/theme 'respectful
		sm/name-with 30)
  (sml/setup)
  :config
  (add-to-list 'sml/replacer-regexp-list '("^~/workspace/" ":WS:") t))
;;========================
(use-package company               
  :ensure t
  :defer t
  :init (global-company-mode -1)
  :config
  (progn
    ;; Use Company for completion
    (bind-key [remap completion-at-point] #'company-complete company-mode-map)

    (setq company-tooltip-align-annotations t
          ;; Easy navigation to candidates with M-<n>
          company-show-numbers t)
    (setq company-dabbrev-downcase nil))
  :diminish company-mode)


(use-package company-quickhelp          ; Documentation popups for Company
  :ensure t
  :defer t
  :init (add-hook 'global-company-mode-hook #'company-quickhelp-mode))

(use-package company-go
  :ensure t
  :defer t
  :init
  (with-eval-after-load 'company
    (add-to-list 'company-backends 'company-go)))




;;=========================================
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" default)))
 '(package-selected-packages
   (quote
    (neotree haskell-mode smart-mode-line elpy smartparens ein zenburn-theme auto-complete counsel ace-window tabbar which-key try use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(aw-leading-char-face ((t (:inherit ace-jump-face-foreground :height 3.0)))))
(use-package ensime
  :ensure t
)
(put 'upcase-region 'disabled nil)
