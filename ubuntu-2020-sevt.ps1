#!/snap/bin/powershell
# Script to clone VM's for SJC13 GOLD - IOS XE Programmability POD's SEVT Event Q3CY20 
# Jeremy Cohoe - jcohoe@cisco.com - 3JULY2020

Import-Module ./InstantClone.psm1
Set-PowerCLIConfiguration -InvalidCertificateAction Ignore -Confirm:$false
Connect-VIServer "192.168.100.250" -User "<<USERNAME HERE>>" -Password "<<PASSWORD HERE>>"
$StartTime = Get-Date

#######################
# Remove legacy VM's? #
#######################
$VMs=("Ubuntu-197-POD-*")
foreach ($VM in $VMs) {
Stop-VM -VM $VM -Confirm:$false
Remove-VM $VM -DeletePermanently -Confirm:$false
}
Write-host "`n Delay after removing old clones..."
Start-Sleep 180
Write-host "Done sleeping..."
#exit

#################################
## Freeze the source VM first ! #
#################################
#$SourceVM = "SOURCEVM-ubuntu-UCS197"
## GuestPassword variable here !
#Write-host ""
#Write-host "Start Source VM and Invoking VMScript freeze.sh to freeze the source VM"
#Write-host ""
#Start-VM $SourceVM -Confirm:$false
#Start-Sleep 120
#invoke-vmscript -RunAsync -VM $SourceVM -ScriptText "/home/auto/scripts/freeze.sh" -GuestUser auto -GuestPassword <<PASSWORD HERE>> -scripttype Bash
#Start-Sleep 10

##############
# VARIABLES #
#############
#------- WHICH PODS TO CREATE ? ---------#
foreach ($i in 1..15) {
$newVMName = "Ubuntu-197-POD-$i"
$VMHost = '192.168.100.197'
$SourceVM = "SOURCEVM-ubuntu-UCS197"
#
# DO NOT CHANGE ANYTHING BELOW HERE #
$VNETWORKNAME="POD$i"
$guestCustomizationValues = @{
"guestinfo.ic.hostname" = "$newVMName"
"guestinfo.ic.podid" = "POD-$i"
}

##############
# CLONE IT ! #
##############
Write-host ""
Write-host "Clone the frozen SourceVM for POD $i"
New-InstantClone -SourceVM "$SourceVM" -DestinationVM "$newVMName" -CustomizationFields $guestCustomizationValues
Write-host ""
Write-host "***DONE*** POD $i New-InstantClone $SourceVM $newVMName "
Write-host ""

################
# CUSTOMIZE IT #
################
Write-host ""
Write-host "Customizing the new VM for NIC etc"
Write-host ""
# Retrieve newly created Instant Clone
$VM = Get-VM -Name $newVMName
# Update networking:
Write-Host "`t UPDATING NETWORK ADAPTERS"
Get-NetworkAdapter -VM $newVMName | where {$_.Name -eq "Network adapter 1"} | Set-NetworkAdapter -Connected $true -StartConnected $true -NetworkName "VM Network" -Confirm:$false
Get-NetworkAdapter -VM $newVMName | where {$_.Name -eq "Network adapter 2"} | Set-NetworkAdapter -Connected $true -StartConnected $true -NetworkName $VNETWORKNAME -Confirm:$false
# Run the configure networking script - this causes a __reload__ of the clone ! Review set_network.sh script if needed !
invoke-vmscript -RunAsync -VM $newVMName -ScriptText "/home/auto/scripts/set_network.sh" -GuestUser auto -GuestPassword programmability@LAB -scripttype Bash
# Delay between new POD clones:
Start-Sleep 180
# End of loop
Write-Host "`n ---- End of POD $i Loop -----"
}

###########
### END ###
###########
$EndTime = Get-Date
$duration = [math]::Round((New-TimeSpan -Start $StartTime -End $EndTime).TotalMinutes,2)
Write-Host -ForegroundColor Cyan  "`nTotal Instant Clones: $numOfVMs"
Write-Host -ForegroundColor Cyan  "StartTime: $StartTime"
Write-Host -ForegroundColor Cyan  "EndTime: $EndTime"
Write-Host -ForegroundColor Green "Duration: $duration minutes"
