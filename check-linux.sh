#!/bin/bash

# Set locale to avoid locale-related errors
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

# Function to safely compute percentage
compute_percentage() {
  local used=$1
  local total=$2
  if [ "$total" -eq 0 ]; then
    echo "0%"
  else
    awk -v used="$used" -v total="$total" 'BEGIN { printf "%.0f%%", (used/total)*100 }'
  fi
}

# Function to get the first IP address of a network interface
get_first_ip() {
  local interface=$1
  # Use 'ip' command if available (Linux), fallback to 'ifconfig' (Unix-like)
  if command -v ip &> /dev/null; then
    ip addr show $interface | awk '/inet / {print $2}' | cut -d/ -f1 | head -n1
  elif command -v ifconfig &> /dev/null; then
    ifconfig $interface | awk '/inet / {print $2}' | cut -d: -f2 | head -n1
  else
    echo "N/A"
  fi
}

# Function to get the number of upgradable packages
count_upgradable_packages() {
  # Use 'apt' on Debian-based systems, 'yum' on Red Hat-based, fallback to generic 'rpm' if available
  if command -v apt &> /dev/null; then
    apt list --upgradable 2>/dev/null | grep -v "^Listing" | wc -l
  elif command -v yum &> /dev/null; then
    yum check-update --quiet | grep -v "^$" | wc -l
  elif command -v rpm &> /dev/null; then
    rpm -qa --qf "%{NAME}\n" | wc -l
  else
    echo "N/A"
  fi
}

# Main script
echo "$(lsb_release -d 2>/dev/null || echo "Description: $(uname -s)") ($(uname -r) $(uname -m))"
echo ""
echo "  System information as of $(date)"
echo ""
echo "  System load:                   $(uptime | awk -F'[a-z]:' '{ print $2}' | cut -d, -f1)"
echo "  Usage of /:                     $(df -h / | awk 'NR==2 {print $5}') of $(df -h / | awk 'NR==2 {print $2}')"
mem_used=$(free -m | awk 'NR==2{print $3}')
mem_total=$(free -m | awk 'NR==2{print $2}')
swap_used=$(free -m | awk 'NR==3{print $3}')
swap_total=$(free -m | awk 'NR==3{print $2}')
echo "  Memory usage:                   $(compute_percentage $mem_used $mem_total)"
echo "  Swap usage:                     $(compute_percentage $swap_used $swap_total)"
echo "  Processes:                      $(ps -e | wc -l)"
echo "  Users logged in:                $(who | wc -l)"
echo "  IP address for eth0:            $(get_first_ip eth0)"
echo "  IP address for eth1:            $(get_first_ip eth1)"
echo "  IP address for docker0:         $(get_first_ip docker0)"
echo ""
echo "$(count_upgradable_packages) packages can be updated."
echo "$(count_upgradable_packages | grep -i security | wc -l) updates are security updates."
echo ""
echo ""
do-release-upgrade -c
