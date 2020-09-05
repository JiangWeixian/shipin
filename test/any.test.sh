options=("one" "two" "three")

if [[ "${options[@]}" =~ "one" ]]; then
  echo "has one"
fi