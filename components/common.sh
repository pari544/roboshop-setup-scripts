checkRootUser() {
  USER_ID=$(id -u)
  if [ "$USER_ID" -ne 0 ]; then
    echo "You are supposed to be running this script as sudo"
  else
    echo OK
  fi
}