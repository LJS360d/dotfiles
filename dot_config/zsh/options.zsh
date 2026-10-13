# Shell options, history, env
export EDITOR=${EDITOR:-nvim}
export PAGER=less
(( $+commands[bat] )) && export MANPAGER="sh -c 'col -bx | bat -l man -p'"

HISTFILE=${XDG_STATE_HOME:-~/.local/state}/zsh_history
[[ -d ${HISTFILE:h} ]] || mkdir -p ${HISTFILE:h}
HISTSIZE=100000
SAVEHIST=100000
HISTORY_IGNORE="(&|[bf]g|c|clear|history|exit|q|pwd|* --help)"

setopt AUTO_CD AUTO_PUSHD PUSHD_IGNORE_DUPS PUSHD_SILENT
setopt EXTENDED_HISTORY HIST_IGNORE_ALL_DUPS HIST_IGNORE_SPACE HIST_REDUCE_BLANKS
setopt HIST_VERIFY INC_APPEND_HISTORY SHARE_HISTORY
setopt INTERACTIVE_COMMENTS EXTENDED_GLOB NO_BEEP
setopt COMPLETE_IN_WORD ALWAYS_TO_END

CORRECT_IGNORE="_*"

# plugin config (read when deferred plugins load)
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=40
# fzf
export FZF_DEFAULT_OPTS="--height=40% --layout=reverse --border --info=inline"
(( $+commands[fd] )) && export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath 2>/dev/null || ls -1 $realpath'
