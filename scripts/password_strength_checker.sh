#!/bin/bash

# Colors
GREEN="\e[32m"
RED="\e[31m"
YELLOW="\e[33m"
RESET="\e[0m"

# Common weak passwords
WEAK_PASSWORDS=("password" "123456" "admin" "qwerty" "letmein")

read -sp "Enter password: " password
echo

# Check blacklist
for weak in "${WEAK_PASSWORDS[@]}"
do
    if [[ "$password" == "$weak" ]]; then
        echo -e "${RED}This is a commonly used weak password!${RESET}"
        exit 1
    fi
done

score=0

[[ ${#password} -ge 8 ]] && ((score++))
[[ "$password" =~ [A-Z] ]] && ((score++))
[[ "$password" =~ [a-z] ]] && ((score++))
[[ "$password" =~ [0-9] ]] && ((score++))
[[ "$password" =~ [^a-zA-Z0-9] ]] && ((score++))

echo "--------------------------------"
echo "Password Score: $score / 5"

# Basic entropy estimate
entropy=$(( ${#password} * 4 ))
echo "Estimated Entropy: $entropy bits"
echo "--------------------------------"

if [ $score -eq 5 ]; then
    echo -e "${GREEN}Strength: VERY STRONG${RESET}"
elif [ $score -ge 3 ]; then
    echo -e "${YELLOW}Strength: MODERATE${RESET}"
else
    echo -e "${RED}Strength: WEAK${RESET}"
fi
