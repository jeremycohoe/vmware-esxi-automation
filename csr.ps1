Import-Module ./InstantClone.psm1
Set-PowerCLIConfiguration -InvalidCertificateAction Ignore -Confirm:$false
Connect-VIServer "10.10.10.10" -User "administrator@vsphere.local" -Password "your_password_here"

#######################
# Remove legacy VM's? #
#######################
$VMs=("CSR-197-POD-*")
foreach ($VM in $VMs) {
Stop-VM -VM $VM -Confirm:$false
Remove-VM $VM -DeletePermanently -Confirm:$false
}
$VMs=("CSR-198-POD-*")
foreach ($VM in $VMs) {
Stop-VM -VM $VM -Confirm:$false
Remove-VM $VM -DeletePermanently -Confirm:$false
}
#exit

#############
# VARIABLES #
#############
# Which pod numbers to clone to?
foreach ($i in 1..15) {

# Select source VM to use as template
$newVMName = "CSR-197-POD-$i"
$VMHost = '10.10.10.197'
$Template = Get-Template -Name 'TemplateCSR1612197'
$VNETWORKNAME="POD$i"

##############
# CLONE IT ! #
##############
$StartTime = Get-Date
Write-host ""
# Create Clone from Template
New-VM -Name $newVMName -Template $Template -VMHost $VMHost

#################
# Set disk mode #
#################
# Set disk to RW
# Get-VM $VM | Get-HardDisk | Set-HardDisk  -Confirm:$false -Persistence "IndependentPersistent"
# # Set disk to RO
Get-VM $newVMname | Get-HardDisk | Set-HardDisk  -Confirm:$false -Persistence "IndependentNonPersistent"

############
# Start VM #
############
Start-VM $newVMName -Confirm:$false
sleep 5

################
# CUSTOMIZE IT #
################
# Retrieve newly created Instant Clone
$VM = Get-VM -Name $newVMName
# Update networking:
Write-Host "`t UPDATING NETWORK ADAPTERS"
Get-NetworkAdapter -VM $newVMName | where {$_.Name -eq "Network adapter 1"} | Set-NetworkAdapter -StartConnected $true -Connected $true -NetworkName $VNETWORKNAME -Confirm:$false
Get-NetworkAdapter -VM $newVMName | where {$_.Name -eq "Network adapter 2"} | Set-NetworkAdapter -StartConnected $false -Connected $false -NetworkName $VNETWORKNAME -Confirm:$false
Get-NetworkAdapter -VM $newVMName | where {$_.Name -eq "Network adapter 3"} | Set-NetworkAdapter -StartConnected $false -Connected $false -NetworkName $VNETWORKNAME -Confirm:$false

# End of loop
}

#######################################
# RUN IT ALL AGAIN FOR THE OTHER HOST #
#######################################

#############
# VARIABLES #
#############
# Which pod numbers to clone to?
foreach ($i in 16..30) {

# Select source VM to use as template
$newVMName = "CSR-198-POD-$i"
$VMHost = '10.10.10.198'
$Template = Get-Template -Name 'TemplateCSR1612198'
$VNETWORKNAME="POD$i"

##############
# CLONE IT ! #
##############
$StartTime = Get-Date
Write-host ""
# Create Clone from Template
New-VM -Name $newVMName -Template $Template -VMHost $VMHost

#################
# Set disk mode #
#################
# Set disk to RW
# Get-VM $VM | Get-HardDisk | Set-HardDisk  -Confirm:$false -Persistence "IndependentPersistent"
# # Set disk to RO
Get-VM $newVMname | Get-HardDisk | Set-HardDisk  -Confirm:$false -Persistence "IndependentNonPersistent"

############
# Start VM #
############
Start-VM $newVMName -Confirm:$false
sleep 5

################
# CUSTOMIZE IT #
################
# Retrieve newly created Instant Clone
$VM = Get-VM -Name $newVMName
# Update networking:
Write-Host "`t UPDATING NETWORK ADAPTERS"
Get-NetworkAdapter -VM $newVMName | where {$_.Name -eq "Network adapter 1"} | Set-NetworkAdapter -StartConnected $true -Connected $true -NetworkName $VNETWORKNAME -Confirm:$false
Get-NetworkAdapter -VM $newVMName | where {$_.Name -eq "Network adapter 2"} | Set-NetworkAdapter -StartConnected $false -Connected $false -NetworkName $VNETWORKNAME -Confirm:$false
Get-NetworkAdapter -VM $newVMName | where {$_.Name -eq "Network adapter 3"} | Set-NetworkAdapter -StartConnected $false -Connected $false -NetworkName $VNETWORKNAME -Confirm:$false

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
