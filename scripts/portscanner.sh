#!/bin/bash

# ===============================
# CyberShell Advanced Port Scanner
# ===============================

# Colors
GREEN="\e[32m"
RED="\e[31m"
YELLOW="\e[33m"
RESET="\e[0m"

# Check arguments
if [ "$#" -lt 3 ]; then
    echo -e "${RED}Usage: $0 <target> <start_port> <end_port> [fast|slow]${RESET}"
    exit 1
fi

TARGET=$1
START_PORT=$2
END_PORT=$3
MODE=${4:-fast}   # Default mode is fast

# Log file
LOG_FILE="scan_results_$(date +%Y%m%d_%H%M%S).txt"

# IP Validation
is_valid_ip() {
    local ip=$1
    [[ $ip =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]]
}

if ! is_valid_ip "$TARGET"; then
    echo -e "${RED}Invalid IP address.${RESET}"
    exit 1
fi

# Validate ports
if ! [[ "$START_PORT" =~ ^[0-9]+$ ]] || ! [[ "$END_PORT" =~ ^[0-9]+$ ]] || [ "$START_PORT" -gt "$END_PORT" ]; then
    echo -e "${RED}Invalid port range.${RESET}"
    exit 1
fi

# Timeout based on mode
if [ "$MODE" == "slow" ]; then
    TIMEOUT=2
    echo -e "${YELLOW}Running in SLOW mode...${RESET}"
else
    TIMEOUT=1
    echo -e "${YELLOW}Running in FAST mode...${RESET}"
fi

echo "Scanning $TARGET from port $START_PORT to $END_PORT..."
echo "Results will be saved in $LOG_FILE"
echo "----------------------------------------" | tee -a $LOG_FILE

# Scan loop
for (( port=$START_PORT; port<=$END_PORT; port++ ))
do
    timeout $TIMEOUT bash -c "echo > /dev/tcp/$TARGET/$port" 2>/dev/null
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}Port $port is OPEN${RESET}"
        echo "Port $port is OPEN" >> $LOG_FILE
    fi
done

echo "----------------------------------------" >> $LOG_FILE
echo -e "${GREEN}Scan Complete! Results saved in $LOG_FILE${RESET}"
