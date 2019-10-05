# Script to create the VLAN's on the vSwitch on each of the hosts:
Connect-VIServer "10.10.10.10" -User "administrator@vsphere.local" -Password "your_password_here"
 
$vSwitch = "vSwitch1"
$vmhosts = Get-VMhost

ForEach ($vmhost in $vmhosts)
{
Get-VirtualSwitch -VMhost $vmhost -Name $vSwitch | New-VirtualPortGroup -Name POD1 -VlanId 21
Get-VirtualSwitch -VMhost $vmhost -Name $vSwitch | New-VirtualPortGroup -Name POD2 -VlanId 22
Get-VirtualSwitch -VMhost $vmhost -Name $vSwitch | New-VirtualPortGroup -Name POD3 -VlanId 23
Get-VirtualSwitch -VMhost $vmhost -Name $vSwitch | New-VirtualPortGroup -Name POD4 -VlanId 24
Get-VirtualSwitch -VMhost $vmhost -Name $vSwitch | New-VirtualPortGroup -Name POD5 -VlanId 25
Get-VirtualSwitch -VMhost $vmhost -Name $vSwitch | New-VirtualPortGroup -Name POD6 -VlanId 26
Get-VirtualSwitch -VMhost $vmhost -Name $vSwitch | New-VirtualPortGroup -Name POD7 -VlanId 27
Get-VirtualSwitch -VMhost $vmhost -Name $vSwitch | New-VirtualPortGroup -Name POD8 -VlanId 28
Get-VirtualSwitch -VMhost $vmhost -Name $vSwitch | New-VirtualPortGroup -Name POD9 -VlanId 29
Get-VirtualSwitch -VMhost $vmhost -Name $vSwitch | New-VirtualPortGroup -Name POD10 -VlanId 30
Get-VirtualSwitch -VMhost $vmhost -Name $vSwitch | New-VirtualPortGroup -Name POD11 -VlanId 31
Get-VirtualSwitch -VMhost $vmhost -Name $vSwitch | New-VirtualPortGroup -Name POD12 -VlanId 32
Get-VirtualSwitch -VMhost $vmhost -Name $vSwitch | New-VirtualPortGroup -Name POD13 -VlanId 33
Get-VirtualSwitch -VMhost $vmhost -Name $vSwitch | New-VirtualPortGroup -Name POD14 -VlanId 34
Get-VirtualSwitch -VMhost $vmhost -Name $vSwitch | New-VirtualPortGroup -Name POD15 -VlanId 35
Get-VirtualSwitch -VMhost $vmhost -Name $vSwitch | New-VirtualPortGroup -Name POD16 -VlanId 36
Get-VirtualSwitch -VMhost $vmhost -Name $vSwitch | New-VirtualPortGroup -Name POD17 -VlanId 37
Get-VirtualSwitch -VMhost $vmhost -Name $vSwitch | New-VirtualPortGroup -Name POD18 -VlanId 38
Get-VirtualSwitch -VMhost $vmhost -Name $vSwitch | New-VirtualPortGroup -Name POD19 -VlanId 39
Get-VirtualSwitch -VMhost $vmhost -Name $vSwitch | New-VirtualPortGroup -Name POD20 -VlanId 40
Get-VirtualSwitch -VMhost $vmhost -Name $vSwitch | New-VirtualPortGroup -Name POD21 -VlanId 41
Get-VirtualSwitch -VMhost $vmhost -Name $vSwitch | New-VirtualPortGroup -Name POD22 -VlanId 42
Get-VirtualSwitch -VMhost $vmhost -Name $vSwitch | New-VirtualPortGroup -Name POD23 -VlanId 43
Get-VirtualSwitch -VMhost $vmhost -Name $vSwitch | New-VirtualPortGroup -Name POD24 -VlanId 44
Get-VirtualSwitch -VMhost $vmhost -Name $vSwitch | New-VirtualPortGroup -Name POD25 -VlanId 45
Get-VirtualSwitch -VMhost $vmhost -Name $vSwitch | New-VirtualPortGroup -Name POD26 -VlanId 46
Get-VirtualSwitch -VMhost $vmhost -Name $vSwitch | New-VirtualPortGroup -Name POD27 -VlanId 47
Get-VirtualSwitch -VMhost $vmhost -Name $vSwitch | New-VirtualPortGroup -Name POD28 -VlanId 48
Get-VirtualSwitch -VMhost $vmhost -Name $vSwitch | New-VirtualPortGroup -Name POD29 -VlanId 49
Get-VirtualSwitch -VMhost $vmhost -Name $vSwitch | New-VirtualPortGroup -Name POD30 -VlanId 50
Get-VirtualSwitch -VMhost $vmhost -Name $vSwitch | New-VirtualPortGroup -Name POD31 -VlanId 51
Get-VirtualSwitch -VMhost $vmhost -Name $vSwitch | New-VirtualPortGroup -Name POD32 -VlanId 52
Get-VirtualSwitch -VMhost $vmhost -Name $vSwitch | New-VirtualPortGroup -Name POD33 -VlanId 53
Get-VirtualSwitch -VMhost $vmhost -Name $vSwitch | New-VirtualPortGroup -Name POD34 -VlanId 54
Get-VirtualSwitch -VMhost $vmhost -Name $vSwitch | New-VirtualPortGroup -Name POD35 -VlanId 55
Get-VirtualSwitch -VMhost $vmhost -Name $vSwitch | New-VirtualPortGroup -Name POD36 -VlanId 56
Get-VirtualSwitch -VMhost $vmhost -Name $vSwitch | New-VirtualPortGroup -Name POD37 -VlanId 57
Get-VirtualSwitch -VMhost $vmhost -Name $vSwitch | New-VirtualPortGroup -Name POD38 -VlanId 58
Get-VirtualSwitch -VMhost $vmhost -Name $vSwitch | New-VirtualPortGroup -Name POD39 -VlanId 59
Get-VirtualSwitch -VMhost $vmhost -Name $vSwitch | New-VirtualPortGroup -Name POD40 -VlanId 60
}
