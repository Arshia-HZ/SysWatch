i#!/bin/bash

# Get subnet from user input
read -p "Enter subnet to scan (e.g. 192.168.1.0/24): " subnet

# Scan subnet for open ports and save results to a file
nmap -p- $subnet -oG - | awk '/Up$/{print $2}' | while read ip; do nmap -p- $ip -oG - | awk '/open/{print "'$ip',"$2}'; done > devices.csv

echo "Scan complete. Results saved to devices.csv"
