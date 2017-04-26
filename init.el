;; パッケージ取得先
(require 'package)
(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
        ("melpa" . "http://melpa.org/packages/")
        ("org" . "http://orgmode.org/elpa/")))
;;(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
;;(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

;;; uncomment this line to disable loading of "default.el" at startup
;; (setq inhibit-default-init t)

(setq-default c-basic-offset 8     ;;基本インデント量4
              tab-width 8          ;;タブ幅4
              indent-tabs-mode nil)  ;;インデントをタブでするかスペースでするか
;;
;; Auto Complete
;;
(require 'auto-complete-config)
(ac-config-default)
(add-to-list 'ac-modes 'text-mode)         ;; text-modeでも自動的に有効にする
(add-to-list 'ac-modes 'fundamental-mode)  ;; fundamental-mode
(add-to-list 'ac-modes 'org-mode)
(add-to-list 'ac-modes 'yatex-mode)
(ac-set-trigger-key "TAB")
(setq ac-use-menu-map t)       ;; 補完メニュー表示時にC-n/C-pで補完候補選択
(setq ac-use-fuzzy t)          ;; 曖昧マッチ

;; 起動時のウィンドウサイズ、色などを設定
(if (boundp 'window-system)
    (setq default-frame-alist
          (append (list
                   '(foreground-color . "black")  ; 文字色
                   '(background-color . "white")  ; 背景色
                   '(border-color     . "white")  ; ボーダー色
                   '(mouse-color      . "black")  ; マウスカーソルの色
                   '(cursor-color     . "black")  ; カーソルの色
                   '(cursor-type      . box)      ; カーソルの形状
                   '(top . 60) ; ウィンドウの表示位置（Y座標）
                   '(left . 140) ; ウィンドウの表示位置（X座標）
                   '(width . 120) ; ウィンドウの幅（文字数）
                   '(height . 40) ; ウィンドウの高さ（文字数）
                   )
                  default-frame-alist)))
(setq initial-frame-alist default-frame-alist )

;; turn on font-lock mode
(when (fboundp 'global-font-lock-mode)
  (global-font-lock-mode t))

;; enable visual feedback on selections
;(setq transient-mark-mode t)

;; default to better frame titles
(setq frame-title-forma
      (concat  "%b - emacs@" (system-name)))

;; default to unified diffs
(setq diff-switches "-u")

;; always end a file with a newline
;(setq require-final-newline 'query)

(set-language-environment "Japanese")
;(set-terminal-coding-system 'euc-jp)
;(prefer-coding-system 'euc-jp-unix)
;(set-keyboard-coding-system 'euc-jp)
(set-terminal-coding-system 'utf-8)
(prefer-coding-system 'utf-8-unix)
(set-keyboard-coding-system 'utf-8)

;grep-edit
;(require 'grep-edit)

;;; バッファの最後でnewlineで新規行を追加するのを禁止する
(setq next-line-add-newlines nil)

;;; 現在の関数名をモードラインに表示
(which-function-mode 1)

; 選択範囲に色を付ける
(setq transient-mark-mode t)
(set-face-foreground 'region "white")
(set-face-background 'region "SlateBlue2")

;; 文字の色を設定します。
(add-to-list 'default-frame-alist '(foreground-color . "black"))

; 背景色
(add-to-list 'default-frame-alist '(background-color . "white"))

;; 全角スペースやタブ文字、行末のスペースを色を付けて表示する
(global-font-lock-mode t)
(defface my-face-b-1 '((t (:background "gray"))) nil)
(defface my-face-b-2 '((t (:background "gray26"))) nil)
(defface my-face-u-1 '((t (:foreground "SteelBlue" :underline t))) nil)
(defvar my-face-b-1 'my-face-b-1)
(defvar my-face-b-2 'my-face-b-2)
(defvar my-face-u-1 'my-face-u-1)
(defadvice font-lock-mode (before my-font-lock-mode ())
  (font-lock-add-keywords
   major-mode
   '(("¥t" 0 my-face-b-2 append)
     ("　" 0 my-face-b-1 append)
     ("[ ¥t]+$" 0 my-face-u-1 append)
     )))
(ad-enable-advice 'font-lock-mode 'before 'my-font-lock-mode)
(ad-activate 'font-lock-mode)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(c-basic-offset (quote set-from-style) t)
 '(c-syntactic-indentation t)
 '(c-syntactic-indentation-in-macros t)
 '(c-tab-always-indent t)
 '(inhibit-startup-screen t)
 '(tab-width 8))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; 基本オフセット量の設定
(setq c-basic-offset 4)

;; goto-lineで指定した行番号にジャンプ！
(global-set-key "\C-x\C-g" 'goto-line)

;; Undo
(global-set-key "\C-z" 'undo)

(put 'set-goal-column 'disabled nil)

;; ファイル名の補間で大文字小文字を区別しない
(setq completion-ignore-case t)

;; バッファ自動再読み込み
(global-auto-revert-mode 1)

;; 同名ファイルのバッファ名の識別文字列を変更する
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

;; 現在行のハイライト
;;(defface hlline-face
;;  '((((class color)
;;      (background dark))
;;     (:background "dark slate gray"))
;;    (((class color)
;;      (background light))
;;     (:background  "#98FB98"))
;;   (t
;;     ()))
;;  "*Face used by hl-line.")
;;(setq hl-line-face 'hlline-face)
;;(global-hl-line-mode)

;; カーソルの点滅をやめる
(blink-cursor-mode 0)

;; "yes or no" の選択を "y or n" にする
(fset 'yes-or-no-p 'y-or-n-p)

;; 対応する括弧を光らせる
(show-paren-mode 1)

;; ウィンドウ内に収まらないときだけ、カッコ内も光らせる
(setq show-paren-style 'mixed)
(set-face-background 'show-paren-match-face "grey")
(set-face-foreground 'show-paren-match-face "black")

;; 列数を表示する
(column-number-mode t)

;; ウィンドウの上部に現在の関数名を表示
(which-function-mode 1)

;;; ツールバーを消す
(tool-bar-mode 0)
