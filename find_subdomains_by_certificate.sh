find_subdomains_by_certificate() {
    welcome
  # Check if the script is invoked without arguments
    if [[ -z "$1" ]]; then
        print_color "36" "Usage: filename <domain>"
        print_color "36" "Discover subdomains using certificate search(crt.sh database , tls.bufferover.run)"
        print_color "36" "Arguments:"
        print_color "36" "  <domain>       Domain name to discover subdomains for."
        return 0
    fi
    #Get domain from user.
    domain_name=$1
    
    #Using tls.bufferover.run to search for certificates.
    print_color 31 "Curl to tls.bufferover ..."
    curl "https://tls.bufferover.run/dns?q=$domain_name" -H 'x-api-key: W9Wb4097sc6Pgp1v7ljp2aStTSOlClhN7UD4IHb6' | jq -r '.Results[]' | cut -d ',' -f5 | grep -F ".$domain_name" >> certificate-search-by-providers-$domain_name.txt &
    
    #Using crt.sh database to search for certificates.
    print_color 31 "Cennecting to crt.sh DB ..."
    query=$(cat <<-END
        SELECT
            ci.NAME_VALUE
        FROM
            certificate_and_identities ci
        WHERE
            plainto_tsquery('certwatch', '$domain_name') @@ identities(ci.CERTIFICATE)
END
    )

    echo "$query" | psql -t -h crt.sh -p 5432 -U guest certwatch | sed 's/ //g' | egrep ".*.\.$domain_name" | sed 's/*\.//g' | tr '[:upper:]' '[:lower:]' >> certificate-search-by-providers-$domain_name.txt &

    # Remove dups.
    sort -u certificate-search-by-providers-$domain_name.txt -o certificate-search-subs-$domain_name.txt
    
    echo "Find subdomain by certificate search for $domain_name Done." | notify
    
}