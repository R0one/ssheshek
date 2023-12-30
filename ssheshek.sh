#!/bin/bash
ReallocatedSectorCt=$(smartctl -a -j $0 | jq '.ata_smart_attributes.table[] | select(.name=="Reallocated_Sector_Ct") | .raw.value')
Current_Pending_Sector=$(smartctl -a -j $0 | jq '.ata_smart_attributes.table[] | select(.name == "Current_Pending_Sector") | .raw.value')
