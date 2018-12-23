(setq mac-command-modifier 'super)
(setq mac-option-modifier 'meta)
(setq auto-save-visited-mode t)

(add-hook 'text-mode-hook 'turn-on-visual-line-mode)
(add-hook 'org-mode-hook 
          (lambda ()
            (variable-pitch-mode 1)
            (hl-line-mode -1)
            (setq line-spacing 0.5)))
