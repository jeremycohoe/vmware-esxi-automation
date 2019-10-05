Import-Module ./InstantClone.psm1
Set-PowerCLIConfiguration -InvalidCertificateAction Ignore -Confirm:$false
Connect-VIServer "10.10.10.10" -User "administrator@vsphere.local" -Password "your_password_here"

#######################
# Remove legacy VM's? #
#######################
$VMs=("Ubuntu-200-POD-*")
foreach ($VM in $VMs) {
Stop-VM -VM $VM -Confirm:$false
Remove-VM $VM -DeletePermanently -Confirm:$false
}
#exit

#############
# VARIABLES #
#############
foreach ($i in 16..30) {
$newVMName = "Ubuntu-200-POD-$i"
$VMHost = '10.10.10.200'
$SourceVM = "SourceVM-Ubuntu1612-200"
$VNETWORKNAME="POD$i"

$guestCustomizationValues = @{
"guestinfo.ic.hostname" = "$newVMName"
"guestinfo.ic.podid" = "POD-$i"
}

##############
# CLONE IT ! #
##############
$StartTime = Get-Date
Write-host ""
# Create Instant Clone
New-InstantClone -SourceVM $SourceVM -DestinationVM $newVMName -CustomizationFields $guestCustomizationValues

################
# CUSTOMIZE IT #
################
# Retrieve newly created Instant Clone
$VM = Get-VM -Name $newVMName
# Update networking:
Write-Host "`t UPDATING NETWORK ADAPTERS"
Get-NetworkAdapter -VM $newVMName | where {$_.Name -eq "Network adapter 1"} | Set-NetworkAdapter -Connected $true -NetworkName "VM Network" -Confirm:$false
Get-NetworkAdapter -VM $newVMName | where {$_.Name -eq "Network adapter 2"} | Set-NetworkAdapter -Connected $true -NetworkName $VNETWORKNAME -Confirm:$false
invoke-vmscript -RunAsync -VM $newVMName -ScriptText "/home/auto/set_network.sh" -GuestUser auto -GuestPassword prog@labrocks -scripttype Bash

# End of loop
}

###########
### END ###
###########
$EndTime = Get-Date
$duration = [math]::Round((New-TimeSpan -Start $StartTime -End $EndTime).TotalMinutes,2)
Write-Host -ForegroundColor Cyan  "`nTotal Instant Clones: $numOfVMs"
Write-Host -ForegroundColor Cyan  "StartTime: $StartTime"
Write-Host -ForegroundColor Cyan  "  EndTime: $EndTime"
Write-Host -ForegroundColor Green " Duration: $duration minutes"
