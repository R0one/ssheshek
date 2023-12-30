#!/bin/bash

ReallocatedSectorCt=$(smartctl -a -j $1 | jq '.ata_smart_attributes.table[] | select(.name=="Reallocated_Sector_Ct") | .raw.value')

if [ $? -ne 0 ] ; then exit 1 ; fi

if [[ "$ReallocatedSectorCt" -ne "0" ]]
then
  exit 2
fi

Current_Pending_Sector=$(smartctl -a -j $1 | jq '.ata_smart_attributes.table[] | select(.name == "Current_Pending_Sector") | .raw.value')

if [ $? -ne 0 ] ; then exit 1 ; fi

if [[ "$Current_Pending_Sector" -ne 0 ]]
then
  exit 3
fi

exit 0
