#!/bin/bash
#################################################################################
# Script
#     cpu.sh
# Description
#     Checks CPU usage on the computer.
# Declare Parameters
#     1) nMaxCpuUsage (number) - maximum allowed CPU usage (%)
# Usage
#     cpu.sh nMaxCpuUsage
# Sample
#     cpu.sh 70
#################################################################################


nMaxCpuUsage=$1

# Validate number of arguments
if [ $# -ne 1 ] ; then
  echo "UNCERTAIN: Invalid number of arguments - Usage: cpu nMaxCpuUsage"
  exit 1
fi

# Validate numeric parameter nMaxCpuUsage
regExpNumber='^[0-9]+$'
if ! [[ $1 =~ $regExpNumber ]] ; then
  echo "UNCERTAIN: Invalid argument: nMaxCpuUsage (number expected)"
  exit 1
fi

# Check the CPU usage
nCpuLoadPercentage=`ps -A -o pcpu | tail -n+2 | paste -sd+ | bc`
nCpuLoadPercentage=$( echo "$nCpuLoadPercentage / 1" | bc )

if [ $nCpuLoadPercentage -le $nMaxCpuUsage ] ; then
  echo "SUCCESS: CPU usage is [$nCpuLoadPercentage%], minimum allowed=[$1%] DATA:$nCpuLoadPercentage"
else
  echo "ERROR: CPU usage is [$nCpuLoadPercentage%], minimum allowed=[$1%] DATA:$nCpuLoadPercentage"
fi

exit 0
