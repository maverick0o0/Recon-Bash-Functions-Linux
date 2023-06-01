print_color() {
  local color="$1"
  local text="$2"
  echo -e "\e[${color}m${text}\e[0m"
}