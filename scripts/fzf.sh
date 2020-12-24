# required
#   - fzf, ag
#   - git
#   - zsh plugin: copyfile

# git
fbr() {
  local branches branch
  branches=$(git --no-pager branch -vv) &&
  branch=$(echo "$branches" | fzf +m) &&
  git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

fcs() {
  local commits commit
  commits=$(git log --color=always --pretty=oneline --abbrev-commit --reverse) &&
  commit=$(echo "$commits" | fzf --tac +s +m -e --ansi --reverse) &&
  echo -n $(echo "$commit" | sed "s/ .*//")
}
alias rebase='git rebase -i `fcs`'

# z
unalias z
z() {
  if [[ -z "$*" ]]; then
    cd "$(_z -l 2>&1 | fzf +s --tac | sed 's/^[0-9,.]* *//')"
  else
    _last_z_args="$@"
    _z "$@"
  fi
}

zz() {
  cd "$(_z -l 2>&1 | sed 's/^[0-9,.]* *//' | fzf -q "$_last_z_args")"
}

# fh - repeat history
fh() {
  print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed -E 's/ *[0-9]*\*? *//' | sed -E 's/\\/\\\\/g')
}

# copyfile
alias filter="ag -g '' --ignore-dir node_modules"
# fe - open file
fe() {
  IFS=$'\n' files=($(filter | fzf-tmux --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}
fcode() {
  IFS=$'\n' files=($(filter | fzf-tmux --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && code ${files[@]}
}
# cc - copy files
cc() {
  IFS=$'\n' files=($(filter | fzf-tmux --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && copyfile ${files[@]}
}
# falias - find alias
# falias - find alias
falias() {
  IFS=$'\n' files=($(alias | fzf-tmux --query="$1" --multi --select-1 --exit-0))
}
