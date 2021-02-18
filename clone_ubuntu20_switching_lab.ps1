#!/snap/bin/powershell
# Script to clone VM's for SJC13 GOLD - IOS XE Programmability POD's
# Jeremy Cohoe - jcohoe@cisco.com - 3JULY2020
Import-Module ./InstantClone.psm1
Set-PowerCLIConfiguration -InvalidCertificateAction Ignore -Confirm:$false
Connect-VIServer "10.10.10.10" -User "administrator" -Password "password_here"
$StartTime = Get-Date

#######################
# Remove legacy VM's? #
#######################

$VMs=("P*-Ubuntu20")
foreach ($VM in $VMs) {
Stop-VM -VM $VM -Confirm:$false
Remove-VM $VM -DeletePermanently -Confirm:$false
}

#################################
## Shutdown source VM #
#################################
$SourceVM = "SOURCEVM-Ubuntu20-UCS14"
Stop-VM -VM $SourceVM -Confirm:$false
Start-Sleep 10

# Copy the SourceVM to the new host:
New-VM -Name "P01-Ubuntu20" -VM $SourceVM -VMHost 128.107.211.7 -Datastore "datastore_one"
Start-VM -Confirm:$false -VM "P01-Ubuntu20"

New-VM -Name "P02-Ubuntu20" -VM $SourceVM -VMHost 128.107.211.8 -Datastore "datastore2"
Start-VM -Confirm:$false -VM "P02-Ubuntu20""

New-VM -Name "P03-Ubuntu20" -VM $SourceVM -VMHost 128.107.211.9 -Datastore "datastore3"
Start-VM -Confirm:$false -VM "P03-Ubuntu20

New-VM -Name "P04-Ubuntu20" -VM $SourceVM -VMHost 128.107.211.10 -Datastore "datastore4"
Start-VM -Confirm:$false -VM "P04-Ubuntu20"

New-VM -Name "P05-Ubuntu20" -VM $SourceVM -VMHost 128.107.211.11 -Datastore "datastore5"
Start-VM -Confirm:$false -VM "P05-Ubuntu20"

New-VM -Name "P06-Ubuntu20" -VM $SourceVM -VMHost 128.107.211.12 -Datastore "datastore6"
Start-VM -Confirm:$false -VM "P06-Ubuntu20"

New-VM -Name "P07-Ubuntu20" -VM $SourceVM -VMHost 128.107.211.13 -Datastore "datastore7"
Start-VM -Confirm:$false -VM "P07-Ubuntu20"

New-VM -Name "P08-Ubuntu20" -VM $SourceVM -VMHost 128.107.211.14 -Datastore "datastore8"
Start-VM -Confirm:$false -VM "P08-Ubuntu20"

New-VM -Name "P09-Ubuntu20" -VM $SourceVM -VMHost 128.107.211.15 -Datastore "datastore9"
Start-VM -Confirm:$false -VM "P09-Ubuntu20"

New-VM -Name "P10-Ubuntu20" -VM $SourceVM -VMHost 128.107.211.16 -Datastore "datastore10"
Start-VM -Confirm:$false -VM "P10-Ubuntu20"
