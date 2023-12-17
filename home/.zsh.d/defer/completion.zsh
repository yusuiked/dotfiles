# Interactive refinement of completion candidates
# https://qiita.com/ToruIwashita/items/5cfa382e9ae2bd0502be
# 補完候補をメニューから選択する
#   select=2: 補完候補を一覧から選択する。補完候補が 2 つ以上なければすぐに補完する。
zstyle ':completion:*' menu select interactive
zstyle ':completion:*:default' menu select=2
setopt menu_complete

# 補完の詳細表示
zstyle ':completion:*' verbose yes

# 大文字小文字を区別せず補完する
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# 補完方法の設定
# 指定した順に実行する
## _approximate: 近似補完 (間違いを修正した補完)
## _complete: 通常補完
## _correct: ミススペルを訂正した上で補完を行う
## _expand: グロブや変数の展開を行う。もともとあった展開と比べて、細かい制御が可能
## _history: 履歴から補完を行う。_history_complete_wordから使われる
## _ignored: 補完候補にださないと指定したものも補完候補とする
## _match: *などのグロブによってコマンドを補完できる
## _oldlist: 前回の補完結果を再利用
## _prefix: 単語途中の補完 (/dir1/dir3/ -> /dir1/dir2/dir3/ という感じで)
zstyle ':completion:*' completer _expand _complete _approximate _prefix

# 補完方法ごとにグループ化する
zstyle ':completion:*' format '%B%F{63}%d%f%b'
zstyle ':completion:*' group-name ''

