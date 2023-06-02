
find_subdomains_by_providers(){
    welcome
    if [[ -z "$1" ]]; then
    print_color 36 "Usage: filename <domain>"
    print_color 36 "Discover subdomains using providers (chaos-client , AbuseIp , SourceGraph)."
    print_color 36 "Arguments:"
    print_color 36 "  <domain>       Domain name to discover subdomains for."
    print_color 31 "Please consider that you have to add 'export CHAOS_KEY=CHAOS_API_KEY' to your env variables."
    print_color 31 "Please consider that you have to add 'export CHAOS_KEY=CHAOS_API_KEY' to your env variables."
    return 0
    fi
    
    # Get the domain from the user
    local domain="$1"
    
    # Using AbuseIp
    print_color 33 "Running abuseIp..."
    curl -s "https://www.abuseipdb.com/whois/$domain" -H "user-agent: Chrome" | grep -E '<li>\w.*</li>' | sed -E 's/<\/?li>//g' > "abuseIp-provider-$domain.txt" &
    
    # Using chaos-client
    print_color 34 "Running chaos..."
    chaos -d "$domain" > "chaos-provider-$domain.txt" & 
    
    # Using sourceGpraph
    q=$(echo $domain | sed -e 's/\./\\\./g')
    src search -json '([a-z\-]+)?:?(\/\/)?([a-zA-Z0-9]+[.])+('${q}') count:5000 fork:yes archived:yes' | jq -r '.Results[] | .lineMatches[].preview, .file.path' | grep -oiE '([a-zA-Z0-9]+[.])+('${q}')' | awk '{ print tolower($0) }' | sort -u > "sourceGraph-provider-$domain.txt" &
    
    # wait unitl tasks complete.
    wait
    
    # Sort and create single file
    sort -u "chaos-provider-$domain.txt" "abuseIp-provider-$domain.txt" "sourceGraph-provider-$domain.txt" > "providers-subs-$domain.txt"
    
    # Removing temp fiels.
    print_color 31 "Removing tmp files..."
    rm "chaos-provider-$domain.txt" "abuseIp-provider-$domain.txt" "sourceGraph-provider-$domain.txt"
    
    # Notify user.
    echo "Find subdomains by providers for $domain Done." | notify -silent
}