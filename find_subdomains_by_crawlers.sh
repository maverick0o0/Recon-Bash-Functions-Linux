
find_subdomains_by_crawlers(){
    welcome
    if [[ -z "$1" ]]; then
    print_color 36 "Usage: filename <domain>"
    print_color 36 "Discover subdomains using crawlers (katana , gospider)."
    print_color 36 "Arguments:"
    print_color 36 "  <domain>       Domain name to discover subdomains for."
    print_color 36 "Use http:// or https://"
    return 0
    fi
    
    # Get the domain from the user
    local domain="$1"
    # User input is https://domain.tld we need just domain.tld
    local domain_name=$(echo $1 | sed 's|http[s]*://||')
    
    # Using gospider
    print_color 33 "Running gospider..."
    gospider -s "$domain" --js -t 30 -d 3 --sitemap --robots -r | grep -Eo 'https?://[^ ]+' | sed 's/]$//' | unfurl -u domains | grep -F ".${domain_name}" >> "crawlers-subs-$domain_name.txt" &
    
    # Using katana
    print_color 34 "Running katana..."
    katana -u "$domain" -d 3 -jc -kf -iqp --json -c 40 -c 30 -silent | grep -Eo 'https?://[^ ]+' | sed 's/]$//' | unfurl -u domains | grep -F ".${domain_name}" >> "crawlers-subs-$domain_name.txt" &

        
    # wait unitl tasks complete.
    wait
    
    # Sort and create single file
    sort -u "crawlers-subs-$domain_name.txt" -o "crawlers-subs-$domain_name.txt"
    
    # Notify user.
    echo "Find subdomains by crawlers for $domain_name Done." | notify -silent
}