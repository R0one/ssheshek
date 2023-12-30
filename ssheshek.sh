#!/bin/bash

ReallocatedSectorCt=$(smartctl -a -j $1 | jq '.ata_smart_attributes.table[] | select(.name=="Reallocated_Sector_Ct") | .raw.value')

if [[ "$ReallocatedSectorCt" -ne "0" ]]
then
  return 1
fi

Current_Pending_Sector=$(smartctl -a -j $1 | jq '.ata_smart_attributes.table[] | select(.name == "Current_Pending_Sector") | .raw.value')

if [[ "$Current_Pending_Sector" -ne 0 ]]
then
  return 2
fi

return 0
