# Show public IP info as JSON
alias public-ip='curl https://ifconfig.co/json; printf "\n"'

if [[ "$OSTYPE" == darwin* ]]; then
  # Flush DNS cache
  flush-dns-cache() {
    sudo dscacheutil -flushcache
    sudo killall -HUP mDNSResponder
    echo "DNS cache flushed"
  }
fi
