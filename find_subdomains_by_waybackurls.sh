
find_subdomains_by_waybackurls(){
    welcome
    if [[ -z "$1" ]]; then
    print_color 36 "Usage: filename <domain>"
    print_color 36 "Discover subdomains using wayback urls (waymore , gau , waybackurls)."
    print_color 36 "Arguments:"
    print_color 36 "  <domain>       Domain name to discover subdomains for."
    print_color 31 "Please add waymore to path."
    return 0
    fi
    
    # Get the domain from the user
    local domain="$1"
    
    # Use waymore.
    print_color 208 "Starting waymore..."
    waymore -i $domain -mode U -oU "waymore-$domain.txt" &
    
    # Use gau.
    print_color 27 "Starting gau..."
    gau $domain  --subs --threads 5 --o "gau-$domain.txt" &
    
    # Use waybackurls.
    print_color 129 "Starting waybackurls..."
    waybackurls $domain > "waybackurls-$domain.txt" &
    
    # Echo message
    print_color 31 "It takes some time , smoke a cigarette..."
    
    # Wait for tasks to complete.
    wait
    
    # Echo commands result.
    print_color 208 "waymore DONE."
    print_color 27 "gau DONE."
    print_color 129 "waybackurls DONE."
    
    
    # Create a result file.
    sort -u "gau-$domain.txt" "waybackurls-$domain.txt" "waymore-$domain.txt" -o "archiveMachine-results-$domain.txt"
    
    # Removing created files.
    print_color 31 'Removing "gau-$domain.txt" , "waybackurls-$domain.txt" , "waymore-$domain.txt" '
    rm "gau-$domain.txt" "waybackurls-$domain.txt" "waymore-$domain.txt"
    
    print_color 31 "Extracting URLs for $domain"
    # Extract URLs from result file.
    cat archiveMachine-results-$domain.txt | grep -F ".$domain" | unfurl -u domain | sort -u -o "archiveMachine-subs-$domain.txt"
    
    # Notify user.
    echo "Find subdomains by waybackurls for $domain Done." | notify -silent
}