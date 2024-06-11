# Dig support Linux, macOS or Unix

dig +short myip.opendns.com @resolver1.opendns.com

# dig TXT +short o-o.myaddr.l.google.com @ns1.google.com
# dig TXT +short ch whoami.cloudflare @1.0.0.1

# host myip.opendns.com resolver1.opendns.com
# dig TXT +short o-o.myaddr.l.google.com @ns1.google.com | awk -F'"' '{ print $2}'


# Use third party web-sites to get Public IP

# curl checkip.amazonaws.com
# curl ifconfig.me
# curl icanhazip.com
# curl ipecho.net/plain
# curl ifconfig.co
