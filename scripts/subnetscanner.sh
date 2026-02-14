#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <subnet>"
    exit 1
fi

nmap -sn $1
