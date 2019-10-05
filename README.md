# vmware-esxi-automation
Scripts used to clone, instant clone, configure, and reset VM hosts for GOLD Programmability Labs


## setup_vlans.ps1
Use this script to setup the VirtualPortGroups on the ESXi hosts

## csr.ps1 and wlc.ps1
These 2 scripts will take a Template VM that is powered off and create the defined number of new VM's from the template.

## reset_csr_wlc.ps1
Since the CSR and WLC VM's run with their disks in Non-Persistent mode, there is a need to reset the VM's back to their original state. This script will power off then power on the VM's returning the disk to the original state.

## windows.ps1
This script will take the powered-on Source Windows VM and use the InstantClone PS Module to create instant clones. Before running this script, manually freeze the VM with the vmware.rpctool if desired. Once the new instant clone VMs are up the invoke-vmscript API is called to reset the network adapter and ping some hosts

## ubuntu.ps1
Similar to the Windows script, the Ubuntu script will take the powered-on VM and use the InstantClone module to create instant clones. Once the clones are up the invoke-vmscript API is called which calls a bash script on the Ubuntu host which reconfigures the network and some services.
