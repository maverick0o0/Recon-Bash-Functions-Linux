find_subdomains_by_tools() {
  welcome
  # Check if the script is invoked without arguments
  if [[ -z "$1" ]]; then
    print_color 36 "Usage: filename <domain> [config-file]"
    print_color 36 "Discover subdomains using tools.(amass , subfinder)."
    print_color 36 "Arguments:"
    print_color 36 "  <domain>       Domain name to discover subdomains for."
    print_color 36 "  [config-file]  Optional. Path to the amass configuration file. If not provided, the default file will be used."
    return 0
  fi

  # Get the domain from the user
  local domain="$1"
  # Use user-provided config or default config
  local config="${2:-$HOME/.amass-config.ini}"

  # Run amass in the background
  amass enum -passive -d "$domain" -config "$config" -silent -o "amass-$domain.txt" &

  # Run subfinder in the background
  subfinder -d "$domain" -all -silent -o "subfinder-$domain.txt" &

  # Wait for both tasks to complete
  wait

  # Remove tmp files.
  rm "amass-$domain.txt" "subfinder-$domain.txt"


  # Execute the sort command
  sort -u "subfinder-$domain.txt" "amass-$domain.txt" -o "tools-subs-$domain.txt"
  echo "Find subdomains by tools for $domain Done." | notify 
  echo "Subdomain discovery completed. Results saved in tools-subs-$domain.txt"
}

