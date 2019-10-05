Import-Module ./InstantClone.psm1
Set-PowerCLIConfiguration -InvalidCertificateAction Ignore -Confirm:$false
Connect-VIServer "10.10.10.10" -User "administrator@vsphere.local" -Password "your_password_here"

#######################
# Remove legacy VM's? #
#######################
$VMs=("Windows-202-POD-*")
foreach ($VM in $VMs) {
Stop-VM -VM $VM -Confirm:$false
Remove-VM $VM -DeletePermanently -Confirm:$false
}
#exit

#############
# VARIABLES #
#############
foreach ($i in 1..30) {
$SourceVM = "SourceVM-Windows-202"
$newVMName = "Windows-202-POD-$i"
$VMHost = '10.10.10.202'
$VNETWORKNAME="POD$i"

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
Get-NetworkAdapter -VM $newVMName | where {$_.Name -eq "Network adapter 2"} | Set-NetworkAdapter -StartConnected $true -Connected $true -NetworkName $VNETWORKNAME -Confirm:$false
invoke-vmscript -VM $newVMName -ScriptText "netsh interface set interface OOB disable & netsh interface set interface OOB enable" -GuestUser "Admin" -GuestPassword "prog@labrocks" -scripttype bat
invoke-vmscript -VM $newVMName -ScriptText "ping 10.1.1.2 & ping 10.1.1.3 & ping 10.1.1.5" -GuestUser "Admin" -GuestPassword "prog@labrocks" -scripttype bat

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
