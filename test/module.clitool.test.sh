#!/usr/bin/env bash
source ./ask.test.sh
source ./select.test.sh

IS_INSTALL_AWESOME_CLITOOLS=y
if [ $IS_INSTALL_AWESOME_CLITOOLS == y ]; then
  clear
  selecteds=()
  clitools=(npm-trash npm-gh-quick-command npm-tldr brew-unrar brew-grex)
  printf '%s Please check this files about \e]8;;https://github.com/JiangWeixian/shipin/blob/master/docs/clitools.md\e\\details of clitools\e]8;;\e\\\n' -
  echo "- Select clitool using 「up/down」 keys to browse, 「left/right」 keys to select and 「enter」 to confirm:"
  echo
  select_option "${clitools[@]}"
  for idx in "${selecteds[@]}"; do
    if [[ ${clitools[idx]} =~ (npm|brew)-([a-z-]+) ]]; then
      case "${BASH_REMATCH[1]}" in
        "npm")
          echo "installing ${clitools[idx]}"
          npm install "${BASH_REMATCH[2]}" -g
          ;;
        "brew")
          echo "installing ${clitools[idx]}"
          brew install "${BASH_REMATCH[2]}"
          ;;
      esac
    fi
  done
fi