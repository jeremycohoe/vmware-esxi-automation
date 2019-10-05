Set-PowerCLIConfiguration -InvalidCertificateAction Ignore -Confirm:$false
Connect-VIServer "10.10.10.10" -User "administrator@vsphere.local" -Password "your_password_here"

$VMs=("CSR-*-POD-*","WLC-*-POD-*")

foreach ($VM in $VMs) {

# Shut Down VMs:
Stop-VM -VM $VM -Confirm:$false
Start-Sleep 10

# Start Up the VM:
Start-VM $VM -Confirm:$false
Start-Sleep 10
}

Disconnect-VIServer -Confirm:$false
