
;; Frame settings
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(ido-mode 1)
(ido-everywhere 1)
(setq inhibit-startup-screen t)
(global-display-line-numbers-mode 1)
(setq make-backup-files nil)

;; Font settings
(use-package emacs
             :init
             (set-face-attribute 'default nil 
                                 :font "PragmataPro Liga" 
                                 :height 120
                                 )
             )

(add-to-list 'load-path "~/dotfiles/emacs/pragmatapro-full.el")
(load "~/dotfiles/emacs/pragmatapro-full.el")
(global-prettify-symbols-mode 1)
(add-hook 'prog-mode-hook #'prettify-hook)
(add-hook 'text-mode-hook #'prettify-hook)

(require 'package)
(add-to-list 'package-archives
          '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Orgfiles
(setq org-agenda-files (directory-files-recursively "~/orgfiles/" "\\.org$"))
(global-set-key (kbd "C-c a") #'org-agenda)

;; Evil Mode
(unless (package-installed-p 'evil)
    (package-install 'evil))
(require 'evil)
(evil-mode 1)

;; Theme
(unless (package-installed-p 'kanagawa-themes)
  (package-install 'kanagawa-themes))

;; --- Theme ---
(use-package kanagawa-themes
  :init
  (setq kanagawa-themes-org-height nil)   
  :config
  (load-theme 'kanagawa-dragon t))

(custom-set-variables
 '(package-selected-packages nil))

;; Remap
;; --- Custom Evil keybindings ---
(with-eval-after-load 'evil

  ;; --- Leader key actions ---
  (evil-define-key 'normal 'global (kbd "SPC x") #'dired)

  ;; --- Move selected lines up/down ---
  (defun my/move-region (start end n)
    "Move the selected region up or down by N lines."
    (let ((text (delete-and-extract-region start end)))
      (forward-line n)
      (let ((new-start (point)))
        (insert text)
        (set-mark new-start)
        (goto-char (+ new-start (length text)))
        (setq deactivate-mark nil))))

  (defun my/move-region-up (start end)
    (interactive "r")
    (my/move-region start end -1))

  (defun my/move-region-down (start end)
    (interactive "r")
    (my/move-region start end 1))

  (evil-define-key 'visual 'global
    (kbd "J") #'my/move-region-down
    (kbd "K") #'my/move-region-up)

  ;; --- Scroll and recenter ---
  (evil-define-key 'normal 'global
    (kbd "C-d") (lambda () (interactive) (evil-scroll-down nil) (recenter))
    (kbd "C-u") (lambda () (interactive) (evil-scroll-up nil) (recenter)))

  ;; --- Search next/prev and center ---
  (evil-define-key 'normal 'global
    (kbd "n") (lambda () (interactive) (evil-search-next) (recenter))
    (kbd "N") (lambda () (interactive) (evil-search-previous) (recenter)))

  ;; --- Paste without overwriting register ---
  (evil-define-key 'visual 'global (kbd "SPC p")
    (lambda ()
      (interactive)
      (let ((text (buffer-substring (region-beginning) (region-end))))
        (delete-region (region-beginning) (region-end))
        (evil-paste-after 1)
        (insert text))))

  ;; --- Yank to system clipboard ---
  (evil-define-key 'normal 'global (kbd "SPC y") "\"+y")
  (evil-define-key 'normal 'global (kbd "SPC Y") "\"+Y")
  (evil-define-key 'visual 'global (kbd "SPC y") "\"+y")

  ;; --- Open tmux sessionizer ---
  (evil-define-key 'normal 'global
    (kbd "C-f") (lambda () (interactive)
                  (shell-command "tmux new tmux-sessionizer")))

  ;; --- Escape from insert mode using C-c ---
  (define-key evil-insert-state-map (kbd "C-c") #'evil-normal-state)

  ;; --- Disable arrow keys ---
  (dolist (key '("<up>" "<down>" "<left>" "<right>"))
    (global-set-key (kbd key) #'ignore))

  ;; --- Disable mouse input (optional) ---
  (dolist (ev '(mouse-1 mouse-2 mouse-3 mouse-4 mouse-5
                 wheel-up wheel-down wheel-left wheel-right))
    (global-unset-key (vector ev))))

(setq org-preview-latex-default-process 'dvisvgm)

(setq org-latex-compiler "xelatex")
                                 
