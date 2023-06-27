hook_test() {
  if [ $# -ne 2 ]; then
    echo "Usage: hook_test <domain> <hook-name>"
    echo "Example: hook_test example.com myhook.php"
    return 1
  fi

  domain="$1"
  hook_name="$2"

  echo "$hook_name" > list.tmp
  seq 1 1000 >> list.tmp
  echo "$hook_name" >> list.tmp

  ffuf -w list.tmp -u "$domain/FUZZ" -o ffuf-result.tmp > /dev/null

  statuses=$(cat ffuf-result.tmp | jq -r '.results[] | select(.input.FUZZ == "'"$hook_name"'") | .input.FUZZ , .status')

  echo -e "\033[0;32mResults:\033[0m"
  echo -e "\033[0;32m$statuses\033[0m"

  # Remove temporary files
  rm list.tmp ffuf-result.tmp
}
