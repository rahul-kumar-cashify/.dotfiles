# ========= SDKMAN (MUST BE AT THE END — so we will re-source it at bottom) =========
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# ========= Load Zinit =========
source "$(brew --prefix)/opt/zinit/zinit.zsh"

# ========= Prompt =========
zinit light-mode for @sindresorhus/pure

# ========= CLI Enhancements =========
zinit light-mode for zdharma-continuum/fast-syntax-highlighting
zinit light-mode for zsh-users/zsh-autosuggestions
zinit light-mode for ael-code/zsh-colored-man-pages
zinit light-mode for jeffreytse/zsh-vi-mode

# ========= Completion System (Fast & Lazy) =========
zinit ice wait lucid atinit"autoload -Uz compinit; compinit -C"
zinit light zsh-users/zsh-completions
zinit snippet OMZP::git

zinit light-mode for @sharkdp/fd

zi ice lucid wait as'program' has'git' \
  atclone"cp git-open.1.md $ZI[MAN_DIR]/man1/git-open.1" atpull'%atclone'
zi light paulirish/git-open

zi snippet OMZL::clipboard.zsh

# ========= FZF Enhancements =========
zinit ice lucid wait
zinit snippet OMZP::fzf
zinit light-mode for Aloxaf/fzf-tab

# ========= FZF Config =========
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --ansi --layout=reverse --height=40% --bind ctrl-u:page-up,ctrl-d:page-down"

export FZF_CTRL_R_OPTS="
  --preview 'echo {}' --preview-window up:3:hidden:wrap
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)'
  --header 'Press CTRL-Y to copy command into clipboard'"

export FZF_CTRL_T_OPTS="
  --walker-skip .git,node_modules,target
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"

# ========= fzf-tab Styles =========
zstyle ':completion:*' fzf-tab '--preview=cat {}'
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'find ${(Q)realpath} -maxdepth 2 -print 2>/dev/null | ls -la --color=always'
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup

# ========= Navigation Tools =========
zinit light-mode for changyuheng/zsh-interactive-cd

# ========= History & Productivity =========
zinit light-mode for zdharma-continuum/history-search-multi-word

# ========= History Settings =========
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS
setopt SHARE_HISTORY

# ========= Tmux Auto-Attach =========
_tmux() {
  if command -v tmux &> /dev/null && [[ -n $PS1 ]] && [[ -z "$TMUX" ]] && [[ "$TERM" != screen* ]] && [[ "$TERM" != tmux* ]]; then
    exec tmux attach || tmux new
  fi
}
bindkey -s '^b' '_tmux\n'

# ========= Optional Custom Key =========
bindkey -s '^f' './fzf.sh\n'  # Make sure fzf.sh exists or change this to a real command

# ========= Editor Setup =========
if command -v nvim &> /dev/null; then
  export EDITOR=nvim
  export VISUAL=nvim
  alias v='nvim'
fi

# ========= Pager Colors =========
export LESS="-FXR"
export LESS_TERMCAP_mb=$'\e[35m' # magenta
export LESS_TERMCAP_md=$'\e[33m' # yellow
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[34m' # blue
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[4m'  # underline

# ========= Terminal Settings =========
export TERM=xterm-256color
export ZSH_TMUX_TERM="screen-256color"

# ========= Ensure SDKMAN is last =========
# [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

