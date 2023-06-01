All-In-One
A collection of automation scripts for routine tasks.

Description
This repository contains a set of automation scripts that are designed to streamline various routine tasks. Each script focuses on a specific task and automates it to save time and effort. Whether it's counting lines in a file, printing colored text, or finding subdomains using different methods, this collection has you covered.

Tools
1. line_count.sh
Description: This script counts the number of lines in a given file.
Usage: line_count.sh <filename>
Example: line_count.sh file.txt
2. welcome.sh
Description: This script displays a welcome message.
Usage: welcome.sh
Example: welcome.sh
3. print_color.sh
Description: This script prints text in different colors.
Usage: print_color.sh <color> <text>
Example: print_color.sh green "Hello, world!"
4. find_subdomains_by_waybackurls.sh
Description: This script finds subdomains of a domain using the Wayback Machine's archived URLs.
Usage: find_subdomains_by_waybackurls.sh <domain>
Example: find_subdomains_by_waybackurls.sh example.com
5. find_subdomains_by_tools.sh
Description: This script finds subdomains of a domain using various tools (Amass, Subfinder).
Usage: find_subdomains_by_tools.sh <domain>
Example: find_subdomains_by_tools.sh example.com
6. find_subdomains_by_providers.sh
Description: This script finds subdomains of a domain by querying DNS providers.
Usage: find_subdomains_by_providers.sh <domain>
Example: find_subdomains_by_providers.sh example.com
7. find_subdomains_by_crawlers.sh
Description: This script finds subdomains of a domain by crawling web pages.
Usage: find_subdomains_by_crawlers.sh <domain>
Example: find_subdomains_by_crawlers.sh example.com
8. find_subdomains_by_certificate.sh
Description: This script finds subdomains of a domain using SSL/TLS certificate information.
Usage: find_subdomains_by_certificate.sh <domain>
Example: find_subdomains_by_certificate.sh example.com
Installation
Clone this repository to your local machine: git clone <repository-url>
Navigate to the cloned directory: cd All-In-One
Usage
Ensure that the required dependencies/tools are installed for each script.
Source the necessary files by running source All-In-One.sh from the cloned directory.
Run the desired script with the appropriate parameters as explained in the individual tool sections above.
Contributing
Contributions are welcome! If you have ideas for additional automation scripts or improvements to existing ones, please open an issue or submit a pull request.
