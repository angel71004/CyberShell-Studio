#!/bin/bash

# ===============================
# CyberShell Advanced Subnet Scanner
# ===============================

GREEN="\e[32m"
RED="\e[31m"
YELLOW="\e[33m"
RESET="\e[0m"

if [ "$#" -ne 1 ]; then
    echo -e "${RED}Usage: $0 <subnet>${RESET}"
    echo "Example: ./subnetscanner.sh 192.168.1.0/24"
    exit 1
fi

SUBNET=$1

echo -e "${YELLOW}Scanning subnet: $SUBNET${RESET}"
echo "--------------------------------"

# Run nmap ping scan
LIVE_HOSTS=$(nmap -sn $SUBNET | grep "Nmap scan report" | awk '{print $5}')

if [ -z "$LIVE_HOSTS" ]; then
    echo -e "${RED}No live hosts found.${RESET}"
else
    for host in $LIVE_HOSTS
    do
        echo -e "${GREEN}Live Host Found: $host${RESET}"
    done
fi

echo "--------------------------------"
echo -e "${GREEN}Scan Complete!${RESET}"
