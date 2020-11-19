#!/bin/bash
###################################################################
#Script Name    : check_status.sh
#Description    : Checks if a Control-M Agent and its connected
#                 Control-M Server are up from an Agent machine
#Args           :
#Exit Codes     : 1 - Agent is down
#               : 2 - Server is down/unreachable
#Author         : Bhanu Prakash Badiginchala
#Email          : bp@autosys.ltd
###################################################################

#Determine Agent status by looking for listener and tracker processes
output=$(shagent)
if echo $output | grep -q -e 'p_ctmat.*p_ctmag' -e 'p_ctmag.*p_ctmat'; then
  echo 'Agent processes are running'
else
  echo 'One or more Cotrol-M Agent processes not running'
  exit 1
fi

#Determine Server status/connectivity
output=$(ag_ping)
if [[ $? -eq 0 ]]; then
  echo 'Control-M Server is running'
else
  echo 'Failed to retrieve Control-M Server status'
  exit 2
fi