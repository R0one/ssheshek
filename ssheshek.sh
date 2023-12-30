#!/bin/bash

SMARTCTL_COMMAND="${SMARTCTL_COMMAND:-smartctl}"

set -o pipefail

ReallocatedSectorCt=$($SMARTCTL_COMMAND -a -j $1 | jq '.ata_smart_attributes.table[] | select(.name=="Reallocated_Sector_Ct") | .raw.value')

if (( $? > 0 )) ; then exit 1 ; fi

if [[ "$ReallocatedSectorCt" -ne "0" ]]
then
  exit 2
fi

Current_Pending_Sector=$($SMARTCTL_COMMAND -a -j $1 | jq '.ata_smart_attributes.table[] | select(.name == "Current_Pending_Sector") | .raw.value')

if (( $? > 0 )) ; then exit 1 ; fi

if [[ "$Current_Pending_Sector" -ne 0 ]]
then
  exit 3
fi

exit 0
