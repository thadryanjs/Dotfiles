;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; (setq doom-theme 'doom-one)
;; `load-theme' function. This is the default:
;;(setq doom-theme 'doom-feather-dark)
(setq doom-theme 'doom-tomorrow-night)


;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; This is how you can get rid of autosaves
;; (setq auto-save-default nil)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-agenda-files '(
;;    "~/Vaults/Knowledge/refile.org"
    "~/Vaults/Knowledge/to-be-read.org"
    "~/Vaults/Knowledge/Knowledge.org"
    "~/Vaults/Knowledge/Areas/Tech/Orgmode/Orgmode.org"
    "~/Vaults/Knowledge/Areas/Tech/Vim/Vim.org"
    "~/Vaults/Knowledge/Areas/Tech/R/R.org"
    "~/Vaults/Knowledge/Areas/Tech/Tmux/Tmux.org"
    "~/Vaults/Knowledge/Areas/Tech/Linux/Linux.org"
    "~/Vaults/Home/to-be-read.org"
))

;; Recursively add all .org files from these dirs
(setq org-agenda-files
      (append org-agenda-files
              (directory-files-recursively "~/Vaults/Projects/Work" "\\.org$")
              (directory-files-recursively "~/Vaults/Home/Projects" "\\.org$")))

(setq org-default-notes-file "~/Vaults/Knowledge/Knowledge.org")

(setq my/org-agenda-files-no-home-tbr
      (seq-remove (lambda (file)
                     (string= (expand-file-name file)
                              (expand-file-name "~/Vaults/Home/to-be-read.org")))
                  org-agenda-files))

(setq org-agenda-prefix-format
      '((agenda . " %-20c %?-12t ")
        (todo   . " %-20c ")
        (tags   . " %-20c ")))

(after! org (setq org-capture-templates
      '(("t" "TODO with schedule" entry (file+headline "~/Vaults/Knowledge/Knowledge.org" "Queue")
         "** TODO [#B] %?\n SCHEDULED: %t\n")
        ("c" "TODO with schedule (ILP)" entry (file+headline "~/Vaults/Projects/Work/TheoryProject/ILP/ILP.org" "Queue")
         "** TODO [#B] %?\n SCHEDULED: %t\n")
        ("a" "TODO (no date)" entry (file+headline "~/Vaults/Knowledge/Knowledge.org" "Queue")
         "** TODO [#B] %?\n")
        ("b" "Back Burner TODO" entry (file+headline "~/Vaults/Knowledge/Knowledge.org" "Queue")
         "** TODO [#B] %? :BACK_BURNER:\n"))))

(after! org
  (setq org-todo-keywords
        '((sequence "BLOCKED(b)" "TODO(t)" "SECONDARY(s)" "PRIMARY(p)" "|" "DONE(d)" "CANCELLED(c)"))))

(setq org-agenda-custom-commands
      '(("w" "Combined view"
         ((alltodo ""
           ((org-agenda-overriding-header "Working Memory")
            (org-agenda-files '("~/Vaults/Knowledge/Knowledge.org"))))
          (tags-todo "/BLOCKED"
           ((org-agenda-overriding-header "Blocked")
            (org-agenda-files my/org-agenda-files-no-home-tbr)))
          (tags-todo "/SECONDARY"
           ((org-agenda-overriding-header "Secondary")
            (org-agenda-files my/org-agenda-files-no-home-tbr)))
          (tags-todo "/PRIMARY"
           ((org-agenda-overriding-header "Primary")
            (org-agenda-files my/org-agenda-files-no-home-tbr)))
          (agenda ""
           ((org-agenda-overriding-header "The week")
            (org-agenda-files my/org-agenda-files-no-home-tbr)
            (org-agenda-span 'week)
            (org-agenda-start-on-weekday 1)
            (org-agenda-start-day "+0d")
            (org-agenda-remove-tags nil)
            ;; Kill "days ahead" deadline noise in weekly view.
            (org-deadline-warning-days 0)
            (org-agenda-skip-deadline-if-done t)
            (org-agenda-skip-scheduled-if-done t)))))

        ("n" "Combined view (6m upcoming)"
         ((alltodo ""
           ((org-agenda-overriding-header "Working Memory")
            (org-agenda-files '("~/Vaults/Knowledge/Knowledge.org"))))
          (tags-todo "/BLOCKED"
           ((org-agenda-overriding-header "Blocked")
            (org-agenda-files my/org-agenda-files-no-home-tbr)))
          (tags-todo "/SECONDARY"
           ((org-agenda-overriding-header "Secondary")
            (org-agenda-files my/org-agenda-files-no-home-tbr)))
          (tags-todo "/PRIMARY"
           ((org-agenda-overriding-header "Primary")
            (org-agenda-files my/org-agenda-files-no-home-tbr)))
          (agenda ""
           ((org-agenda-overriding-header "Upcoming")
            (org-agenda-files my/org-agenda-files-no-home-tbr)
            (org-agenda-span 182)
            ;; Start after current week (next week start).
            (org-agenda-start-day "+1w")
            (org-agenda-start-on-weekday 1)
            (org-agenda-remove-tags nil)
            ;; Six-month horizon + warnings visible here.
            (org-deadline-warning-days 182)
            (org-agenda-skip-deadline-if-done t)
            (org-agenda-skip-scheduled-if-done t)))
          (agenda ""
           ((org-agenda-overriding-header "The week")
            (org-agenda-files my/org-agenda-files-no-home-tbr)
            (org-agenda-span 'week)
            (org-agenda-start-on-weekday 1)
            (org-agenda-start-day "+0d")
            (org-agenda-remove-tags nil)
            ;; Kill "days ahead" deadline noise in weekly view.
            (org-deadline-warning-days 0)
            (org-agenda-skip-deadline-if-done t)
            (org-agenda-skip-scheduled-if-done t)))))

        ("u" "Unscheduled by project"
         ((tags-todo "TODO=\"TODO\"|TODO=\"SECONDARY\"|TODO=\"PRIMARY\""
           ((org-agenda-overriding-header "Unscheduled tasks by project")
            (org-agenda-files my/org-agenda-files-no-home-tbr)
            (org-agenda-todo-ignore-scheduled 'all)
            (org-agenda-sorting-strategy '(category-up priority-down todo-state-down alpha-up))
            (org-agenda-tag-filter-preset
             '("-articles" "-movies" "-music" "-recipes" "-books"
               "-books_related" "-podcasts" "-television" "-vonnegut"
               "-videos" "-saved" "-food"))))))

        ("d" "Daily plan"
         ((alltodo ""
           ((org-agenda-overriding-header "Working Memory")
            (org-agenda-files '("~/Vaults/Knowledge/Knowledge.org"))))
          (tags-todo "/BLOCKED"
           ((org-agenda-overriding-header "Blocked")
            (org-agenda-files my/org-agenda-files-no-home-tbr)))
          (tags-todo "/SECONDARY"
           ((org-agenda-overriding-header "Secondary")
            (org-agenda-files my/org-agenda-files-no-home-tbr)))
          (tags-todo "/PRIMARY"
           ((org-agenda-overriding-header "Primary")
            (org-agenda-files my/org-agenda-files-no-home-tbr)))
          (agenda ""
           ((org-agenda-overriding-header "The day")
            (org-agenda-files my/org-agenda-files-no-home-tbr)
            (org-agenda-span 'day)
            (org-agenda-start-day "+0d")
            (org-agenda-start-on-weekday nil)
            (org-deadline-warning-days 0)
            (org-agenda-remove-tags nil)
            (org-agenda-prefix-format " ")
            (org-agenda-sorting-strategy '(todo-state-down))
            (org-agenda-view-columns-initially t)
            (org-overriding-columns-format "%50ITEM(Name) %10TODO(Status) %1PRIORITY(P) %22CATEGORY(Project) %TAGS")
            (org-agenda-skip-function
             '(org-agenda-skip-entry-if 'todo '("BLOCKED")))))))

        ("c" "Completed Tasks"
         ((tags "TODO=\"DONE\""
           ((org-agenda-overriding-header "Completed Tasks")
            (org-agenda-files my/org-agenda-files-no-home-tbr)
            (org-agenda-sorting-strategy '(time-down))))))

        ("h" "Unscheduled TODOs (including home TBR)"
         ((tags-todo "TODO=\"TODO\"|TODO=\"SECONDARY\"|TODO=\"PRIMARY\""
           ((org-agenda-overriding-header "Unscheduled TODO tasks")
            (org-agenda-todo-ignore-scheduled 'all)))))

        ("i" "High-level overview"
         ((tags-todo "high_level"
           ((org-agenda-overriding-header "Goals")
            (org-agenda-files my/org-agenda-files-no-home-tbr)))
          (tags-todo "sprint"
           ((org-agenda-overriding-header "Sprint")
            (org-agenda-files my/org-agenda-files-no-home-tbr)))))))

(defun my/org-agenda-daily-columns ()
  "Force columns in daily agenda view."
  (when (equal org-keys "d")
    (let ((org-agenda-prefix-format " ")
          (org-overriding-columns-format
           "%50ITEM(Name) %10TODO(Status) %1PRIORITY(P) %22CATEGORY(Project) %TAGS"))
      (org-agenda-columns))))

(add-hook 'org-agenda-finalize-hook #'my/org-agenda-daily-columns)

(after! org
  ;; Let theme control column faces; remove hard gray backgrounds.
  (set-face-attribute 'org-column nil :background 'unspecified)
  (set-face-attribute 'org-column-title nil :background 'unspecified))

;; (setq org-agenda-window-setup 'current-window)
;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `with-eval-after-load' block, otherwise Doom's defaults may override your
;; settings. E.g.
;;
;;   (with-eval-after-load 'PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look them up).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.


