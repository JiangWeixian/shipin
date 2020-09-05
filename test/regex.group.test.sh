clitools=(npm-trash npm-gh-quick-command npm-tldr brew-unrar brew-grex)

for tool in "${clitools[@]}"; do
  if [[ $tool =~ npm-* ]]; then
    echo "npm"
  fi
  if [[ $tool =~ brew-* ]]; then
    echo "brew"
  fi
done

for tool in "${clitools[@]}"; do
  if [[ $tool =~ (npm|brew)-([a-z-]+) ]]; then
    case "${BASH_REMATCH[1]}" in
      "npm")
        echo "npm"
        ;;
      "brew")
        echo "brew"
        ;;
    esac
  fi
done

