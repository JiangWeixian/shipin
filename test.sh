ask() {
  read -r -n 1 -p "❯ $1 y/n: " "$1"
  echo
}
TITLE='install'
IS_INSTALL_GIT=y
ask TITLE IS_INSTALL_GIT
echo $TITLE