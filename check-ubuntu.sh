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
  ip addr show $interface | awk '/inet / {print $2}' | cut -d/ -f1 | head -n1
}

echo "$(lsb_release -d | cut -f2) ($(uname -r) $(uname -m))"
echo ""
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
echo "  IP address for eth1:            $(ip addr show eth1 | grep 'inet ' | awk '{print $2}' | cut -d/ -f1)"
echo "  IP address for docker0:         $(ip addr show docker0 | grep 'inet ' | awk '{print $2}' | cut -d/ -f1)"
echo ""
echo ""
echo "$(apt list --upgradable 2>/dev/null | grep -v "^Listing" | wc -l) packages can be updated."
echo "$(apt list --upgradable 2>/dev/null | grep -v "^Listing" | grep -i security | wc -l) updates are security updates."
echo ""
echo ""
do-release-upgrade -c

# new_release=$(do-release-upgrade -c | grep 'New release' | awk '{print $3, $4, $5}')
# if [ -n "$new_release" ]; then
#   echo "New release '$new_release' available."
#   echo "Run 'do-release-upgrade' to upgrade to it."
# else
#   echo "No new release available."
# fi
# do-release-upgrade -c | sed -n '2p;3p'
