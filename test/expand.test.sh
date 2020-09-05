plugins=(wechat alfred iterm)
selecteds=(0 2)
selected_plugins=()
plugin_str
for idx in ${selecteds[@]}; do
  selected_plugins+=(${plugins[idx]})
  echo "${selected_plugins[@]}"
done
echo "plugins=("
printf "  %s\n" "${selected_plugins[@]}"
echo ")"